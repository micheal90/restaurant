// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/auth_controller.dart';
import 'package:resturant_app/core/controllers/orders_controller.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/views/staff/screens/home/staff_home_screen.dart';
import 'package:resturant_app/views/user/screens/bottom_nav_bar_screen.dart';
import 'package:resturant_app/views/user/screens/onboarding/onboarding_screen.dart';
import 'package:resturant_app/views/user/screens/orders/submit_order.dart';
import 'admin/screens/admin_home_screen.dart';

class ControlView extends StatelessWidget {
  ControlView({Key? key}) : super(key: key);
  final authController = Get.find<AuthController>();
  final orderController = Get.find<OrdersController>();
  @override
  Widget build(BuildContext context) {
    return Obx(() {
     
        debugPrint('user role+${authController.userRole.value}');
        debugPrint('usermodel+${authController.userModel.value?.email}');
        debugPrint('user+${authController.user?.value}');

        if (authController.userModel.value == null ||
            authController.userRole.value == null ||
            authController.user?.value == null) {
          return const OnBoardingScreen();
        } else {
          if (authController.userRole.value == ROLE.USER) {
            FirebaseMessaging.instance.unsubscribeFromTopic('staff');

            //print(orderController.userOrderId);
            return orderController.userOrderId != null
                ? const SubmitOrderScreen()
                : const BottomNavBarScreen();
          } else if (authController.userRole.value == ROLE.STAFF) {
            FirebaseMessaging.instance.subscribeToTopic('staff');
            return StaffHomeScreen();
          } else if (authController.userRole.value == ROLE.ADMIN) {
            FirebaseMessaging.instance.unsubscribeFromTopic('staff');
            return const AdminHomeScreen();
          } else {
            return const OnBoardingScreen();
          }
        }
   
    });
  }
}
