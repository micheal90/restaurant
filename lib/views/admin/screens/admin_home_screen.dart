// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/auth_controller.dart';
import 'package:resturant_app/core/controllers/orders_controller.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/views/admin/screens/add_staff_screen.dart';
import 'package:resturant_app/views/admin/screens/delete_staff_screen.dart';
import 'package:resturant_app/views/admin/screens/report_screen.dart';
import 'package:resturant_app/views/admin/screens/update_staff_screen.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: [
          TextButton(
            onPressed: () => Get.find<AuthController>().signOut(),
            child: const Text('LogOut'),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            GetBuilder<OrdersController>(
              init: Get.find<OrdersController>(),
              builder: (controller) => Row(
                children: [
                  ReportContainer(
                    title: 'Reports',
                    text: 'Of Day',
                    onTap: () => Get.to(ReportScreen(
                        orders: controller.listComplitedOrderOfDay())),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ReportContainer(
                    title: 'Reports',
                    text: 'Of Week',
                    onTap: () => Get.to(ReportScreen(
                          orders: controller.listCompletedOrderOfWeek())),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ReportContainer(
                    title: 'Reports',
                    text: 'Of Month',
                    onTap: () => Get.to(ReportScreen(
                      orders: controller.listComplitedOrderOfmonth(),
                    )),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            staffReportSection(),
            const SizedBox(
              height: 20,
            ),
            Column(
              children: [
                const Text(
                  'Staff Actions',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                        onPressed: () => Get.to(const AddStaffScreen()),
                        child: const Text('Add Staff')),
                    ElevatedButton(
                        onPressed: () => Get.to(UpdateStaffScreen()),
                        child: const Text('Update Staff')),
                    ElevatedButton(
                        onPressed: () => Get.to(const DeleteStaffScreen()),
                        child: const Text('Delete Staff')),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Container staffReportSection() {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey.shade400,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Staff Reports',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                    color: KprimaryColor, shape: BoxShape.circle),
              ),
              const SizedBox(
                width: 10,
              ),
              GetBuilder<AuthController>(
                init: Get.find<AuthController>(),
                builder:(controller) => Text('${controller.staffs.length} Staff')),
            ],
          ),
          Row(
            children: [
              Container(
                height: 10,
                width: 10,
                decoration: const BoxDecoration(
                    color: KprimaryColor, shape: BoxShape.circle),
              ),
              const SizedBox(
                width: 10,
              ),
              GetBuilder<OrdersController>(
                init: Get.find<OrdersController>(),
                builder:(controller) => Text('${controller.orders.length} Orders')),
            ],
          ),
          Align(
            alignment: Alignment.topRight,
            child: OutlinedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.white),
              ),
              onPressed: () {},
              child: const Text(
                'Watch',
                style: TextStyle(color: Colors.black),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class ReportContainer extends StatelessWidget {
  const ReportContainer({
    Key? key,
    required this.text,
    required this.title,
    this.onTap,
  }) : super(key: key);
  final String text;
  final String title;
  final Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: KprimaryColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title.toString(),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(text),
            ],
          ),
        ),
      ),
    );
  }
}
