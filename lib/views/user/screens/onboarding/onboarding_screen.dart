// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/views/user/screens/auth/login_screen.dart';
import 'package:resturant_app/views/user/screens/auth/widgets/custom_button.dart';
import 'package:resturant_app/views/user/screens/onboarding/widgets/background_image.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        const BackgroundImage(image: 'assets/images/onboarding.jpg'),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
          ),
          body: Column(
            children: [
              Flexible(
                child: Center(
                  child: Column(
                    children: [
                      Image.asset('assets/images/Group 19.png'),
                      const Text(
                        'Restaurant',
                        style: TextStyle(
                          fontSize: 36,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CustomButton(
                    text: 'Join Now',
                    onPressed: () => Get.offAll(const LogInScreen()),
                  ),
                  //  const SizedBox(height: 20,),
                  //    CustomButton(
                  //     text: 'Create Account',
                  //     onPressed:  ()=>Get.to(const SignUpScreen()),
                  //   ),
                  const SizedBox(
                    height: 20,
                  )
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
