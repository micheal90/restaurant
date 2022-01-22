// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/orders_controller.dart';
import 'package:resturant_app/models/order_model.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/views/staff/screens/my_order/widgets/my_order_item_staff.dart';

class MyOrderStaff extends GetWidget<OrdersController> {
  const MyOrderStaff({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Order'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Obx(
        () {
          List<OrderModel> orders =
              sortAndReverseOrderList(controller.progressingOrder);
          return controller.progressingOrder.isEmpty
              ? const Center(
                  child: Text(
                  'You have not taken any order yet',
                  style: TextStyle(fontSize: 18),
                ))
              : controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemBuilder: (context, index) => MyOrderItemStaff(
                        orderId: orders[index].orderId!,
                        imageUrl: controller
                            .progressingOrder[index].items.first.imageUrl,
                        name: orders[index].name,
                        tableNum: int.parse(orders[index].tableNumber),
                        status: orders[index].status,
                        totalPrice: orders[index].totalPrice,
                        items: orders[index].items,
                      ),
                      itemCount: orders.length,
                    );
        },
      ),
    );
  }
}
