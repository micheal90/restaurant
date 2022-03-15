// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/auth_controller.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/views/user/screens/auth/signup_screen.dart';
import 'package:resturant_app/views/user/screens/auth/widgets/custom_button.dart';
import 'package:resturant_app/views/user/screens/auth/widgets/custom_input_text_filed.dart';
import 'package:resturant_app/views/user/screens/auth/widgets/login_icon.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var authController = Get.find<AuthController>();
  bool _showPass = false;
  void _submit(BuildContext context) async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    await authController.signIn(
        _emailController.text.trim(), _passwordController.text.trim());
  }

  void changeShowPassword() {
    setState(() {
      _showPass = !_showPass;
    });
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KbackGroundColor,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body:  SingleChildScrollView(
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
                      'LOGIN',
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            fontWeight: FontWeight.bold,
                            color: KprimaryColor,
                          ),
                    ),
                    const SizedBox(
                      height: 80,
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
                      height: 10,
                    ),
                    Container(
                      child: const Text(
                        'Forget Password',
                        style: TextStyle(
                          decoration: TextDecoration.underline,
                        ),
                      ),
                      alignment: Alignment.centerRight,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LogInIcon(
                          image: 'assets/images/google-48.png',
                          onTap: () {
                            debugPrint('Login with google');
                          },
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        LogInIcon(
                          image: 'assets/images/twitter-48.png',
                          onTap: () {},
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        LogInIcon(
                          image: 'assets/images/facebook-48.png',
                          onTap: () {},
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Obx(() => authController.isLoading.value
                        ? const CircularProgressIndicator()
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: CustomButton(
                                  text: 'Login',
                                  onPressed: () => _submit(context),
                                ),
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: CustomButton(
                                  text: 'SignUp',
                                  onPressed: () => Get.to(const SignUpScreen()),
                                ),
                              ),
                            ],
                          )),
                  ],
                ),
              ),
            ),
          ),
        ),
      
    );
  }
}
