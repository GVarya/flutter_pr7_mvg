import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../container/plants_container.dart';
import '../widgets/plant_item.dart';
import '../widgets/app_bottom_navigation.dart';

class PlantsListScreen extends StatelessWidget {
  const PlantsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final container = PlantsContainer.of(context);
    final plants = container.plants;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Мои растения'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.analytics),
            onPressed: () => context.go('/stats'),
            tooltip: 'Статистика',
          ),
        ],
      ),
      body: plants.isEmpty
          ? _buildEmptyState(context)
          : ListView.builder(
        padding: const EdgeInsets.all(8.0),
        itemCount: plants.length,
        itemBuilder: (context, index) {
          final plant = plants[index];
          return PlantItem(
            plant: plant,
            onTap: () {
              context.push('/plant/${plant.id}');
            },
            onWater: () {
              container.waterPlant(plant.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Растение "${plant.name}" полито'),
                  duration: const Duration(seconds: 2),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push('/add');
        },
        tooltip: 'Добавить растение',
        child: const Icon(Icons.add),
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 0),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.forest,
              size: 80,
              color: Colors.grey.shade300,
            ),
            const SizedBox(height: 20),
            Text(
              'У вас пока нет растений',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Добавьте первое растение, нажав на кнопку ниже',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey.shade500,
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton.icon(
              onPressed: () => context.push('/add'),
              icon: const Icon(Icons.add),
              label: const Text('Добавить растение'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green.shade700,
                foregroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            TextButton(
              onPressed: () => context.go('/care-guide'),
              child: const Text('Сначала изучите руководство по уходу'),
            ),
          ],
        ),
      ),
    );
  }
}