// Flutter imports:
import 'package:flutter/material.dart';

// Project imports:
import 'package:resturant_app/shared/local/constants.dart';

class ItemTreailer extends StatelessWidget {
  const ItemTreailer({
    Key? key,
    required this.onTapDelivery,
    required this.onTapCart,
    required this.bestOffer,
  }) : super(key: key);
  final Function() onTapDelivery;
  final Function() onTapCart;
  final bool bestOffer;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          bestOffer
              ? Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  decoration: const BoxDecoration(
                      color: KprimaryColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          bottomLeft: Radius.circular(15))),
                  child: const Text(
                    'Best Offer',
                  ),
                )
              : Container(),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              GestureDetector(
                onTap: onTapDelivery,
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
                width: 15,
              ),
              GestureDetector(
                onTap: onTapCart,
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
              // IconButton(
              //   padding: EdgeInsets.zero,
              //   onPressed: () {},
              //   icon: Image.asset(
              //     'assets/images/delivery-truck.png',
              //     color: KprimaryColor,
              //   ),
              // ),
              // IconButton(
              //     padding: EdgeInsets.zero,
              //     color: KprimaryColor,
              //     onPressed: () {},
              //     icon: const Icon(Icons.shopping_cart_outlined)),
            ],
          ),
        ],
      ),
    );
  }
}
