import 'package:flutter/material.dart';
import '../widgets/app_bottom_navigation.dart';

class CareGuideScreen extends StatelessWidget {
  const CareGuideScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final careTips = [
      {
        'title': 'Правильный полив',
        'icon': Icons.water_drop,
        'color': Colors.blue,
        'tips': [
          'Проверяйте влажность почвы перед поливом',
          'Используйте воду комнатной температуры',
          'Избегайте перелива - это может привести к гниению корней'
        ]
      },
      {
        'title': 'Освещение',
        'icon': Icons.light_mode,
        'color': Colors.orange,
        'tips': [
          'Большинство растений любят яркий рассеянный свет',
          'Избегайте прямых солнечных лучей для чувствительных растений',
          'Поворачивайте растение для равномерного роста'
        ]
      },
      {
        'title': 'Температура и влажность',
        'icon': Icons.thermostat,
        'color': Colors.red,
        'tips': [
          'Поддерживайте температуру 18-25°C',
          'Избегайте сквозняков и резких перепадов температуры',
          'Опрыскивайте листья для увеличения влажности'
        ]
      },
      {
        'title': 'Удобрения',
        'icon': Icons.eco,
        'color': Colors.green,
        'tips': [
          'Удобряйте в период активного роста (весна-лето)',
          'Используйте специальные удобрения для комнатных растений',
          'Следуйте инструкциям на упаковке удобрения'
        ]
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Руководство по уходу'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: careTips.length,
        itemBuilder: (context, index) {
          final tip = careTips[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: tip['color'] as Color,
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          tip['icon'] as IconData,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        tip['title'] as String,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: tip['color'] as Color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...(tip['tips'] as List<String>).map((tipText) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: Colors.green.shade600,
                          size: 16,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            tipText,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ),
                      ],
                    ),
                  )).toList(),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 2),
    );
  }
}