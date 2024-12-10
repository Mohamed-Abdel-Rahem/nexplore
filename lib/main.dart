import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nexplore/MovieApp.dart';
import 'package:nexplore/auth/firebase_options.dart';
import 'package:nexplore/auth/screen/accountInfo.dart';
import 'package:nexplore/auth/screen/foregtPassword.dart';
import 'package:nexplore/auth/screen/homePage.dart';
import 'package:nexplore/auth/screen/loginScreeen.dart';
import 'package:nexplore/auth/screen/onBoardingScreen.dart';
import 'package:nexplore/auth/screen/settingPage.dart';
import 'package:nexplore/auth/screen/signupScreen.dart';
import 'package:nexplore/auth/screen/splashScreen.dart';
import 'package:nexplore/core/di/module.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String initialRoute = SplashScreen.id;
  try {
    await Firebase.initializeApp();
    setupDependencies();

    runApp(DevicePreview(
      enabled: true,
      tools: const [...DevicePreview.defaultTools],
      builder: (context) => NexPlore(
        initialRoute: initialRoute,
      ),
    ));
  } catch (e) {
    debugPrint('Firebase initialization error: $e');
  }
}

class NexPlore extends StatelessWidget {
  final String initialRoute;

  const NexPlore({super.key, required this.initialRoute});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false,
      ),
      initialRoute: initialRoute,
      routes: {
        Homepage.id: (context) => const Homepage(),
        LoginScreeen.id: (context) => const LoginScreeen(),
        SignUpScreeen.id: (context) => const SignUpScreeen(),
        AccountInformation.id: (context) => const AccountInformation(),
        OnBoardingScreen.id: (context) => const OnBoardingScreen(),
        SplashScreen.id: (context) => const SplashScreen(),
        SettingPage.id: (context) => const SettingPage(),
        ForgetPasswordScreen.id: (context) => const ForgetPasswordScreen(),
        MovieApp.id: (context) => const MovieApp(),
      },
    );
  }
}
