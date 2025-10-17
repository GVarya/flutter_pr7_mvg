import 'package:flutter/material.dart';
import '../models/plant.dart';
import '../container/plants_container.dart';


class PlantFormScreen extends StatefulWidget {
  final Plant? plant;

  const PlantFormScreen({Key? key, this.plant}) : super(key: key);

  @override
  State<PlantFormScreen> createState() => _PlantFormScreenState();
}

class _PlantFormScreenState extends State<PlantFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _typeController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.plant != null) {
      _nameController.text = widget.plant!.name;
      _typeController.text = widget.plant!.type;
      _descriptionController.text = widget.plant!.description ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _typeController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _saveForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
    final container = PlantsContainer.of(context);
    if (widget.plant == null) {
      container.createPlant(
        name: _nameController.text.trim(),
        type: _typeController.text.trim(),
        description: _descriptionController.text.trim().isEmpty
            ? null
            : _descriptionController.text.trim(),
      );
    } else {
      container.updatePlant(
        widget.plant!.copyWith(
          name: _nameController.text.trim(),
          type: _typeController.text.trim(),
          description: _descriptionController.text.trim().isEmpty
              ? null
              : _descriptionController.text.trim(),
        ),
      );
    }

    Navigator.pop(context);

    } else {
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.plant != null;

    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Редактировать растение' : 'Добавить растение'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Название растения',
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
                  labelText: 'Тип растения',
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
              const SizedBox(height: 24),

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