// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/cart_controller.dart';
import 'package:resturant_app/core/controllers/orders_controller.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/views/user/screens/auth/widgets/custom_button.dart';
import 'package:resturant_app/views/user/screens/orders/submit_order.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final OrdersController ordersController = Get.find<OrdersController>();
  final _formKey = GlobalKey<FormState>();
  final _tableNumController = TextEditingController();

  void _submit() async {
    FocusScope.of(context).unfocus();
    if (Get.find<CartController>().listCartItems.isEmpty) {
      Get.snackbar('Cart is empty!', 'Add items to make order, please.',
          snackPosition: SnackPosition.TOP);
    } else {
      if (!_formKey.currentState!.validate()) return;
      await Get.find<OrdersController>()
          .addOrder(_tableNumController.text.trim())
          .then((value) {
        Get.off(const SubmitOrderScreen());
        Get.find<CartController>().clearCart();
      });
    }
  }

  @override
  void dispose() {
    super.dispose();
    _tableNumController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: GetBuilder<CartController>(
        init: Get.find<CartController>(),
        builder: (controller) => Column(
          children: [
            Expanded(
              child: controller.listCartItems.isEmpty
                  ? const Center(
                      child: Text(
                        'No orders yet, please select items to make an order',
                        style: TextStyle(
                          fontSize: 18,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.separated(
                      itemCount: controller.listCartItems.length,
                      itemBuilder: (context, index) => ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: FancyShimmerImage(
                            width: 80,
                            boxFit: BoxFit.cover,
                            imageUrl: controller.listCartItems[index].imageUrl,
                          ),
                        ),
                        title: Text(controller.listCartItems[index].name),
                        subtitle: Row(
                          children: [
                            // SizedBox(
                            //   height: 50,
                            //   child: DropdownButton(
                            //     value: _dropDownValue,
                            //     onChanged: (String? value) => setState(() {
                            //       _dropDownValue = value!;
                            //     }),
                            //     items: [
                            //       '1',
                            //       '2',
                            //       '3',
                            //       '4',
                            //       '5',
                            //       '6',
                            //       '7',
                            //       '8',
                            //       '9',
                            //       '10',
                            //       '11',
                            //       '12',
                            //       '13',
                            //       '14',
                            //       '15',
                            //     ]
                            //         .map((e) => DropdownMenuItem(
                            //               child: Text(e),
                            //               value: e,
                            //             ))
                            //         .toList(),
                            //   ),
                            // ),
                            Row(
                              children: [
                                IconButton(
                                    iconSize: 28,
                                    constraints: const BoxConstraints(),
                                    padding: EdgeInsets.zero,
                                    onPressed: () => controller.decreaseItem(
                                        controller.listCartItems[index].id),
                                    icon: const Icon(
                                      Icons.remove_circle_outline,
                                    )),
                                Text(
                                  controller.listCartItems[index].quantity
                                      .toString(),
                                  style: const TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                IconButton(
                                    iconSize: 28,
                                    padding: EdgeInsets.zero,
                                    constraints: const BoxConstraints(),
                                    onPressed: () => controller.increaseItem(
                                        controller.listCartItems[index].id),
                                    icon: const Icon(
                                      Icons.add_circle_outline,
                                    )),
                              ],
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Text('\$${controller.listCartItems[index].price}')
                          ],
                        ),
                        isThreeLine: true,
                        trailing: IconButton(
                            onPressed: () => controller
                                .deleteItem(controller.listCartItems[index]),
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const Divider(),
                    ),
            ),
            Container(
              // height: MediaQuery.of(context).size.height*0.1,
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: KprimaryColor,
                borderRadius: BorderRadius.only(
                    topRight: Radius.circular(15),
                    topLeft: Radius.circular(15)),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Price',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        '${controller.totalPrice}\$',
                        style: const TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Form(
                    key: _formKey,
                    child: Container(
                      // height: 40,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(12)),
                      child: TextFormField(
                        controller: _tableNumController,
                        keyboardType: TextInputType.phone,
                        decoration: const InputDecoration(
                          hintText: 'Table Number',
                          // labelStyle: TextStyle(
                          //   color: Colors.black,
                          // ),
                          border: InputBorder.none,
                          errorBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        validator: (String? value) {
                          if (value!.isEmpty && !GetUtils.isNum(value)) {
                            return 'Enter table number,please';
                          }
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Obx(
                    () => ordersController.isLoading.value
                        ? const CircularProgressIndicator(
                            color: Colors.white,
                          )
                        : Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: CustomButton(
                              text: 'Order Now',
                              height: 30,
                              textColor: Colors.black,
                              onPressed: _submit,
                              backgroundColor: Colors.white,
                            ),
                          ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
