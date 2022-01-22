// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:resturant_app/models/order_model.dart';
import 'package:resturant_app/shared/local/constants.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(BaseOptions(
        baseUrl: 'https://fcm.googleapis.com/fcm/send',
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
          'Authorization':
              ApiKey
        }));
  }

  static Future<Response> sendMessageToSpaceficPerson({
    required OrderModel order,
  }) async {
    return dio.post('', data: {
      "android": {
        "priority": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_MAX",
          "sound": "default",
          "default_sound": "true",
          "default_vibrate_timings": "true",
          "default_light_settings": "true"
        }
      },
      "notification": {
        "title": 'Finished eating on table ${order.tableNumber}',
        "body":
            "The order on ther table: ${order.tableNumber} has finished\nTotal price is \$${order.totalPrice}",
        "sound": "default"
      },
      "data": {
        "orderId": order.orderId,
        "table_number": order.tableNumber,
        "totalPrice": order.totalPrice,
        "click_action": "FLUTTER_NOTIFIGATION_CLICK"
      },
      "to": order.messagingStaffToken
    });
  }

  static Future<Response> sendMessageToStaff({
    required OrderModel orderModel,
  }) async {
    return dio.post('', data: {
      "android": {
        "priority": "HIGH",
        "notification": {
          "notification_priority": "PRIORITY_MAX",
          "sound": "default",
          "default_sound": "true",
          "default_vibrate_timings": "true",
          "default_light_settings": "true"
        }
      },
      "notification": {
        "title": "New Order",
        "body":
            "There is an order on the table: ${orderModel.tableNumber}, it must be taken.\n\$ ${orderModel.totalPrice}",
        "sound": "default"
      },
      "data": {
        "orderId": orderModel.orderId,
        "table_number": orderModel.tableNumber,
        "totalPrice": orderModel.totalPrice,
        "click_action": "FLUTTER_NOTIFIGATION_CLICK"
      },
      "to": "/topics/staff"
    });
  }
}
