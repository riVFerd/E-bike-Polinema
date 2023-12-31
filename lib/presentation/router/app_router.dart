import 'package:e_bike_pl/presentation/pages/home_page.dart';
import 'package:e_bike_pl/presentation/pages/management_vehicle_page.dart';
import 'package:e_bike_pl/presentation/pages/scan_page.dart';
import 'package:e_bike_pl/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';

import '../../logic/models/Ebike.dart';

class AppRouter {
  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const SplashPage(),
        );
      case HomePage.routeName:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
        );
      case ManagementVehiclePage.routeName:
        final args = settings.arguments as ManagementVehiclePageArguments;
        return MaterialPageRoute(
          builder: (_) => ManagementVehiclePage(
            ebike: args.ebike,
            ktm: args.ktm,
          ),
        );
      case ScanPage.routeName:
        final ebike = settings.arguments as Ebike;
        return MaterialPageRoute(
          builder: (_) => ScanPage(ebike: ebike),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Not Found'),
            ),
          ),
        );
    }
  }
}
