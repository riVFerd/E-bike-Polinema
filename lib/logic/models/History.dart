import 'package:cloud_firestore/cloud_firestore.dart';

class History {
  final String id;
  final Timestamp dateStart;
  final Timestamp dateEnd;
  final String ktmId;
  final String ebikeId;
  final bool isDone;

  const History({
    required this.id,
    required this.dateStart,
    required this.dateEnd,
    required this.ktmId,
    required this.ebikeId,
    this.isDone = false,
  });

  factory History.fromJson(Map<String, dynamic> json) {
    return History(
      id: json['id'] as String,
      dateStart: json['date_start'] as Timestamp,
      dateEnd: json['date_end'] as Timestamp,
      ktmId: json['ktm_id'] as String,
      ebikeId: json['ebike_id'] as String,
      isDone: json['isDone'] as bool,
    );
  }

  factory History.fromSnapshot(DocumentSnapshot snapshot) {
    return History(
      id: snapshot.id,
      dateStart: snapshot.get('date_start') as Timestamp,
      dateEnd: snapshot.get('date_end') as Timestamp,
      ktmId: snapshot.get('ktm_id') as String,
      ebikeId: snapshot.get('ebike_id') as String,
      isDone: snapshot.get('isDone') as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date_start': dateStart,
      'date_end': dateEnd,
      'ktm_id': ktmId,
      'ebike_id': ebikeId,
      'isDone': isDone,
    };
  }

  /// Get instance of [History] with all properties set from this [History] instance
  History copyWith({
    String? id,
    Timestamp? dateStart,
    Timestamp? dateEnd,
    String? ktmId,
    String? ebikeId,
    bool? isDone,
  }) {
    return History(
      id: id ?? this.id,
      dateStart: dateStart ?? this.dateStart,
      dateEnd: dateEnd ?? this.dateEnd,
      ktmId: ktmId ?? this.ktmId,
      ebikeId: ebikeId ?? this.ebikeId,
      isDone: isDone ?? this.isDone,
    );
  }

  /// Get unfinished history from Firestore by ebike id
  static Future<History?> getDataByEbikeId(String ebikeId) async {
    final historySnapshot = await FirebaseFirestore.instance
        .collection('history')
        .where('ebike_id', isEqualTo: ebikeId)
        .where('isDone', isEqualTo: false)
        .get();
    if (historySnapshot.docs.isNotEmpty) {
      final history = History.fromSnapshot(historySnapshot.docs.first);
      return history;
    } else {
      return null;
    }
  }

  /// Get data from Firestore by ktm id
  static Future<History?> getDataByKtmId(String ktmId) async {
    final historySnapshot = await FirebaseFirestore.instance
        .collection('history')
        .where('ktm_id', isEqualTo: ktmId)
        .get();
    if (historySnapshot.docs.isNotEmpty) {
      final history = History.fromSnapshot(historySnapshot.docs.first);
      return history;
    } else {
      return null;
    }
  }

  /// Save this [History] as new data to Firestore
  Future<void> create() async {
    final documentRef = await FirebaseFirestore.instance.collection('history').add(toJson());
    print('Document added with ID: ${documentRef.id}');
  }

  /// Update existing [History] in Firestore
  Future<void> update() async {
    await FirebaseFirestore.instance.collection('history').doc(id).set(toJson());
  }

  @override
  String toString() {
    return 'History(id: $id, dateStart: $dateStart, dateEnd: $dateEnd, ktmId: $ktmId, ebikeId: $ebikeId)';
  }
}
