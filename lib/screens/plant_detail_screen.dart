import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
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
        title: Text(
          currentPlant.name,
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.edit, color: Colors.white),
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
            icon: Icon(Icons.delete, color: Colors.white),
            tooltip: 'Удалить',
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(
                    'Удалить растение?',
                    style: TextStyle(color: Colors.green.shade800),
                  ),
                  content: Text(
                    'Вы уверены, что хотите удалить растение "${currentPlant.name}"?',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Отмена',
                        style: TextStyle(color: Colors.grey.shade700),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        container.deletePlant(currentPlant.id, context);
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Удалить',
                        style: TextStyle(color: Colors.red.shade700),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          if (currentPlant.imageUrl != null && currentPlant.imageUrl!.isNotEmpty)
            Container(
              height: 200,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: currentPlant.imageUrl!,
                fit: BoxFit.cover,
                placeholder: (context, url) => Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                    ),
                  ),
                ),
                errorWidget: (context, url, error) => Container(
                  color: Colors.grey.shade200,
                  child: Center(
                    child: Icon(
                      Icons.photo,
                      color: Colors.grey.shade400,
                      size: 64,
                    ),
                  ),
                ),
              ),
            ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Card(
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentPlant.name,
                            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.green.shade900,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: Colors.green.shade100,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Text(
                              currentPlant.type,
                              style: TextStyle(
                                color: Colors.green.shade800,
                                fontWeight: FontWeight.w500,
                              ),
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

                          _buildInfoRow(
                            icon: Icons.water_drop,
                            iconColor: Colors.blue.shade700,
                            title: 'Последний полив:',
                            value: _formatDate(currentPlant.lastWatered),
                          ),
                          const SizedBox(height: 16),
                          _buildInfoRow(
                            icon: Icons.calendar_today,
                            iconColor: Colors.green.shade700,
                            title: 'Добавлено:',
                            value: _formatDate(currentPlant.createdAt),
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
                          content: Text(
                            'Растение "${currentPlant.name}" полито 💧',
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          backgroundColor: Colors.green.shade700,
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      );
                    },
                    icon: Icon(Icons.water_drop, size: 24),
                    label: Text(
                      'Полить растение',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                    ),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      backgroundColor: Colors.blue.shade700,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String value,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(icon, color: iconColor, size: 24),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                value,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade800,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}