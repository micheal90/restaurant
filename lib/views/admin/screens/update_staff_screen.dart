// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/auth_controller.dart';
import 'package:resturant_app/views/user/screens/auth/widgets/custom_button.dart';
import 'package:resturant_app/views/user/screens/auth/widgets/custom_input_text_filed.dart';

class UpdateStaffScreen extends StatelessWidget {
  UpdateStaffScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var controller = Get.find<AuthController>();
  void _submit(BuildContext context)async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    await controller.updateStaffData(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        isUser: false);
    Get.back();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Staff'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 80,
                    ),
                    CustomInputTextField(
                      controller: _nameController,
                      lable: 'Name',
                      icon: Icons.person,
                      hint: 'User',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Enter the name';
                      },
                      
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomInputTextField(
                      controller: _emailController,
                      lable: 'Email',
                      icon: Icons.email_outlined,
                      hint: 'example@gmail.com',
                      inputType: TextInputType.emailAddress,
                      inputAction: TextInputAction.next,
                      validator: (String? value) {
                        if (!GetUtils.isEmail(value!)) return 'Enter the email';
                      },
                     
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomInputTextField(
                      controller: _passwordController,
                      lable: 'Password',
                      icon: Icons.lock,
                      hint: '********',
                      inputType: TextInputType.visiblePassword,
                      inputAction: TextInputAction.next,
                      validator: (String? value) {
                        if (value!.isEmpty && value.length < 6) {
                          return 'Enter a valid password';
                        }
                      },
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    CustomButton(
                        text: 'Update', onPressed: () => _submit(context))
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
