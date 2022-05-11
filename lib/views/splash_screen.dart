// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/views/control_veiw.dart';



class SplashScreens extends StatelessWidget {
  const SplashScreens({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return splash1();
  }

  Scaffold splash1() {
    return Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/Group 19.png',
            color: KprimaryColor,
          ),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'Restaurant',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    ),
  );
  }
}
