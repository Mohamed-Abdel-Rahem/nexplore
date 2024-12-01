import 'package:flutter/material.dart';
import 'package:nexplore/constants/constant.dart';
import 'package:nexplore/firebase/models/firebaseServicesAuth.dart';
import 'package:nexplore/screen/loginScreeen.dart';
import 'package:nexplore/utils/extension/contextExtension.dart';
import 'package:nexplore/widgets/customButton.dart';
import 'package:nexplore/widgets/customTextButton.dart';
import 'package:nexplore/widgets/customTextForm.dart';
import 'package:nexplore/widgets/cutomText.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class SignUpScreeen extends StatefulWidget {
  const SignUpScreeen({super.key});
  static String id = 'SignUpScreeen';

  @override
  State<SignUpScreeen> createState() => _SignUpScreeenState();
}

class _SignUpScreeenState extends State<SignUpScreeen> {
  bool isChecked = false;
  String groupValue = 'Male';
  bool isLoading = false;
  String? email, password, username;
  final GlobalKey<FormState> formKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    final double avatarRadius = ScreenUtils.avatarRadius(context);
    final double screenHeight = ScreenUtils.screenHeight(context);
    final double screenWidth = ScreenUtils.screenWidth(context);

    return ModalProgressHUD(
      color: const Color.fromARGB(255, 54, 88, 155),
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Form(
          key: formKey,
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
                    height: screenHeight * 0.01,
                  ),
                  CustomText(
                    text: 'Join Nexplore',
                    color: const Color.fromARGB(255, 54, 88, 155),
                    fontSize: screenWidth * 0.08, // 8% of screen width
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  CustomText(
                    text: 'Create an account to get personalized ',
                    color: const Color(0xff6A8DC1),
                    fontSize: screenWidth * 0.04, // 4% of screen width
                  ),
                  CustomText(
                    text: 'recommendations',
                    color: const Color(0xff6A8DC1),
                    fontSize: screenWidth * 0.04, // 4% of screen width
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  CustomTextForm(
                    dataLabelText: 'Name',
                    dataHintText: 'Enter your Name',
                    isPassword: false,
                    prefixIcon: Image.asset(
                      width: screenWidth * 0.06,
                      height: screenWidth * 0.06,
                      'assets/icons/user.png',
                    ),
                    onChanged: (value) => username = value,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Email is required';
                      }
                    },
                  ),
                  CustomTextForm(
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
                  Padding(
                    padding:
                        EdgeInsets.symmetric(horizontal: screenWidth * 0.04),
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: CustomText(
                        text: 'Gender',
                        color: const Color(0xff6A8DC1),
                        fontSize: screenWidth * 0.06, // 4% of screen width
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        value: 'Male',
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value!;
                          });
                        },
                      ),
                      CustomText(
                        text: 'Male',
                        color: const Color(0xff6A8DC1),
                        fontSize: screenWidth * 0.05, // 5% of screen width
                      ),
                      const SizedBox(
                        width: 30,
                      ),
                      Radio(
                        value: 'Female',
                        groupValue: groupValue,
                        onChanged: (value) {
                          setState(() {
                            groupValue = value!;
                          });
                        },
                      ),
                      CustomText(
                        text: 'Female',
                        color: const Color(0xff6A8DC1),
                        fontSize: screenWidth * 0.05, // 5% of screen width
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Checkbox(
                        value: isChecked,
                        activeColor: Colors.blue,
                        onChanged: (newBool) {
                          setState(() {
                            isChecked = newBool!;
                          });
                        },
                      ),
                      CustomText(
                        color: const Color(0xff6A8DC1),
                        text: 'I agree to the Terms & Conditions ',
                        fontSize: 16,
                      ),
                    ],
                  ),
                  CustomButton(
                    onPressed: () async {
                      if (!isChecked) {
                        context.showSnack(
                            message:
                                'You must agree to the Terms & Conditions to proceed.');
                      }
                      if (formKey.currentState!.validate() && isChecked) {
                        setState(() {
                          isLoading = true;
                        });
                        await FirebaseServices.createAccount(
                          groupValue: groupValue,
                          email: email!,
                          password: password!,
                          context: context,
                          isLoading: isLoading,
                          username: username!,
                        );

                        setState(() {
                          isLoading = false;
                        });
                      }
                    },
                    color: const Color(0xff3A5A98),
                    txt: 'Sign Up',
                    vs: screenHeight * 0.013, // Button vertical padding
                    hs: screenWidth * 0.3, // Button horizontal padding
                  ),
                  SizedBox(
                    height: screenHeight * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                          text: 'Already have an account?',
                          color: const Color.fromARGB(255, 61, 63, 204),
                          fontSize: 16),
                      CustomTextButton(
                        text: 'Log In',
                        onPressed: () {
                          Navigator.pushReplacementNamed(
                            context,
                            LoginScreeen.id,
                          );
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
