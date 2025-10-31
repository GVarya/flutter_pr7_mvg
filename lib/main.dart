import 'package:flutter/material.dart';
import 'package:flutter_pr5_mvg/theme.dart';
import 'container/plants_container.dart';
import 'app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlantsContainer(
      child: MaterialApp.router(
        title: 'Учет домашних растений',
        theme: AppTheme.lightTheme,
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}