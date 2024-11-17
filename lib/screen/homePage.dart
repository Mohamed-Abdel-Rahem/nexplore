import 'package:flutter/material.dart';
import 'package:nexplore/screen/loginScreeen.dart';
import 'package:nexplore/screen/signupScreen.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SignUpScreeen(),
    );
  }
}
