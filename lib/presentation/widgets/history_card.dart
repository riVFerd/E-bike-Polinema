import 'package:e_bike_pl/logic/models/KTM.dart';
import 'package:flutter/material.dart';

import '../../logic/models/Ebike.dart';
import '../../logic/models/History.dart';
import '../theme/theme_constants.dart';

class HistoryCard extends StatelessWidget {
  final History history;

  const HistoryCard({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (_) {
              return HistoryBottomSheet(history: history);
            },
          );
        },
        child: Container(
          width: double.infinity,
          clipBehavior: Clip.hardEdge,
          height: 180,
          margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: ThemeConstants.primaryBlue,
              width: 3,
            ),
          ),
          child: FutureBuilder(
            future: Ebike.getById(history.ebikeId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else {
                final ebike = snapshot.data!;
                return Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset('assets/ebike-polinema.png'),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            ebike.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Tanggal Peminjaman: ${history.dateStart.toDate().day}-${history.dateStart.toDate().month}-${history.dateStart.toDate().year}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Tanggal Pengembalian:',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          Text(
                            (history.isDone == true)
                                ? '${history.dateEnd.toDate().day}-${history.dateEnd.toDate().month}-${history.dateEnd.toDate().year}'
                                : 'Belum dikembalikan',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: (history.isDone == true)
                                  ? ThemeConstants.primaryBlue
                                  : Colors.red,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class HistoryBottomSheet extends StatelessWidget {
  const HistoryBottomSheet({
    super.key,
    required this.history,
  });

  final History history;

  @override
  Widget build(BuildContext context) {
    const defaultTextStyle = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 4),
      height: 300,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                width: MediaQuery.of(context).size.width / 3,
                height: 8,
                decoration: BoxDecoration(
                  color: ThemeConstants.primaryBlue.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(8),
                ),
              )
            ],
          ),
          const SizedBox(height: 8),
          FutureBuilder(
            future: Ebike.getById(history.ebikeId),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return const SizedBox();
              final ebike = snapshot.data!;
              return Text(
                'Nama E-bike: ${ebike.name}',
                style: defaultTextStyle,
              );
            },
          ),
          FutureBuilder(
            future: KTM.getDataById(history.ktmId),
            builder: (_, snapshot) {
              if (!snapshot.hasData) return const SizedBox();
              final ktm = snapshot.data!;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'NIM Peminjam: ${ktm.nim}',
                    style: defaultTextStyle,
                  ),
                  Text(
                    'Nama Peminjam: ${ktm.nama}',
                    style: defaultTextStyle,
                  ),
                  Text(
                    'Jurusan Peminjam: ${ktm.jurusan}',
                    style: defaultTextStyle,
                  ),
                ],
              );
            },
          ),
          Text(
            'Tanggal Peminjaman: ${history.dateStart.toDate().day}-${history.dateStart.toDate().month}-${history.dateStart.toDate().year}',
            style: defaultTextStyle,
          ),
          Text(
            'Waktu Peminjaman: ${history.dateStart.toDate().hour} : ${history.dateStart.toDate().minute} : ${history.dateStart.toDate().second}',
            style: defaultTextStyle,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              const Text(
                'Tanggal Pengembalian:',
                style: defaultTextStyle,
              ),
              const SizedBox(width: 8),
              Text(
                (history.isDone == true)
                    ? '${history.dateEnd.toDate().day}-${history.dateEnd.toDate().month}-${history.dateEnd.toDate().year}'
                    : 'Belum dikembalikan',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: (history.isDone == true) ? ThemeConstants.primaryBlue : Colors.red,
                ),
              ),
            ],
          ),
          (history.isDone == true)
              ? Row(
                  children: [
                    const Text(
                      'Waktu Pengembalian:',
                      style: defaultTextStyle,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${history.dateEnd.toDate().hour} : ${history.dateEnd.toDate().minute} : ${history.dateEnd.toDate().second}',
                      style: defaultTextStyle,
                    ),
                  ],
                )
              : const SizedBox(),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
