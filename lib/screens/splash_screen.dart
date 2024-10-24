import 'package:flutter/material.dart';
import 'package:movie_search_imdb/pages/home_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  late AnimationController _overlayController;

  @override
  void initState() {
    super.initState();
    _overlayController = AnimationController(
      duration: const Duration(milliseconds:300),
      vsync: this,
    );

    Future.delayed(
      const Duration(milliseconds: 800),
      () {
        _overlayController.forward();
      },
    );

    _navigateToHome();
  }

  @override
  void dispose() {
    _overlayController.dispose();
    super.dispose();
  }

  _navigateToHome() async {
    await Future.delayed(const Duration(milliseconds: 1600), () {});
    if (mounted) {
      Navigator.of(context).pushReplacement(
        PageRouteBuilder(
          pageBuilder: (context, _, __) => const HomePage(),
          transitionDuration: const Duration(milliseconds: 480),
          transitionsBuilder: (context, a, _, c) => FadeTransition(
            opacity: a,
            child: c,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Center(
        child: Stack(
          children: [
            SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(0.38, 0), end: const Offset(0, 0)).animate(_overlayController),
              child: const Image(
                image: AssetImage('assets/logo.png'),
                height: 200,
                width: 200,
              ),
            ),
            SlideTransition(
              position:
                  Tween<Offset>(begin: const Offset(0.6, 0.5), end: const Offset(2, 0.5)).animate(_overlayController),
              child: Container(
                color: Colors.black,
                height: 100,
                width: 200,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
