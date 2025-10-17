import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../container/plants_container.dart';
import 'plant_form_screen.dart';


class PlantDetailScreen extends StatelessWidget {
  final Plant plant;

  const PlantDetailScreen({Key? key, required this.plant}) : super(key: key);

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}.${date.month.toString().padLeft(2, '0')}.${date.year} '
        '${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final container = PlantsContainer.of(context);
    final currentPlant = container.getPlantById(plant.id) ?? plant;

    return Scaffold(
      appBar: AppBar(
        title: Text(currentPlant.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            tooltip: 'Редактировать',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PlantFormScreen(plant: currentPlant),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: 'Удалить',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Удалить растение?'),
                  content: Text(
                    'Вы уверены, что хотите удалить растение "${currentPlant.name}"?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Отмена'),
                    ),
                    TextButton(
                      onPressed: () {
                        container.deletePlant(currentPlant.id, context);
                        Navigator.pop(context);
                        Navigator.pop(context);

                      },
                      child: const Text(
                        'Удалить',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      currentPlant.name,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentPlant.type,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    if (currentPlant.description != null && currentPlant.description!.isNotEmpty) ...[
                      const SizedBox(height: 16),
                      const Divider(height: 1),
                      const SizedBox(height: 16),
                      Text(
                        'Описание:',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.grey.shade700,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentPlant.description!,
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey.shade800,
                          height: 1.4,
                        ),
                      ),
                    ],
                    const Divider(height: 32),
                    Row(
                      children: [
                        const Icon(Icons.water_drop, color: Colors.blue),
                        const SizedBox(width: 8),
                        const Text(
                          'Последний полив: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(currentPlant.lastWatered),
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Icon(Icons.calendar_today, color: Colors.green),
                        const SizedBox(width: 8),
                        const Text(
                          'Добавлено: ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      _formatDate(currentPlant.createdAt),
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                container.waterPlant(currentPlant.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Растение "${currentPlant.name}" полито'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
              icon: const Icon(Icons.water_drop),
              label: const Text('Полить растение'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}