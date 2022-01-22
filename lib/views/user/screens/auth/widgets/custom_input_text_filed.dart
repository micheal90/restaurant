// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:resturant_app/shared/local/constants.dart';

class CustomInputTextField extends StatelessWidget {
  const CustomInputTextField({
    Key? key,
    required this.lable,
    required this.icon,
    this.suffixIcon,
    required this.hint,
    this.isPassword=false,
    this.inputType,
    this.inputAction,
    this.validator,
    this.onSave,
    this.controller,
  }) : super(key: key);
  final String lable;
  final IconData icon;
  final Widget? suffixIcon;
  final bool isPassword;

  final String hint;
  final TextInputType? inputType;
  final TextInputAction? inputAction;
  final Function? validator;
  final Function? onSave;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(lable),
        TextFormField(
          controller: controller,
          decoration: InputDecoration(
            icon: Icon(
              icon,
              color: KprimaryColor,
            ),
            suffixIcon: suffixIcon,
            hintText: hint,
          ),
          obscureText: isPassword,
          textInputAction: inputAction,
          keyboardType: inputType,
          validator: validator as String? Function(String?)?,
          onSaved: onSave as void Function(String?)?,
        ),
      ],
    );
  }
}
