import 'package:flutter/material.dart';
import 'package:nexplore/constants/constant.dart';
import 'package:nexplore/screen/accountInfo.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});
  static String id = 'Homepage';

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = ScreenUtils.avatarRadius(context);
    final double screenHeight = ScreenUtils.screenHeight(context);
    final double screenWidth = ScreenUtils.screenWidth(context);

    return const Scaffold(
      body: AccountInformation(),
    );
  }
}
