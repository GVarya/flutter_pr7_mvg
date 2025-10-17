import 'package:flutter/material.dart';
import 'package:flutter_pr5_mvg/theme.dart';
import 'container/plants_container.dart';
import 'screens/plants_list_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlantsContainer(
      child: MaterialApp(
        title: 'Учет домашних растений',
        theme: AppTheme.lightTheme,
        home: const PlantsListScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}