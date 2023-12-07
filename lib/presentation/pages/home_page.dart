import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_bike_pl/presentation/theme/theme_constants.dart';
import 'package:flutter/material.dart';

import '../../logic/models/Ebike.dart';
import '../widgets/ebike_card.dart';

class HomePage extends StatelessWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final ebikeCollection = FirebaseFirestore.instance.collection('ebike').orderBy('name');

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
                      child: StreamBuilder(
                        stream: ebikeCollection.snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else {
                            return ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                final ebike = Ebike.fromSnapshot(snapshot.data!.docs[index]);
                                return EbikeCard(ebike: ebike);
                              },
                            );
                          }
                        },
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
