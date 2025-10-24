import 'package:cached_network_image/cached_network_image.dart';
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
        leading: _buildPlantImage(),
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

  Widget _buildPlantImage() {
    if (plant.imageUrl != null && plant.imageUrl!.isNotEmpty) {
      return CachedNetworkImage(
        imageUrl: plant.imageUrl!,
        imageBuilder: (context, imageProvider) => Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        placeholder: (context, url) => CircleAvatar(
          backgroundColor: Colors.green.shade100,
          child: const CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
          ),
        ),
        errorWidget: (context, url, error) => CircleAvatar(
          backgroundColor: Colors.green,
          child: Text(
            plant.name[0].toUpperCase(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      );
    }

    return CircleAvatar(
      backgroundColor: Colors.green,
      child: Text(
        plant.name[0].toUpperCase(),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }

}

