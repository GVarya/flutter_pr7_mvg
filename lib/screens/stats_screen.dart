import 'package:flutter/material.dart';
import '../container/plants_container.dart';
import '../widgets/app_bottom_navigation.dart';

class StatsScreen extends StatelessWidget {
  const StatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = PlantsContainer.of(context);
    final plants = container.plants;

    final totalPlants = plants.length;
    final wateredToday = plants.where((plant) =>
    plant.lastWatered.day == DateTime.now().day
    ).length;
    final needsWatering = plants.where((plant) =>
    DateTime.now().difference(plant.lastWatered).inDays > 3
    ).length;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Статистика растений'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 3,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Text(
                      'Общая статистика',
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.green.shade800,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildStatItem(
                          context,
                          'Всего растений',
                          totalPlants.toString(),
                          Icons.forest,
                          Colors.green,
                        ),
                        _buildStatItem(
                          context,
                          'Полито сегодня',
                          wateredToday.toString(),
                          Icons.water_drop,
                          Colors.blue,
                        ),
                        _buildStatItem(
                          context,
                          'Требуют полива',
                          needsWatering.toString(),
                          Icons.warning,
                          Colors.orange,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),

            if (needsWatering > 0) ...[
              Text(
                'Растения, требующие полива:',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.orange.shade800,
                ),
              ),
              const SizedBox(height: 10),
              ...plants.where((plant) =>
              DateTime.now().difference(plant.lastWatered).inDays > 3
              ).map((plant) => ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.orange.shade100,
                  child: Text(plant.name[0]),
                ),
                title: Text(plant.name),
                subtitle: Text('Последний полив: ${_formatDate(plant.lastWatered)}'),
                trailing: IconButton(
                  icon: Icon(Icons.water_drop, color: Colors.blue),
                  onPressed: () {
                    container.waterPlant(plant.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${plant.name} полито!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  },
                ),
              )),
            ],

            if (plants.isEmpty) ...[
              const Spacer(),
              Icon(
                Icons.analytics_outlined,
                size: 100,
                color: Colors.grey.shade300,
              ),
              const SizedBox(height: 20),
              Text(
                'Нет данных для статистики',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.grey.shade600,
                ),
              ),
              const Spacer(),
            ],
          ],
        ),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 3),
    );
  }

  Widget _buildStatItem(BuildContext context, String title, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          title,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year}';
  }
}