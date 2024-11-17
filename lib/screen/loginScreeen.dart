import 'package:flutter/material.dart';
import 'package:nexplore/widgets/customButton.dart';
import 'package:nexplore/widgets/customTextButton.dart';
import 'package:nexplore/widgets/customTextForm.dart';
import 'package:nexplore/widgets/cutomText.dart';

class Loginscreeen extends StatefulWidget {
  const Loginscreeen({super.key});

  @override
  State<Loginscreeen> createState() => _LoginscreeenState();
}

class _LoginscreeenState extends State<Loginscreeen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const CircleAvatar(
              radius: 75,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage(
                'assets/images/remplayicon.png',
              ),
            ),
            CutomText(
              text: 'Welcome Back',
              color: const Color(0xff1A73E8),
              fontSize: 32,
            ),
            CutomText(
              text: 'Sign in to continue exploring.',
              color: const Color(0xff6A8DC1),
              fontSize: 16,
            ),
            CustomTextForm(
              dataLabelText: 'Email',
              dataHintText: 'Enter your email',
              isPassword: false,
              prefixIcon: const Icon(
                Icons.account_box,
                color: Colors.black,
              ),
            ),
            CustomTextForm(
              dataLabelText: 'Password',
              dataHintText: 'Enter your Password',
              isPassword: true,
              prefixIcon: const Icon(
                Icons.lock,
                color: Colors.black,
              ),
            ),
            CustomTextButton(
              onPressed: () {},
              text: 'Forget Password ?',
            ),
            CustomButton(
              onPressed: () {},
              color: const Color(0xff1A73E8),
              txt: 'Login',
              vs: 5,
              hs: 130,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CutomText(
                  color: Colors.black,
                  text: 'Do not have an account ?',
                  fontSize: 20,
                ),
                CustomTextButton(
                  text: 'SignUp',
                  onPressed: () {},
                )
              ],
            )
            // TextButton(
            //   onPressed: () {},
            //   child: const Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Text(
            //         'Do not have an account ?',
            //         style: TextStyle(
            //             color: Colors.black,
            //             fontSize: 20,
            //             fontWeight: FontWeight.bold),
            //       ),
            //       Text(
            //         'SignUp',
            //         style: TextStyle(
            //           fontSize: 19,
            //           color: Colors.blue,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
