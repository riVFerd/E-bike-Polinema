import 'package:e_bike_pl/presentation/pages/home_page.dart';
import 'package:e_bike_pl/presentation/pages/scan_page.dart';
import 'package:e_bike_pl/presentation/theme/theme_constants.dart';
import 'package:flutter/material.dart';

import '../../logic/models/Ebike.dart';
import '../../logic/models/KTM.dart';
import '../widgets/custom_text_field.dart';

class ManagementVehiclePage extends StatelessWidget {
  final Ebike ebike;
  final KTM? ktm;

  static const routeName = '/managementVehicle';

  const ManagementVehiclePage({super.key, required this.ebike, this.ktm});

  void onSubmit(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Data berhasil disimpan'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

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
          child: Form(
            key: formKey,
            canPop: false,
            onPopInvoked: (_) {
              Navigator.of(context).pushNamedAndRemoveUntil(HomePage.routeName, (route) => false);
            },
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
                        Navigator.of(context).pushNamed(
                          ScanPage.routeName,
                          arguments: ebike,
                        );
                      },
                      child: const Text(
                        'Scan KTM',
                        style: TextStyle(color: ThemeConstants.primaryWhite),
                      ),
                    ),
                  ],
                ),
                CustomTextField(
                  label: 'NIM',
                  hintText: 'Ex: 2141720116',
                  initialValue: ktm?.nim ?? '',
                ),
                CustomTextField(
                  label: 'Nama',
                  hintText: 'Ex: Tony',
                  initialValue: ktm?.nama ?? '',
                ),
                CustomTextField(
                  label: 'Prodi',
                  hintText: 'Ex: D-IV Teknik Informatika',
                  initialValue: ktm?.jurusan ?? '',
                ),
                const SizedBox(height: 32),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ThemeConstants.primaryBlue,
                    minimumSize: const Size(double.infinity, 48),
                  ),
                  onPressed: () {
                    if (!formKey.currentState!.validate()) return;
                    onSubmit(context);
                  },
                  child: Text(
                    (ebike.isAvailable) ? 'Pinjam' : 'Kembalikan',
                    style: const TextStyle(color: ThemeConstants.primaryWhite),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

/// Arguments holder class for ManageVehiclePage - contains [ebike] and [ktm]
class ManagementVehiclePageArguments {
  final Ebike ebike;
  final KTM? ktm;

  const ManagementVehiclePageArguments({required this.ebike, this.ktm});
}
