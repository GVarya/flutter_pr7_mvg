import 'package:flutter/material.dart';
import 'container/plants_container.dart';

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
        theme: ThemeData(
          primarySwatch: Colors.green,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}