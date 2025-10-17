import 'package:flutter/material.dart';
import '../container/plants_container.dart';
import '../widgets/plant_item.dart';
import 'plant_form_screen.dart';
import 'plant_detail_screen.dart';


class PlantsListScreen extends StatefulWidget {
  const PlantsListScreen({Key? key}) : super(key: key);

  @override
  State<PlantsListScreen> createState() => _PlantsListScreenState();
}
class _PlantsListScreenState extends State<PlantsListScreen> {

  @override
  Widget build(BuildContext context) {
    print('🔵 PlantsListScreen build вызван');

    try {
      final container = PlantsContainer.of(context);
      final plants = container.plants;

      print('🔵 Количество растений в списке: ${plants.length}');
      print('🔵 Список растений:');
      for (var plant in plants) {
        print('   - ${plant.name}');
      }

      return Scaffold(
        appBar: AppBar(
          title: const Text('Мои растения'),
          centerTitle: true,
        ),
        body: plants.isEmpty
            ? const Center(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Нет растений.\nДобавьте первое растение!',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          ),
        )
            : ListView.builder(
          padding: const EdgeInsets.all(8.0),
          itemCount: plants.length,
          itemBuilder: (context, index) {
            final plant = plants[index];
            return PlantItem(
              plant: plant,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PlantDetailScreen(plant: plant),
                  ),
                );
              },
              onWater: () {
                container.waterPlant(plant.id);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Растение "${plant.name}" полито'),
                    duration: const Duration(seconds: 2),
                  ),
                );
              },
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            print('🟠 FAB нажата, открываем форму');
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PlantFormScreen(),
              ),
            );
            print('🟠 Вернулись с формы, обновляем состояние');
            setState(() {});
          },
          tooltip: 'Добавить растение',
          child: const Icon(Icons.add),
        ),
      );
    }  catch (e) {
        print('🔴 ОШИБКА в PlantsListScreen: $e');
        return Scaffold(
          appBar: AppBar(title: Text('Ошибка')),
          body: Center(child: Text('Ошибка: $e')),
        );
    }
  }
}