import 'package:flutter/material.dart';
import 'package:flutter_pr5_mvg/theme.dart';
import 'package:go_router/go_router.dart';
import 'container/plants_container.dart';
import 'screens/plants_list_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/care_guide_screen.dart';
import 'screens/plant_categories_screen.dart';

void main() {
  runApp(const MyApp());
}

final GoRouter _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const PlantsListScreen(),
    ),
    GoRoute(
      path: '/stats',
      builder: (context, state) => const StatsScreen(),
    ),
    GoRoute(
      path: '/care-guide',
      builder: (context, state) => const CareGuideScreen(),
    ),
    GoRoute(
      path: '/categories',
      builder: (context, state) => const PlantCategoriesScreen(),
    ),
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlantsContainer(
      child: MaterialApp.router(
        title: 'Учет домашних растений',
        theme: AppTheme.lightTheme,
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}