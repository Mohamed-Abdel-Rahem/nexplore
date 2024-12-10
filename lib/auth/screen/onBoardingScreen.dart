import 'package:flutter/material.dart';
import 'package:nexplore/auth/constants/constant.dart';
import 'package:nexplore/auth/screen/loginScreeen.dart';
import 'package:nexplore/auth/widgets/customPageBuilder.dart';
import 'package:nexplore/auth/widgets/customTextOnboarding.dart';
import 'package:nexplore/auth/widgets/nextButton.dart';
import 'package:nexplore/auth/widgets/skipButton.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});
  static String id = 'OnBoardingScreen';

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  late PageController nextPage;
  int pageNumber = 0;

  Widget dotPageView() {
    return Builder(
      builder: (context) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            for (int i = 0; i < 3; i++)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 5),
                width: i == pageNumber ? 25 : 6,
                height: 6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: i == pageNumber
                      ? Colors.white
                      : const Color.fromARGB(255, 87, 86, 86),
                ),
              ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    nextPage = PageController();
    setVisitFlag();
  }

  @override
  void dispose() {
    super.dispose();
    nextPage.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenHeight = ScreenUtils.screenHeight(context);
    final double screenWidth = ScreenUtils.screenWidth(context);

    return SafeArea(
      child: Scaffold(
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
          child: PageView(
            onPageChanged: (value) {
              setState(() {
                pageNumber = value;
              });
            },
            controller: nextPage,
            children: [
              //page 0
              Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: SkipButton(context),
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  CustomPageBuilder(
                    imagePath: 'assets/characters/1.png',
                  ),
                  CustomTextOnBoarding(
                    color: Colors.white,
                    text: 'Discover Movies You Love',
                    fontSize: screenWidth * 0.06,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  CustomTextOnBoarding(
                    color: const Color(0xffCECED9),
                    text:
                        'Explore a personalized collection of movies tailored to \n your unique taste. Nexplore helps you\n uncover  hidden gems and\n trending films just for you.',
                    fontSize: screenWidth * 0.035,
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  dotPageView(),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  NextButton(
                    context: context,
                    onPressed: () {
                      nextPage.animateToPage(1,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeIn);
                    },
                  ),
                ],
              ),
              //page 1
              Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: SkipButton(context),
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  CustomPageBuilder(
                    imagePath: 'assets/characters/2.png',
                  ),
                  CustomTextOnBoarding(
                    color: Colors.white,
                    text: 'Connect with Movie Enthusiasts',
                    fontSize: screenWidth * 0.06,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  CustomTextOnBoarding(
                    color: const Color(0xffCECED9),
                    text:
                        'Join a community of movie lovers! Share recommendations,\n reviews, and discover what\'s popular among\n friends and fellow cinephiles',
                    fontSize: screenWidth * 0.035,
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  dotPageView(),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  NextButton(
                    context: context,
                    onPressed: () {
                      nextPage.animateToPage(2,
                          duration: const Duration(milliseconds: 700),
                          curve: Curves.easeIn);
                    },
                  ),
                ],
              ),
              //page 2
              Column(
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: SkipButton(context),
                  ),
                  SizedBox(height: screenHeight * 0.07),
                  CustomPageBuilder(
                    imagePath: 'assets/characters/3.png',
                  ),
                  CustomTextOnBoarding(
                    color: Colors.white,
                    text: 'Connect with Movie Enthusiasts',
                    fontSize: screenWidth * 0.06,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  CustomTextOnBoarding(
                    color: const Color(0xffCECED9),
                    text:
                        'Save time searching—Nexplore\n recommends movies you\'ll\n enjoy based on your preferences,\n making every movie night unforgettable.',
                    fontSize: screenWidth * 0.035,
                  ),
                  SizedBox(
                    height: screenHeight * 0.05,
                  ),
                  dotPageView(),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  NextButton(
                    context: context,
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, LoginScreeen.id);
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setVisitFlag() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool('vis', true);
  }
}
