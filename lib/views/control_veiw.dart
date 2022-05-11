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
      if (authController.userModel.value != null) {
        if (authController.userModel.value!.role == ROLE.ADMIN.name) {
          FirebaseMessaging.instance.unsubscribeFromTopic('staff');
          return const AdminHomeScreen();
        } else if (authController.userModel.value!.role == ROLE.STAFF.name) {
          FirebaseMessaging.instance.subscribeToTopic('staff');
          return StaffHomeScreen();
        } else {
          FirebaseMessaging.instance.unsubscribeFromTopic('staff');
          return orderController.userOrderId != null
              ? const SubmitOrderScreen()
              : const BottomNavBarScreen();
        }
      } else {
        return const OnBoardingScreen();
      }
    });
  }
}
