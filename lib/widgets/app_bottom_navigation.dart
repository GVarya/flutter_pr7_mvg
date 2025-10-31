import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppBottomNavigation extends StatelessWidget {
  final int currentIndex;

  const AppBottomNavigation({
    Key? key,
    required this.currentIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: Colors.green.shade700,
      unselectedItemColor: Colors.grey.shade600,
      selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.forest),
          label: 'Мои растения',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.category),
          label: 'Категории',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.eco),
          label: 'Уход',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.analytics),
          label: 'Статистика',
        ),
      ],
      onTap: (index) {
        switch (index) {
          case 0:
            context.go('/');
            break;
          case 1:
            context.go('/categories');
            break;
          case 2:
            context.go('/care-guide');
            break;
          case 3:
            context.go('/stats');
            break;
        }
      },
    );
  }
}