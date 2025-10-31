import 'package:go_router/go_router.dart';
import 'screens/plants_list_screen.dart';
import 'screens/plant_detail_screen.dart';
import 'screens/plant_form_screen.dart';
import 'screens/stats_screen.dart';
import 'screens/care_guide_screen.dart';
import 'screens/plant_categories_screen.dart';

final GoRouter appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      name: 'home',
      builder: (context, state) => const PlantsListScreen(),
      routes: [
        GoRoute(
          path: 'plant/:id',
          name: 'plant_detail',
          builder: (context, state) {
            final plantId = state.pathParameters['id']!;
            return PlantDetailScreen(plantId: plantId);
          },
        ),
        GoRoute(
          path: 'add',
          name: 'add_plant',
          builder: (context, state) => const PlantFormScreen(),
        ),
        GoRoute(
          path: 'edit/:id',
          name: 'edit_plant',
          builder: (context, state) {
            final plantId = state.pathParameters['id']!;
            return PlantFormScreen(plantId: plantId);
          },
        ),
      ],
    ),
    GoRoute(
      path: '/stats',
      name: 'stats',
      builder: (context, state) => const StatsScreen(),
    ),
    GoRoute(
      path: '/care-guide',
      name: 'care_guide',
      builder: (context, state) => const CareGuideScreen(),
    ),
    GoRoute(
      path: '/categories',
      name: 'categories',
      builder: (context, state) => const PlantCategoriesScreen(),
    ),
  ],
);