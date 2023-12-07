import 'package:flutter/material.dart';

class AppRouter {
  static MaterialPageRoute onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Home'),
            ),
          ),
        );
      case '/login':
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text('Login'),
            ),
          ),
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
