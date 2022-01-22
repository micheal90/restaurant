// Flutter imports:
import 'package:flutter/cupertino.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/models/cart_item.dart';
import 'package:resturant_app/models/item_model.dart';

class CartController extends GetxController {
  final List<CartItem> _listCartItems = [];
  List<CartItem> get listCartItems => _listCartItems;
  double _totalPrice = 0.0;
  double get totalPrice => _totalPrice;

  Future addItemToCart(ItemModel itemModel) async {
    var isExist = _listCartItems
        .firstWhereOrNull((element) => element.id == itemModel.id);

    if (isExist != null) {
      return;
    }

    _listCartItems.add(CartItem(
      id: itemModel.id,
      name: itemModel.name,
      imageUrl: itemModel.imageUrl,
      quantity: 1,
      price: itemModel.price,
    ));
    _totalPrice += itemModel.price;
    //getTotalPrice();
    debugPrint('added to cart');
    update();
  }

  increaseItem(String id) {
    CartItem item = _listCartItems.firstWhere((element) {
      return element.id == id;
    });
    item.quantity++;
    _totalPrice += item.price;
    debugPrint('increased item');
    update();
  }

  decreaseItem(String id) {
    CartItem item = _listCartItems.firstWhere((element) {
      return element.id == id;
    });
    if (item.quantity == 1) {
      Get.defaultDialog(
        title: 'Are you sure!',
        content: const Text('Do you want to remove the product from the cart?'),
        onCancel: () {},
        onConfirm: () {
          _listCartItems.removeWhere((element) => element.id == id);
          _totalPrice -= item.price;
          Get.back();
          update();
        },
      );
    } else {
      CartItem item = _listCartItems.firstWhere((element) {
        return element.id == id;
      });
      item.quantity--;
      _totalPrice -= item.price;
    }
    debugPrint('decreased item');
    update();
  }

  deleteItem(CartItem cartItem) {
    Get.defaultDialog(
      title: 'Are you sure!',
      content: const Text('Do you want to remove the product from the cart?'),
      onCancel: () {},
      onConfirm: () {
        _totalPrice -= cartItem.price * cartItem.quantity;
        _listCartItems.remove(cartItem);
        Get.back();
         update();
      },
    );

   
  }

  getTotalPrice() {
    for (var element in _listCartItems) {
      _totalPrice = element.price * element.quantity;
    }
    update();
  }

  clearCart() {
    _listCartItems.clear();
    _totalPrice = 0;
    update();
  }

  findItemById(String id) {
    return _listCartItems.firstWhere((element) => element.id == id);
  }
}
