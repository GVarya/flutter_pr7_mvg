class Plant {
  final String id;
  final String name;
  final String? description;
  final String? imageUrl;
  final String type;
  final DateTime lastWatered;
  final DateTime createdAt;

  Plant({
    required this.id,
    required this.name,
    this.description,
    this.imageUrl,
    required this.type,
    required this.lastWatered,
    required this.createdAt,
  });

  Plant copyWith({
    String? id,
    String? name,
    String? description,
    String? imageUrl,
    String? type,
    DateTime? lastWatered,
    DateTime? createdAt,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      type: type ?? this.type,
      lastWatered: lastWatered ?? this.lastWatered,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}