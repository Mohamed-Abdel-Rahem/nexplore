import 'package:flutter/material.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:nexplore/auth/constants/constant.dart';
import 'package:nexplore/auth/firebase/models/firebaseServicesAuth.dart';
import 'package:nexplore/auth/screen/foregtPassword.dart';
import 'package:nexplore/auth/screen/signupScreen.dart';
import 'package:nexplore/auth/widgets/customButton.dart';
import 'package:nexplore/auth/widgets/customTextButton.dart';
import 'package:nexplore/auth/widgets/customTextForm.dart';
import 'package:nexplore/auth/widgets/cutomText.dart';

class LoginScreeen extends StatefulWidget {
  const LoginScreeen({super.key});
  static String id = 'LoginScreeen';
  @override
  State<LoginScreeen> createState() => _LoginScreeenState();
}

class _LoginScreeenState extends State<LoginScreeen> {
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey();

  String? email, password;
  @override
  Widget build(BuildContext context) {
    final double avatarRadius = ScreenUtils.avatarRadius(context);
    final double screenHeight = ScreenUtils.screenHeight(context);
    final double screenWidth = ScreenUtils.screenWidth(context);

    return ModalProgressHUD(
      inAsyncCall: isLoading,
      color: const Color.fromARGB(255, 54, 88, 155),
      child: Scaffold(
        body: Form(
          key: _formKey,
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  CircleAvatar(
                    radius: avatarRadius,
                    backgroundColor: Colors.white,
                    backgroundImage: const AssetImage(
                      'assets/images/remplayicon.png',
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ), // 2% of screen height
                  CustomText(
                    text: 'Welcome Back',
                    color: const Color(0xff1A73E8),
                    fontSize: screenWidth * 0.08, // 8% of screen width
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ), // 1% of screen height
                  CustomText(
                    text: 'Sign in to continue exploring.',
                    color: const Color(0xff6A8DC1),
                    fontSize: screenWidth * 0.04, // 4% of screen width
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ), // 3% of screen height
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: CustomTextForm(
                      dataLabelText: 'Email',
                      dataHintText: 'Enter your email',
                      isPassword: false,
                      prefixIcon: Image.asset(
                        width: screenWidth * 0.06, // 6% of screen width
                        height: screenWidth * 0.06,
                        'assets/icons/email.png',
                      ),
                      onChanged: (value) => email = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required';
                        }
                        final emailRegex =
                            RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                        if (!emailRegex.hasMatch(value)) {
                          return 'Enter a valid email address';
                        }
                        return null; // No error
                      },
                    ),
                  ),
                  CustomTextForm(
                    dataLabelText: 'Password',
                    dataHintText: 'Enter your password',
                    isPassword: true,
                    prefixIcon: Image.asset(
                      'assets/icons/lock.png',
                    ),
                    onChanged: (value) => password = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Password is required';
                      }
                    },
                  ),
                  CustomTextButton(
                    onPressed: () {
                      Navigator.pushReplacementNamed(
                          context, ForgetPasswordScreen.id);
                    },
                    text: 'Forget Password ?',
                  ),
                  CustomButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        isLoading = true;
                        setState(() {});
                        FirebaseServices.loginUsers(
                          email: email!,
                          password: password!,
                          context: context,
                        );

                        isLoading = false;
                        setState(() {});
                      }
                    },
                    color: const Color(0xff1A73E8),
                    txt: 'Login',
                    vs: screenHeight * 0.013, // Button vertical padding
                    hs: screenWidth * 0.3, // Button horizontal padding
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        color: const Color.fromARGB(255, 61, 63, 204),
                        text: 'Do not have an account ?',
                        fontSize: screenWidth * 0.045, // 4.5% of screen width
                      ),
                      CustomTextButton(
                        text: 'SignUp',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                              context, SignUpScreeen.id);
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
