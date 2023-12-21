import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:e_bike_pl/logic/models/History.dart';
import 'package:e_bike_pl/presentation/pages/test_ktp.dart';
import 'package:e_bike_pl/presentation/theme/theme_constants.dart';
import 'package:flutter/material.dart';

import '../../logic/models/Ebike.dart';
import '../widgets/ebike_card.dart';
import '../widgets/history_card.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ebikeCollection = FirebaseFirestore.instance.collection('ebike').orderBy('name');
  final tabController = PageController();
  int tabIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          HomeTab(ebikeCollection: ebikeCollection),
          const HistoryTab(),
        ],
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
        currentIndex: tabIndex,
        onTap: (index) {
          if (index == 1) return;
          if (index == 2) tabIndex--;
          setState(() {
            tabIndex = index;
            tabController.animateToPage(
              tabIndex,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
      ),
    );
  }
}

class HomeTab extends StatelessWidget {
  const HomeTab({
    super.key,
    required this.ebikeCollection,
  });

  final Query<Map<String, dynamic>> ebikeCollection;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: GestureDetector(
          onDoubleTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => const TestKTP(),
              ),
            );
          },
          child: const Text(
            'Home',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
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
    );
  }
}

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'History Peminjaman',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        child: DottedBorder(
          borderType: BorderType.RRect,
          color: ThemeConstants.primaryBlue.withOpacity(0.5),
          dashPattern: const [16, 4],
          radius: const Radius.circular(8),
          child: FutureBuilder(
            future: History.getAllData(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final histories = snapshot.data!;
                return ListView.builder(
                  itemCount: histories.length,
                  itemBuilder: (context, index) {
                    final history = histories[index];
                    return HistoryCard(
                      history: history,
                    );
                  },
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
