// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/auth_controller.dart';
import 'package:resturant_app/core/controllers/cart_controller.dart';
import 'package:resturant_app/core/controllers/items_controller.dart';
import 'package:resturant_app/core/controllers/orders_controller.dart';

class AppBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
    Get.lazyPut(() => ItemsController(),fenix: true);
    Get.lazyPut(() => CartController(),fenix: true);
        Get.lazyPut(() => OrdersController());

  }
}
