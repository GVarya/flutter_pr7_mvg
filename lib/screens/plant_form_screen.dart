import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../models/plant.dart';
import '../container/plants_container.dart';

class PlantFormScreen extends StatefulWidget {
  final String? plantId;

  const PlantFormScreen({Key? key, this.plantId}) : super(key: key);

  @override
  State<PlantFormScreen> createState() => _PlantFormScreenState();
}

class _PlantFormScreenState extends State<PlantFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _typeController;
  late TextEditingController _descriptionController;
  late TextEditingController _imageUrlController;

  Plant? _plant;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _typeController = TextEditingController();
    _descriptionController = TextEditingController();
    _imageUrlController = TextEditingController();

    if (widget.plantId != null) {
      _loadPlantData();
    }
  }

  void _loadPlantData() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final container = PlantsContainer.of(context);
      final plant = container.getPlantById(widget.plantId!);

      if (plant != null) {
        setState(() {
          _plant = plant;
          _nameController.text = plant.name;
          _typeController.text = plant.type;
          _descriptionController.text = plant.description ?? '';
          _imageUrlController.text = plant.imageUrl ?? '';
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Растение не найдено'),
            backgroundColor: Colors.red,
          ),
        );
        context.pop();
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _descriptionController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  void _saveForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final container = PlantsContainer.of(context);

      if (widget.plantId == null) {
        container.createPlant(
          name: _nameController.text.trim(),
          type: _typeController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
          imageUrl: _imageUrlController.text.trim().isEmpty
              ? null
              : _imageUrlController.text.trim(),
        );
      } else {
        if (_plant != null) {
          container.updatePlant(
            _plant!.copyWith(
              name: _nameController.text.trim(),
              type: _typeController.text.trim(),
              description: _descriptionController.text.trim().isEmpty
                  ? null
                  : _descriptionController.text.trim(),
              imageUrl: _imageUrlController.text.trim().isEmpty
                  ? null
                  : _imageUrlController.text.trim(),
            ),
          );
        }
      }

      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.plantId != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Редактировать растение' : 'Добавить растение'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Название растения *',
                  hintText: 'Например: Алоэ, Фикус, Монстера',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Пожалуйста, введите название';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _typeController,
                decoration: const InputDecoration(
                  labelText: 'Тип растения *',
                  hintText: 'Например: Суккулент, Папоротник, Лиана',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Пожалуйста, введите тип';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(
                  labelText: 'URL изображения растения',
                  hintText: 'https://example.com/plant-image.jpg',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Описание растения',
                  hintText: 'Необязательное поле. Можно добавить особенности ухода, местоположение и т.д.',
                  border: OutlineInputBorder(),
                  alignLabelWithHint: true,
                ),
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () => _saveForm(context),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  isEditing ? 'Сохранить изменения' : 'Добавить растение',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}