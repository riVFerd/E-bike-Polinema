import 'package:e_bike_pl/presentation/pages/home_page.dart';
import 'package:e_bike_pl/presentation/pages/splash_page.dart';
import 'package:flutter/material.dart';

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
