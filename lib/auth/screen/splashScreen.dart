import 'dart:async';

import 'package:flutter/material.dart';
import 'package:nexplore/auth/screen/loginScreeen.dart';
import 'package:nexplore/auth/screen/onBoardingScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static String id = 'SplashScreen';
  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _startSplashAnimation();

    Timer(const Duration(seconds: 4), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool visited = prefs.getBool('vis') ?? false;
      if (visited) {
        Navigator.pushReplacementNamed(context, LoginScreeen.id);
      } else {
        Navigator.pushReplacementNamed(context, OnBoardingScreen.id);
      }
    });
  }

  void _initializeAnimations() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );

    _rotateAnimation = Tween<double>(begin: 0, end: 3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _startSplashAnimation() {
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: RadialGradient(
            center: Alignment.center,
            radius: 1.2, // Adjust the radius for the spread
            colors: [
              Color.fromARGB(255, 80, 78, 187), // Darker purple
              Color(0xff171733), // Dark blue-purple background
            ],
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: RotationTransition(
              turns: _rotateAnimation,
              child: Image.asset(
                'assets/images/remplayicon.png',
                width: 150,
                height: 150,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/*Timer(const Duration(seconds: 4), () async {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool visited = prefs.getBool('visit') ?? false;
      if (visited) {
        Navigator.pushReplacementNamed(context, MainPage.id);
      } else {
        Navigator.pushReplacementNamed(context, MyHomePage.id);
      }
    });*/