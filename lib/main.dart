import 'package:device_preview/device_preview.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nexplore/firebase_options.dart';
import 'package:nexplore/screen/accountInfo.dart';
import 'package:nexplore/screen/homePage.dart';
import 'package:nexplore/screen/loginScreeen.dart';
import 'package:nexplore/screen/onBoardingScreen.dart';
import 'package:nexplore/screen/settingPage.dart';
import 'package:nexplore/screen/signupScreen.dart';
import 'package:nexplore/screen/splashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  String initialRoute = AccountInformation.id;
  try {
    await Firebase.initializeApp();
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
      },
    );
  }
}
