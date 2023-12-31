import 'package:e_bike_pl/presentation/pages/management_vehicle_page.dart';
import 'package:flutter/material.dart';

import '../../logic/models/Ebike.dart';
import '../../logic/models/History.dart';
import '../../logic/models/KTM.dart';
import '../theme/theme_constants.dart';

class EbikeCard extends StatelessWidget {
  final Ebike ebike;

  const EbikeCard({
    super.key,
    required this.ebike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.hardEdge,
      height: 120,
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeConstants.primaryBlue,
          width: 3,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () async {
            ManagementVehiclePageArguments args = ManagementVehiclePageArguments(ebike: ebike);
            if (!ebike.isAvailable) {
              final history = await History.getDataByEbikeId(ebike.id);
              if (history != null) {
                final ktm = await KTM.getDataById(history.ktmId);
                args = ManagementVehiclePageArguments(ebike: ebike, ktm: ktm);
              }
            }
            Navigator.of(context).pushNamed(
              ManagementVehiclePage.routeName,
              arguments: args,
            );
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/ebike-polinema.png'),
              Container(
                width: 1,
                margin: const EdgeInsets.symmetric(vertical: 16),
                height: double.infinity,
                color: ThemeConstants.primaryBlue.withOpacity(0.3),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ebike.name),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Text('Status: '),
                      Text(ebike.isAvailable ? 'Tersedia' : 'Digunakan'),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.circle,
                        color: ebike.isAvailable ? Colors.green : Colors.red,
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
