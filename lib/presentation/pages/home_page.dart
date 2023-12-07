import 'package:dotted_border/dotted_border.dart';
import 'package:e_bike_pl/presentation/theme/theme_constants.dart';
import 'package:flutter/material.dart';

import '../../logic/models/Ebike.dart';
import '../widgets/ebike_card.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  // Dummy data
  static const List<Ebike> dummyEbikeList = [
    Ebike(id: '1', name: 'Ebike 1', isAvailable: true),
    Ebike(id: '2', name: 'Ebike 2', isAvailable: false),
    Ebike(id: '3', name: 'Ebike 3', isAvailable: true),
    Ebike(id: '4', name: 'Ebike 4', isAvailable: false),
    Ebike(id: '5', name: 'Ebike 5', isAvailable: true),
    Ebike(id: '6', name: 'Ebike 6', isAvailable: false),
    Ebike(id: '7', name: 'Ebike 7', isAvailable: true),
    // Add more instances as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text(
            'Home',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              children: [
                const Text(
                  'Daftar E-Bike',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Flexible(
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
                    child: DottedBorder(
                      borderType: BorderType.RRect,
                      color: ThemeConstants.primaryBlue.withOpacity(0.5),
                      dashPattern: const [16, 4],
                      radius: const Radius.circular(8),
                      child: SingleChildScrollView(
                        child: Column(
                          children: dummyEbikeList.map((e) => EbikeCard(ebike: e)).toList(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home_rounded),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: ImageIcon(
                AssetImage('assets/ebike-polinema-icon.png'),
                size: 46,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.airplane_ticket_rounded),
              label: 'Vehicle',
            ),
          ],
        ));
  }
}
