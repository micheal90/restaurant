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

class ItemWidget extends StatelessWidget {
  const ItemWidget({
    Key? key,
    required this.itemModel,
  }) : super(key: key);
  final ItemModel itemModel;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
          onTap: () async => itemDetails(context),
          leading: Stack(
            clipBehavior: Clip.antiAliasWithSaveLayer,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: FancyShimmerImage(
                  width: 80,
                  boxFit: BoxFit.cover,
                  imageUrl: itemModel.imageUrl,
                ),
              ),
              if (itemModel.bestOffer)
                Positioned(
                  top: 0,
                  left: 0,
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                    decoration: const BoxDecoration(
                      color: KprimaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(8),
                          bottomRight: Radius.circular(8)),
                    ),
                    child: const Text(
                      'Offer',
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),
            ],
          ),
          title: Text(itemModel.name),
          subtitle: Text('${itemModel.price} USD'),
          isThreeLine: true,
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  height: 35,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: KprimaryColor)),
                  child: const Image(
                    image: AssetImage('assets/images/delivery-truck.png'),
                    color: KprimaryColor,
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              GestureDetector(
                onTap: () => Get.find<CartController>()
                    .addItemToCart(itemModel)
                    .then((value) => Get.snackbar(
                        '${Emojis.smile_beaming_face_with_smiling_eyes} ${Emojis.smile_face_savoring_food}',
                        'Item has been added to cart',
                        backgroundColor: Colors.white,
                        snackPosition: SnackPosition.BOTTOM)),
                child: Container(
                  height: 35,
                  padding: const EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: KprimaryColor)),
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    color: KprimaryColor,
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future<dynamic> itemDetails(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      builder: (context) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FancyShimmerImage(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: MediaQuery.of(context).size.height * 0.2,
                  imageUrl: itemModel.imageUrl,
                  boxFit: BoxFit.cover,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  itemModel.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (itemModel.bestOffer)
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 3, vertical: 3),
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
              itemModel.description,
              style: const TextStyle(
                color: Colors.grey,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Price \$${itemModel.price}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
      ),
    );
  }
}
