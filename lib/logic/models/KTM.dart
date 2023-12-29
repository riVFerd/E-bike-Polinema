import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';

class KTM {
  String id;
  String nim;
  String nama;
  String ttl;
  String jurusan;
  String alamat;

  KTM({
    required this.id,
    required this.nim,
    required this.nama,
    required this.ttl,
    required this.jurusan,
    required this.alamat,
  });

  factory KTM.fromJson(Map<String, dynamic> json) {
    return KTM(
      id: json['id'] ?? '',
      nim: json['nim'] ?? '',
      nama: json['nama'] ?? '',
      ttl: json['ttl'] ?? '',
      jurusan: json['jurusan'] ?? '',
      alamat: json['alamat'] ?? '',
    );
  }

  factory KTM.fromSnapshot(DocumentSnapshot snapshot) {
    return KTM(
      id: snapshot.id,
      nim: snapshot['nim'] ?? '',
      nama: snapshot['nama'] ?? '',
      ttl: '',
      jurusan: snapshot['jurusan'] ?? '',
      alamat: '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nim': nim,
      'nama': nama,
      'ttl': ttl,
      'jurusan': jurusan,
      'alamat': alamat,
    };
  }

  /// Get instance of [KTM] with all properties set to empty
  factory KTM.empty() {
    return KTM(
      id: '',
      nim: '',
      nama: '',
      ttl: '',
      jurusan: '',
      alamat: '',
    );
  }

  /// Get instance of [KTM] with all properties set from this [KTM] instance
  KTM copyWith({
    String? id,
    String? nim,
    String? nama,
    String? ttl,
    String? jurusan,
    String? alamat,
  }) {
    return KTM(
      id: id ?? this.id,
      nim: nim ?? this.nim,
      nama: nama ?? this.nama,
      ttl: ttl ?? this.ttl,
      jurusan: jurusan ?? this.jurusan,
      alamat: alamat ?? this.alamat,
    );
  }

  static Future<KTM?> getDataByUploadImage(String filePath, String url, Dio dio) async {
    String fileName = filePath.split('/').last;
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(filePath, filename: fileName),
    });
    late Response response;
    try {
      response = await dio.post(
        url,
        data: formData,
      );
    } on DioException catch (_) {
      return null;
    }
    return KTM.fromJson(response.data as Map<String, dynamic>);
  }

  static Future<String?> getTextByOCR(String filePath, String url, Dio dio) async {
    String fileName = filePath.split('/').last;
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(filePath, filename: fileName),
    });
    late Response response;
    try {
      response = await dio.post(
        url,
        data: formData,
      );
    } on DioException catch (_) {
      return null;
    }
    return (response.data as Map<String, dynamic>).toString();
  }

  /// Get data from Firestore by [KTM.id]
  static Future<KTM?> getDataById(String id) async {
    final ktmSnapshot = await FirebaseFirestore.instance.collection('KTM').doc(id).get();
    if (ktmSnapshot.exists) {
      final ktm = KTM.fromSnapshot(ktmSnapshot);
      return ktm;
    } else {
      return null;
    }
  }

  /// Get [KTM.id] from Firestore by [KTM.nim]
  Future<String> getIdByNim() async {
    final ktmSnapshot =
        await FirebaseFirestore.instance.collection('KTM').where('nim', isEqualTo: nim).get();
    return ktmSnapshot.docs.first.id;
  }

  /// Check whether this [KTM] is already exist in Firestore or not based on [KTM.nim]
  Future<bool> isExist() async {
    final ktmSnapshot =
        await FirebaseFirestore.instance.collection('KTM').where('nim', isEqualTo: nim).get();
    return ktmSnapshot.docs.isNotEmpty;
  }

  /// Update existing [KTM] in Firestore
  /// [KTM.nim] is used as identifier
  Future<void> update() async {
    await FirebaseFirestore.instance
        .collection('KTM')
        .where('nim', isEqualTo: nim)
        .get()
        .then((value) {
      value.docs.first.reference.set(toJson());
    });
  }

  /// Save this [KTM] as new data to Firestore
  Future<void> create() async {
    await FirebaseFirestore.instance.collection('KTM').add(toJson());
  }

  /// Either update or create new [KTM] in Firestore
  /// based on whether this [KTM.nim] is already exist or not
  /// Return [KTM.id] at the end
  Future<String> save() async {
    if (await isExist()) {
      await update();
    } else {
      await create();
    }
    return await getIdByNim();
  }
}
