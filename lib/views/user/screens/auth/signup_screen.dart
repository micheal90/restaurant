// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/auth_controller.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/views/user/screens/auth/widgets/custom_button.dart';
import 'package:resturant_app/views/user/screens/auth/widgets/custom_input_text_filed.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var controller = Get.find<AuthController>();
  bool _showPass = false;

  void changeShowPassword() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  void _submit(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    await controller.signUp(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        isUser: true);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: KbackGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () => Get.back(),
            icon: const Icon(
              Icons.arrow_back_rounded,
              color: KprimaryColor,
            )),
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
                      height: 50,
                    ),
                    Text(
                      'WELCOME..',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Text(
                      'SIGN UP',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: KprimaryColor,
                          ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    CustomInputTextField(
                      controller: _nameController,
                      lable: 'Name',
                      icon: Icons.person,
                      hint: 'User',
                      inputType: TextInputType.text,
                      inputAction: TextInputAction.next,
                      validator: (String? value) {
                        if (value!.isEmpty) return 'Enter the email';
                      },
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomInputTextField(
                      lable: 'Email',
                      controller: _emailController,
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
                      isPassword: _showPass ? false : true,
                      suffixIcon: IconButton(
                        icon: _showPass
                            ? const Icon(Icons.visibility_off_rounded)
                            : const Icon(Icons.visibility),
                        onPressed: changeShowPassword,
                      ),
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
                    Obx(() => controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            text: 'Continue',
                            onPressed: () => _submit(context)))
                  ],
                ),
              ),
            ),
          ),
        ),
      
    );
  }
}
