import 'package:flutter/material.dart';
import '../models/plant.dart';

class PlantItem extends StatelessWidget {
  final Plant plant;
  final VoidCallback onTap;
  final VoidCallback onWater;

  const PlantItem({
    Key? key,
    required this.plant,
    required this.onTap,
    required this.onWater,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.green,
          child: Text(
            plant.name[0].toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          plant.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(plant.type),
        trailing: IconButton(
          icon: const Icon(Icons.water_drop, color: Colors.blue),
          onPressed: onWater,
          tooltip: 'Полить',
        ),
        onTap: onTap,
      ),
    );
  }
}