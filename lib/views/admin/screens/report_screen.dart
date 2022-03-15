// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';
import 'package:intl/intl.dart';

// Project imports:
import 'package:resturant_app/core/controllers/orders_controller.dart';
import 'package:resturant_app/models/order_model.dart';
import 'package:resturant_app/shared/local/constants.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({
    Key? key,
    required this.orders,
  }) : super(key: key);
  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Report Details'),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => DayWidget(order: orders[index]),
          itemCount: orders.length,
        ));
  }
}

class DayWidget extends StatelessWidget {
  const DayWidget({Key? key, required this.order}) : super(key: key);

  final OrderModel order;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrdersController>(
      init: Get.find<OrdersController>(),
      builder: (controller) {
        Map staffOrders = controller.calculateStaffOrderCountOfDay(order.date);
        var names = [...staffOrders.keys];
        var counts = [...staffOrders.values];
        return Card(
          child: Column(
            children: [
              Container(
                  padding: const EdgeInsets.all(8),
                  width: MediaQuery.of(context).size.width,
                  color: Colors.grey.shade200,
                  child: Text(
                    DateFormat('dd-MM-yyyy').format(DateTime.parse(order.date)),
                    style: const TextStyle(
                      fontSize: 18,
                      color: KprimaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  )),
              Text(
                '${controller.getOrdersCountCompletedOfDate(order.date)} orders is done',
                style: const TextStyle(
                    fontSize: 16,
                    color: KprimaryColor,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline),
              ),
              ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  return Text(
                    '${names[index]} done ${counts[index]} orders',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  );
                },
                itemCount: staffOrders.keys.length,
              )
            ],
          ),
        );
      },
    );
  }
}
