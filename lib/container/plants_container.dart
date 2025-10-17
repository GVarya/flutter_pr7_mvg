import 'package:flutter/material.dart';
import '../models/plant.dart';


class PlantsContainer extends StatefulWidget {
  final Widget child;

  const PlantsContainer({Key? key, required this.child}) : super(key: key);

  @override
  State<PlantsContainer> createState() => _PlantsContainerState();

  static _PlantsContainerState of(BuildContext context) {
    final state = context.findAncestorStateOfType<_PlantsContainerState>();
    if (state == null) {
      throw FlutterError('PlantsContainer not found in context');
    }
    return state;
  }
}

class _PlantsContainerState extends State<PlantsContainer> {
  final List<Plant> _plants = [];

  List<Plant> get plants => List.unmodifiable(_plants);


  void createPlant({
    required String name,
    required String type,
    String? description,
  }) {
    final plant = Plant(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      type: type,
      description: description,
      lastWatered: DateTime.now(),
      createdAt: DateTime.now(),
    );

    setState(() {
      _plants.add(plant);
    });
  }

  void updatePlant(Plant updatedPlant) {
    setState(() {
      final index = _plants.indexWhere((p) => p.id == updatedPlant.id);
      if (index != -1) {
        _plants[index] = updatedPlant;
      }
    });
  }

  void deletePlant(String id) {
    Plant? deletedPlant;
    int? deletedIndex;

    setState(() {
      final index = _plants.indexWhere((p) => p.id == id);
      if (index != -1) {
        deletedIndex = index;
        deletedPlant = _plants.removeAt(index);
      }
    });

    if (deletedPlant != null && deletedIndex != null) {
      final context = this.context;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Растение "${deletedPlant!.name}" удалено'),
          action: SnackBarAction(
            label: 'Отменить',
            onPressed: () {
              setState(() {
                _plants.insert(deletedIndex!, deletedPlant!);
              });
            },
          ),
          duration: const Duration(seconds: 3),
        ),
      );
    }
  }

  void waterPlant(String id) {
    setState(() {
      final index = _plants.indexWhere((p) => p.id == id);
      if (index != -1) {
        _plants[index] = _plants[index].copyWith(
          lastWatered: DateTime.now(),
        );
      }
    });
  }

  Plant? getPlantById(String id) {
    try {
      return _plants.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}