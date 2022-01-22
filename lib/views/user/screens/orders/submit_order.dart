// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/orders_controller.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/views/control_veiw.dart';
import 'package:resturant_app/views/user/screens/auth/widgets/custom_button.dart';

class SubmitOrderScreen extends GetWidget<OrdersController> {
  const SubmitOrderScreen({Key? key}) : super(key: key);
  static const routeName = '/submitOrder';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Container(
            padding: const EdgeInsets.all(20),
            width: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
              border: Border.all(color: KprimaryColor),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Obx(
              () => Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Thank You',
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: KprimaryColor,
                    ),
                  ),
                  const Text(
                    'To Order',
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  const Image(
                    image: AssetImage('assets/images/Group 46.png'),
                    width: 200,
                    height: 200,
                  ),
                  RichText(
                      textAlign: TextAlign.center,
                      text: const TextSpan(
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          text:
                              'Your order well be on your table soon, please when you have finished eating Click On ',
                          children: [
                            TextSpan(
                                text: 'Finish',
                                style: TextStyle(
                                    color: KprimaryColor, fontSize: 18))
                          ])),
                  const SizedBox(
                    height: 20,
                  ),
                  controller.isLoading.value
                      ? const CircularProgressIndicator()
                      : CustomButton(
                          text: 'Finish',
                          onPressed: () async {
                            debugPrint('pressed');
                            var resp = await Get.find<OrdersController>()
                                .finishEating();
                            if (resp) {
                              Get.off(ControlView());
                            }
                          })
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
