import 'package:flutter/material.dart';

import '../../logic/models/Ebike.dart';
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
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: ThemeConstants.primaryBlue,
          width: 3,
        ),
      ),
      margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
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
    );
  }
}
