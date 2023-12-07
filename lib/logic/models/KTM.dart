import 'package:dio/dio.dart';

class KTM {
  final String nim;
  final String nama;
  final String ttl;
  final String jurusan;
  final String alamat;

  const KTM({
    required this.nim,
    required this.nama,
    required this.ttl,
    required this.jurusan,
    required this.alamat,
  });

  factory KTM.fromJson(Map<String, dynamic> json) {
    return KTM(
      nim: json['nim'] ?? '',
      nama: json['nama'] ?? '',
      ttl: json['ttl'] ?? '',
      jurusan: json['jurusan'] ?? '',
      alamat: json['alamat'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nim': nim,
      'nama': nama,
      'ttl': ttl,
      'jurusan': jurusan,
      'alamat': alamat,
    };
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
}
