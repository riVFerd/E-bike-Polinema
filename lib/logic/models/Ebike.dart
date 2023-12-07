class Ebike {
  final String id;
  final String name;
  final bool isAvailable;

  const Ebike({
    required this.id,
    required this.name,
    required this.isAvailable,
  });

  factory Ebike.fromJson(Map<String, dynamic> json) {
    return Ebike(
      id: json['id'] as String,
      name: json['name'] as String,
      isAvailable: json['isAvailable'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isAvailable': isAvailable,
    };
  }
}
