// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/auth_controller.dart';
import 'package:resturant_app/core/controllers/orders_controller.dart';
import 'package:resturant_app/models/order_model.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/views/staff/screens/home/widgets/order_item_staf.dart';
import 'package:resturant_app/views/staff/screens/my_order/my_order.dart';

class StaffHomeScreen extends StatelessWidget {
  StaffHomeScreen({Key? key}) : super(key: key);
  final OrdersController orderController = Get.find<OrdersController>();
  final AuthController authController = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Obx(
            () => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  authController.userModel.value!.name,
                  style: const TextStyle(fontSize: 16),
                ),
                Text(
                  authController.userModel.value!.role,
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Get.to(const MyOrderStaff()),
              child: const Text('My Order'),
            ),
          ],
          bottom: TabBar(tabs: [
            Tab(
              icon: Image.asset(
                'assets/images/dinner.png',
                color: KprimaryColor,
              ),
              text: 'Orders',
            ),
            const Tab(
              icon: Icon(
                Icons.done_outline_outlined,
                color: KprimaryColor,
              ),
              text: 'Completed',
            )
          ]),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: TabBarView(children: [
          ordersPage(),
          completedPage(),
        ]),
        drawer: staffDrawer(),
      ),
    );
  }

  Drawer staffDrawer() {
    return Drawer(
      child: Obx(
        () => Column(
          children: [
            AppBar(
              leading: const CircleAvatar(
                backgroundImage: AssetImage(
                  'assets/images/profile.jpg',
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    authController.userModel.value!.name,
                    style: const TextStyle(fontSize: 16),
                  ),
                  Text(
                    authController.userModel.value!.role,
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            const SizedBox(
              height: 20,
            ),
            ListTile(
              onTap: () => Get.to(const MyOrderStaff()),
              leading: const Icon(Icons.my_library_books_outlined),
              title: const Text('My Order'),
              trailing: const Icon(
                Icons.arrow_forward_ios,
                color: KprimaryColor,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            TextButton.icon(
                onPressed: () => Get.find<AuthController>().signOut(),
                icon: const Icon(Icons.logout),
                label: const Text('LOGOUT')),
            
          ],
        ),
      ),
    );
  }

  // final List<Map<String, dynamic>> _orders = const [
  //   {
  //     'imageUrl':
  //         'https://www.burgerbar.nl/wp-content/uploads/BURGERBAR_campagne-website_BURGER_01.png',
  //     'name': 'Ali',
  //     'table_num': 4,
  //     'status': 'Waiting',
  //     'items': ['Burger', 'Cheese Burger', 'Pizza', 'Pepci'],
  //     'totalPrice': 2500.0,
  //   },
  //   {
  //     'imageUrl':
  //         'https://www.burgerbar.nl/wp-content/uploads/BURGERBAR_campagne-website_BURGER_01.png',
  //     'name': 'Saad',
  //     'table_num': 1,
  //     'status': 'Takes',
  //     'items': ['Burger', 'Cheese Burger', 'Pizza', 'Pepci'],
  //     'totalPrice': 5000.0,
  //   },
  //   {
  //     'imageUrl':
  //         'https://www.burgerbar.nl/wp-content/uploads/BURGERBAR_campagne-website_BURGER_01.png',
  //     'name': 'Ahmad',
  //     'table_num': 6,
  //     'status': 'Progressing',
  //     'items': ['Burger', 'Cheese Burger', 'Pizza', 'Pepci'],
  //     'totalPrice': 2500.0,
  //   },
  //   {
  //     'imageUrl':
  //         'https://www.burgerbar.nl/wp-content/uploads/BURGERBAR_campagne-website_BURGER_01.png',
  //     'name': 'Georges',
  //     'table_num': 6,
  //     'status': 'Completed',
  //     'name_of_staff': 'Mohammad Noor',
  //     'items': ['Burger', 'Cheese Burger', 'Pizza', 'Pepci'],
  //     'totalPrice': 2500.0,
  //   },
  // ];
  // List get _orderCompleted =>
  //     _orders.where((element) => element['status'] == 'Completed').toList();
  // final OrdersController ordersController = Get.find<OrdersController>();
  ordersPage() {
    return Obx(
      () {
        List<OrderModel> orders =
            sortAndReverseOrderList(orderController.takesAndWationgOrder);
        return ListView.builder(
          itemBuilder: (context, index) => OrderItemStaff(
              orderId: orders[index].orderId!,
              imageUrl: orderController
                  .takesAndWationgOrder[index].items.first.imageUrl,
              name: orders[index].name,
              tableNum: int.parse(orders[index].tableNumber),
              status: orders[index].status,
              items: orders[index].items,
              totalPrice: orders[index].totalPrice,
              nameOfStaff: orders[index].staffName,
            ),
          itemCount: orders.length,
        );
      },
    );
  }

  completedPage() {
    return Obx(
      () {
         List<OrderModel> orders =
            sortAndReverseOrderList(orderController.completedOrder);
        return ListView.builder(
        itemBuilder: (context, index) => OrderItemStaff(
          orderId: orders[index].orderId!,
          imageUrl: orders[index].items.first.imageUrl,
          name: orders[index].name,
          tableNum:
              int.parse(orders[index].tableNumber),
          status: orders[index].status,
          items: orders[index].items,
          totalPrice: orders[index].totalPrice,
          nameOfStaff:  orders[index].staffName,
        ),
        itemCount: orders.length,
      );
      },
    );
  }
}
