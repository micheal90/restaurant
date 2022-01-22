// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/orders_controller.dart';
import 'package:resturant_app/models/cart_item.dart';
import 'package:resturant_app/shared/local/constants.dart';

class MyOrderItemStaff extends StatelessWidget {
  const MyOrderItemStaff({
    Key? key,
    required this.orderId,
    required this.imageUrl,
    required this.name,
    required this.tableNum,
    required this.status,
    required this.totalPrice,
    required this.items,
    this.nameOfStaff,
  }) : super(key: key);
  final String orderId;
  final String imageUrl;
  final String name;
  final int tableNum;
  final String status;
  final String? nameOfStaff;
  final double totalPrice;
  final List<CartItem> items;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () async => orderDetails(context),
        isThreeLine: true,
        leading: FancyShimmerImage(
          width: 80,
          boxFit: BoxFit.cover,
          imageUrl: imageUrl,
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Table $tableNum\n\$ $totalPrice'),
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Row(
            children: [
              IconButton(
                  onPressed: () async =>
                      await Get.find<OrdersController>().unTakeOrder(orderId),
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                    size: 30,
                  )),
              GestureDetector(
                onTap: () {},
                child: Container(
                  width: 120,
                  height: 40,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(color: selectColor()),
                  child: Text(
                    status,
                    style: const TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> orderDetails(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              name,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Table $tableNum',
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const Text(
              'Items:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shrinkWrap: true,
              itemBuilder: (context, index) => Text(
                items[index].name,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              itemCount: items.length,
            ),
            Align(
                alignment: Alignment.centerRight,
                child: Text(
                  'Total Price: $totalPrice\$',
                  style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      decoration: TextDecoration.underline),
                )),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  selectColor() {
    if (status == 'Waiting') {
      return Colors.red;
    } else if (status == 'Takes') {
      return Colors.blue;
    } else if (status == 'Completed') {
      return Colors.green;
    } else {
      return KprimaryColor;
    }
  }
}
