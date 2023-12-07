import 'package:e_bike_pl/presentation/pages/home_page.dart';
import 'package:e_bike_pl/presentation/theme/theme_constants.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, HomePage.routeName);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ThemeConstants.primaryWhite,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/ebike-polinema.png'),
            const CircularProgressIndicator(
              color: ThemeConstants.primaryBlue,
            ),
          ],
        ),
      ),
    );
  }
}
