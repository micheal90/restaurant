// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/cart_controller.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/views/user/screens/delivery/delivery_screen.dart';
import 'package:resturant_app/views/user/screens/home/user_home_screen.dart';
import 'package:resturant_app/views/user/screens/orders/order_screen.dart';
import 'package:resturant_app/views/user/screens/profile/profile_screen.dart';
import 'package:resturant_app/views/user/screens/settings/settings_screen.dart';

class BottomNavBarScreen extends StatefulWidget {
  const BottomNavBarScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  final List<Widget> pages = [
    const SettingsScreen(),
    const OrderScreen(),
    const UserHomeScreen(),
    const DeliveryScreen(),
    const ProfileScreen(),
  ];
  var _currentIndex = 2;
  // final CartController cartController = Get.find<CartController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.black,
        color: KprimaryColor,
        activeColor: Colors.white,

        items: [
          const TabItem(
            icon: Icon(
              Icons.settings,
              color: KprimaryColor,
            ),
            title: 'Settings',
          ),
          TabItem(
            icon: GetBuilder<CartController>(
              init: Get.find<CartController>(),
              builder: (controller) => Stack(
                clipBehavior: Clip.none,
                alignment: Alignment.center,
                children: [
                  if (controller.listCartItems.isNotEmpty && _currentIndex != 1)
                    Positioned(
                      top: -5,
                      right: -10,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: const BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                        child: Center(
                          child: Text(
                            controller.listCartItems.length.toString(),
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  Image.asset(
                    'assets/images/dinner.png',
                    color: KprimaryColor,
                  ),
                ],
              ),
            ),
            title: 'Orders',
          ),
          TabItem(
              icon: Image.asset(
                'assets/images/home.png',
                color: KprimaryColor,
              ),
              title: 'Home'),
          TabItem(
              icon: Image.asset(
                'assets/images/delivery-truck.png',
                color: KprimaryColor,
              ),
              title: 'Delivery'),
          TabItem(
              icon: Image.asset(
                'assets/images/user-profile.png',
                color: KprimaryColor,
              ),
              title: 'Profile'),
        ],
        initialActiveIndex: 2, //optional, default as 0
        onTap: (int i) => setState(() {
          _currentIndex = i;
          debugPrint(_currentIndex.toString());
        }),
      ),
    );
  }
}
