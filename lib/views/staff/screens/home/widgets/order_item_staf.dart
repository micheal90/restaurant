// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/orders_controller.dart';
import 'package:resturant_app/models/cart_item.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/views/user/screens/auth/widgets/custom_button.dart';

class OrderItemStaff extends StatelessWidget {
  final OrdersController controller = Get.find<OrdersController>();

  OrderItemStaff({
    Key? key,
    required this.orderId,
    required this.imageUrl,
    required this.name,
    required this.tableNum,
    required this.status,
    this.nameOfStaff,
    required this.items,
    required this.totalPrice,
  }) : super(key: key);
  final String orderId;
  final String imageUrl;
  final String name;
  final int tableNum;
  final String status;
  final String? nameOfStaff;
  final List<CartItem> items;
  final double totalPrice;
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () => orderDetails(context),
        leading: FancyShimmerImage(
          imageUrl: imageUrl,
          width: 80,
          boxFit: BoxFit.cover,
        ),
        title: Text(
          name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text('Table $tableNum\n\$ $totalPrice'),
        isThreeLine: true,
        trailing: FittedBox(
          fit: BoxFit.fill,
          child: Column(
            children: [
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
              if (nameOfStaff != null)
                const SizedBox(
                  height: 5,
                ),
              if (nameOfStaff != null) Text('By: ${nameOfStaff!}'),
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> orderDetails(BuildContext context) {
    _takeOrder(OrdersController controller) async {
      await controller.takeOrder(orderId);
      Get.back();
    }

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
              itemBuilder: (context, index) => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    items[index].name,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600
                    ),
                  ),
                
                   Text(
                    'X ${items[index].quantity}',
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                  ),
                ],
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
            Obx(
              () => controller.isLoading.value
                  ? const Center(child: CircularProgressIndicator())
                  : status == STATUS.WAITING.name
                      ? CustomButton(
                          width: MediaQuery.of(context).size.width,
                          text: 'Take Order',
                          onPressed: () => _takeOrder(controller),
                        )
                      : Container(),
            ),
          ],
        ),
      ),
    );
  }

  selectColor() {
    if (status == STATUS.WAITING.name) {
      return Colors.red;
    } else if (status == STATUS.TAKES.name) {
      return Colors.blue;
    } else if (status == STATUS.COMPLETED.name) {
      return Colors.green;
    } else {
      return KprimaryColor;
    }
  }
}
