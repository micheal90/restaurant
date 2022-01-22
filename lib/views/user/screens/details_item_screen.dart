// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/cart_controller.dart';
import 'package:resturant_app/models/item_model.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/views/user/screens/auth/widgets/custom_button.dart';

class DetailItemScreen extends StatelessWidget {
  const DetailItemScreen({
    Key? key,
    required this.item,
  }) : super(key: key);
  final ItemModel item;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          expandedHeight: 275,
          //backgroundColor: Colors.grey.shade300,
          flexibleSpace: FlexibleSpaceBar(
              title: Text(
                item.name,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              background: FancyShimmerImage(imageUrl: item.imageUrl)),
        ),
        SliverList(
            delegate: SliverChildListDelegate([
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.name,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 3, vertical: 3),
                      decoration: const BoxDecoration(
                        color: KprimaryColor,
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(8),
                            bottomRight: Radius.circular(8)),
                      ),
                      child: const Text(
                        'Offer',
                        style: TextStyle(color: Colors.black54, fontSize: 18),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  item.description,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  'Price \$${item.price}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    
                  ),
                  
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                    width: MediaQuery.of(context).size.width,
                    text: 'Add To Cart',
                    onPressed: () => Get.find<CartController>()
                        .addItemToCart(item)
                        .then((value) => Get.snackbar(
                            '${Emojis.smile_beaming_face_with_smiling_eyes} ${Emojis.smile_face_savoring_food}',
                            'Item has been added to cart',
                            snackPosition: SnackPosition.BOTTOM))),
                           const SizedBox(height: 400,)
              ],
            ),
          )
        ]))
      ],
    ));
  }
}
