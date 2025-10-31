import 'package:flutter/material.dart';
import '../widgets/app_bottom_navigation.dart';

class PlantCategoriesScreen extends StatelessWidget {
  const PlantCategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = [
      {
        'name': 'Суккуленты',
        'icon': Icons.filter_vintage,
        'color': Colors.green,
        'description': 'Растения, запасающие воду в листьях',
        'examples': 'Алоэ, Кактусы, Эхеверия'
      },
      {
        'name': 'Папоротники',
        'icon': Icons.forest,
        'color': Colors.lightGreen,
        'description': 'Тенелюбивые растения с перистыми листьями',
        'examples': 'Нефролепис, Адиантум, Птерис'
      },
      {
        'name': 'Цветущие',
        'icon': Icons.local_florist,
        'color': Colors.pink,
        'description': 'Растения с декоративными цветами',
        'examples': 'Фиалки, Орхидеи, Герань'
      },
      {
        'name': 'Лианы',
        'icon': Icons.park,
        'color': Colors.teal,
        'description': 'Вьющиеся и ампельные растения',
        'examples': 'Монстера, Сциндапсус, Хойя'
      },
      {
        'name': 'Пальмы',
        'icon': Icons.palette,
        'color': Colors.brown,
        'description': 'Древовидные растения с веерными листьями',
        'examples': 'Хамедорея, Финик, Драцена'
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Категории растений'),
        backgroundColor: Colors.green.shade700,
        foregroundColor: Colors.white,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            elevation: 2,
            child: ListTile(
              leading: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: category['color'] as Color,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  category['icon'] as IconData,
                  color: Colors.white,
                ),
              ),
              title: Text(
                category['name'] as String,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category['description'] as String),
                  const SizedBox(height: 4),
                  Text(
                    'Примеры: ${category['examples']}',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
              trailing: Icon(Icons.chevron_right, color: Colors.grey.shade400),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Показать растения категории "${category['name']}"'),
                    backgroundColor: category['color'] as Color,
                  ),
                );
              },
            ),
          );
        },
      ),
      bottomNavigationBar: const AppBottomNavigation(currentIndex: 1),
    );
  }
}