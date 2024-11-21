import 'package:flutter/material.dart';
import 'package:nexplore/screen/loginScreeen.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  static String id = 'Homepage';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LoginScreeen(),
    );
  }
}
