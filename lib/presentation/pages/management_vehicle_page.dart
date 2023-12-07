import 'package:e_bike_pl/presentation/pages/scan_page.dart';
import 'package:e_bike_pl/presentation/theme/theme_constants.dart';
import 'package:flutter/material.dart';

import '../../logic/models/Ebike.dart';

class ManagementVehiclePage extends StatelessWidget {
  final Ebike ebike;

  static const routeName = '/managementVehicle';

  const ManagementVehiclePage({super.key, required this.ebike});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Management Vehicle',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CustomTextField(
                label: 'Nama E-Bike',
                readOnly: true,
                initialValue: ebike.name,
              ),
              CustomTextField(
                label: 'Status',
                readOnly: true,
                initialValue: ebike.isAvailable ? 'Tersedia' : 'Digunakan',
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Data KTM',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: ThemeConstants.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    onPressed: () {
                      Navigator.of(context).pushNamed(ScanPage.routeName);
                    },
                    child: const Text(
                      'Scan KTM',
                      style: TextStyle(color: ThemeConstants.primaryWhite),
                    ),
                  ),
                ],
              ),
              const CustomTextField(
                label: 'NIM',
                hintText: 'Ex: 2141720116',
              ),
              const CustomTextField(
                label: 'Nama',
                hintText: 'Ex: Tony',
              ),
              const CustomTextField(
                label: 'Prodi',
                hintText: 'Ex: D-IV Teknik Informatika',
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class CustomTextField extends StatelessWidget {
  final String label;
  final String initialValue;
  final bool readOnly;
  final String hintText;

  const CustomTextField({
    super.key,
    required this.label,
    this.hintText = '',
    this.initialValue = '',
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          TextFormField(
            initialValue: initialValue,
            readOnly: readOnly,
            decoration: InputDecoration(
              hintText: hintText,
              border: const OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(16)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
