class Plant {
  final String id;
  final String name;
  final String type;
  final DateTime lastWatered;
  final DateTime createdAt;

  Plant({
    required this.id,
    required this.name,
    required this.type,
    required this.lastWatered,
    required this.createdAt,
  });

  Plant copyWith({
    String? id,
    String? name,
    String? type,
    DateTime? lastWatered,
    DateTime? createdAt,
  }) {
    return Plant(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      lastWatered: lastWatered ?? this.lastWatered,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}