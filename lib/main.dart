import 'package:e_bike_pl/presentation/router/app_router.dart';
import 'package:e_bike_pl/presentation/theme/theme_constants.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'E-bike Polinema',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: ThemeConstants.primaryBlue),
        useMaterial3: true,
      ),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
