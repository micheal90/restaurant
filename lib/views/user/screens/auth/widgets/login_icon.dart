// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:resturant_app/shared/local/constants.dart';

class LogInIcon extends StatelessWidget {
  const LogInIcon({
    Key? key,
    required this.image,
    required this.onTap,
  }) : super(key: key);
  final String image;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.15,
        width: size.width * 0.15,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: KprimaryColor),
        ),
        child: Image.asset(
          image,
        ),
      ),
    );
  }
}
