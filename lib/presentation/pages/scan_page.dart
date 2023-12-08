import 'dart:io';

import 'package:dio/dio.dart';
import 'package:e_bike_pl/logic/models/Ebike.dart';
import 'package:e_bike_pl/presentation/pages/management_vehicle_page.dart';
import 'package:e_bike_pl/presentation/theme/theme_constants.dart';
import 'package:e_bike_pl/presentation/widgets/action_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:image_picker/image_picker.dart';

import '../../logic/models/KTM.dart';

class ScanPage extends StatefulWidget {
  final Ebike ebike;

  const ScanPage({super.key, required this.ebike});

  static const routeName = '/scan';

  @override
  State<ScanPage> createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
  bool isLoading = false;
  ImagePicker imagePicker = ImagePicker();
  XFile? imageFile;

  final dio = Dio(
    BaseOptions(
      baseUrl: dotenv.env['SERVER_URL'] ?? 'http://localhost:5000',
    ),
  );

  Future<String> pingServer(Dio dio) async {
    String statusCode = '0';
    try {
      final response = await dio.get('/ping');
      statusCode = response.statusCode.toString();
    } on DioException catch (e) {
      statusCode = e.response!.statusCode.toString();
    }
    return statusCode;
  }

  Future<void> sendImage(Dio dio) async {
    setState(() {
      isLoading = true;
    });
    final ktm = await KTM.getDataByUploadImage(imageFile!.path, '/ocr_ktm', dio);
    if (ktm != null) {
      Navigator.of(context).pushNamed(
        ManagementVehiclePage.routeName,
        arguments: ManagementVehiclePageArguments(ebike: widget.ebike, ktm: ktm),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to get data from server'),
        ),
      );
    }
    setState(() {
      isLoading = false;
    });
  }

  Future<void> pickImage(ImageSource imageSource) async {
    final pickedImage = await imagePicker.pickImage(source: imageSource);
    if (pickedImage == null) return;
    imageFile = pickedImage;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Scan KTM'),
        ),
        body: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Image Preview',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Flexible(
                    flex: 2,
                    child: Container(
                      width: double.infinity,
                      height: 240,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: (imageFile != null)
                          ? Center(
                              child: Image.file(
                                File(imageFile!.path),
                              ),
                            )
                          : const Center(
                              child: Text('No image selected'),
                            ),
                    ),
                  ),
                  Flexible(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        ActionButton(
                          iconData: Icons.camera_alt,
                          labelText: 'Camera',
                          onClick: () {
                            pickImage(ImageSource.camera);
                          },
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            final statusCode = await pingServer(dio);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Server responded with status code: $statusCode'),
                              ),
                            );
                          },
                          child: const Text('Ping Server'),
                        ),
                        ActionButton(
                          iconData: Icons.photo,
                          labelText: 'Gallery',
                          onClick: () {
                            pickImage(ImageSource.gallery);
                          },
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                      onPressed: (imageFile == null)
                          ? null
                          : () async {
                              await sendImage(dio);
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ThemeConstants.primaryBlue,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 46),
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color: ThemeConstants.primaryWhite,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (isLoading)
                ? Container(
                    color: Colors.black.withOpacity(0.5),
                    child: const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text(
                            'Scanning KTM',
                            style: TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 18,
                              color: ThemeConstants.primaryWhite,
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
      ),
    );
  }
}
