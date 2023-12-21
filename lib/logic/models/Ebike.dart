import 'package:cloud_firestore/cloud_firestore.dart';

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

  factory Ebike.fromSnapshot(DocumentSnapshot snapshot) {
    return Ebike(
      id: snapshot.id,
      name: snapshot.get('name') as String,
      isAvailable: snapshot.get('isAvailable') as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isAvailable': isAvailable,
    };
  }

  /// Get instance of [Ebike] with all properties set from this [Ebike] instance
  Ebike copyWith({
    String? id,
    String? name,
    bool? isAvailable,
  }) {
    return Ebike(
      id: id ?? this.id,
      name: name ?? this.name,
      isAvailable: isAvailable ?? this.isAvailable,
    );
  }

  /// Update existing [Ebike] in Firestore
  Future<void> update() async {
    await FirebaseFirestore.instance.collection('ebike').doc(id).set(toJson());
  }

  /// Get [Ebike] from Firestore by id
  static Future<Ebike?> getById(String id) async {
    final ebikeSnapshot = await FirebaseFirestore.instance.collection('ebike').doc(id).get();
    if (ebikeSnapshot.exists) {
      return Ebike.fromSnapshot(ebikeSnapshot);
    } else {
      return null;
    }
  }
}
