// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

// Project imports:
import 'package:resturant_app/core/controllers/auth_controller.dart';
import 'package:resturant_app/core/controllers/cart_controller.dart';
import 'package:resturant_app/models/order_model.dart';
import 'package:resturant_app/models/staff_order_model.dart';
import 'package:resturant_app/models/user_model.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/shared/network/sevices/cash_helper.dart';
import 'package:resturant_app/shared/network/sevices/dio_helper.dart';
import 'package:resturant_app/shared/network/sevices/firestore_orders.dart';
import 'package:resturant_app/shared/network/sevices/firestore_user.dart';

class OrdersController extends GetxController {
  var client = http.Client();

  // final List<Map<String, String>> _staffData =
  //     Get.find<AuthController>().staffData;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;
  final AuthController _authController = Get.find<AuthController>();
  String? _userOrderId; //orderId of user order
  String? get userOrderId => _userOrderId;

  var orders = <OrderModel>[].obs;
  var staffOrders = <StaffOrderModel>[].obs;

  List<OrderModel> get completedOrder => orders
      .where((element) => element.status == STATUS.COMPLETED.name)
      .toList()
      .obs;
  List<OrderModel> get waitingOrder => orders
      .where((element) => element.status == STATUS.WAITING.name)
      .toList()
      .obs;
  List<OrderModel> get takesOrder => orders
      .where((element) => element.status == STATUS.TAKES.name)
      .toList()
      .obs;
  List<OrderModel> get progressingOrder => orders
      .where((element) => element.status == STATUS.PROGRESSING.name)
      .toList()
      .obs;
  List<OrderModel> get takesAndWationgOrder => orders
      .where((element) =>
          element.status == STATUS.WAITING.name ||
          element.status == STATUS.PROGRESSING.name)
      .toList()
      .obs;

  @override
  void onInit() async {
    super.onInit();
    orders.bindStream(FirestoreOrder.getStreamOrder());
    staffOrders.bindStream(FirestoreOrder.getStreamStaffOrder());
    _userOrderId = await CashHelper.getData(key: 'userOrder');
  }

  List<OrderModel> listComplitedOrderOfDay() {
    List<OrderModel> t = [];
    for (var order in completedOrder) {
      if (DateTime.parse(order.date).day == DateTime.now().day) {
        var isExist = t.firstWhereOrNull((element) =>
            DateTime.parse(element.date).day == DateTime.parse(order.date).day);
        if (isExist == null) {
          t.add(order);
        }
      }
    }
    return t;
  }

  List<OrderModel> listComplitedOrderOfmonth() {
    List<OrderModel> t = [];
    for (var order in completedOrder) {
      if (DateTime.parse(order.date)
          .isAfter(DateTime.now().subtract(const Duration(days: 31)))) {
        var isExist = t.firstWhereOrNull((element) =>
            DateTime.parse(element.date).day == DateTime.parse(order.date).day);
        if (isExist == null) {
          t.add(order);
        }
      }
    }
    return t;
  }

  List<OrderModel> listCompletedOrderOfWeek() {
    List<OrderModel> t = [];
    for (var order in completedOrder) {
      if (DateTime.parse(order.date)
          .isAfter(DateTime.now().subtract(const Duration(days: 7)))) {
        var isExist = t.firstWhereOrNull((element) =>
            DateTime.parse(element.date).day == DateTime.parse(order.date).day);
        if (isExist == null) {
          t.add(order);
        }
      }
    }
    return t;
  }

//return count of orders completed of day
  int getOrdersCountCompletedOfDate(String date) {
    List<OrderModel> _listCompletedOrderOfDay = completedOrder
        .where((element) =>
            DateTime.parse(element.date).day == DateTime.parse(date).day)
        .toList();
    return _listCompletedOrderOfDay.length;
  }

  Map calculateStaffOrderCountOfDay(String date) {
    List<Map<String, dynamic>> _staffIdComplitedOrdersCount = [];
    Map map = {};
    List<OrderModel> _listCompletedOrderOfDay = completedOrder
        .where((element) =>
            DateTime.parse(element.date).day == DateTime.parse(date).day)
        .toList();

    _listCompletedOrderOfDay.forEach((element) {
      _staffIdComplitedOrdersCount
          .add({'id': element.staffId, 'name': element.staffName});
    });
    _staffIdComplitedOrdersCount.forEach((element) {
      if (!map.containsKey(element['name'])) {
        map[element['name']] = 1;
      } else {
        map[element['name']] += 1;
      }
    });
    //print(map);
    return map;
  }

  Future addOrder(String tableNumber) async {
    try {
      _isLoading.value = true;
      OrderModel orderModel = OrderModel(
          userId: Get.find<AuthController>().userModel.value!.userId,
          tableNumber: tableNumber,
          items: Get.find<CartController>().listCartItems,
          totalPrice: Get.find<CartController>().totalPrice,
          status: STATUS.WAITING.name,
          name: Get.find<AuthController>().userModel.value!.name,
          date: DateTime.now().toString(),
          messagingCostumerToken: token);
      _userOrderId = await FirestoreOrder.addOrder(orderModel);
      //set userOrderId in cash for known if user has order
      await CashHelper.putData(key: 'userOrder', value: _userOrderId);
      //send message to all staff
      DioHelper.sendMessageToStaff(orderModel: orderModel);
    } on FirebaseException catch (e) {
      Get.snackbar("Occurred Error!", e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
    _isLoading.value = false;
    // update();
  }

  // Future<void> getOrder() async {
  //   orders.clear();
  //   var data = await FirestoreOrder.getOrder();
  //   data.forEach((element) {
  //     orders.add(OrderModel.fromMap(element.data()));
  //   });
  //   orders.sort((a, b) {
  //     return DateTime.parse(a.date).compareTo(DateTime.parse(b.date));
  //   });
  //   orders.reversed;
  //   // print(orders);
  //   update();
  // }

  // Future getStaffOrders() async {
  //   staffOrders.clear();
  //   var data = await FirestoreOrder.getStaffOrder();

  //   data.forEach((element) {
  //     staffOrders.add(StaffOrderModel.fromMap(element.data()));
  //   });

  //   staffOrders.sort((a, b) {
  //     return DateTime.parse(a.date).compareTo(DateTime.parse(b.date));
  //   });
  //   staffOrders.reversed;
  //   // staffOrders.forEach((element) {
  //   //   print(element.date);
  //   // });
  //   update();
  // }

  Future takeOrder(String orderId) async {
    try {
      _isLoading.value = true;
      StaffOrderModel staffOrder = StaffOrderModel(
          staffName: _authController.userModel.value!.name,
          staffId: _authController.userModel.value!.userId,
          orderId: orderId,
          date: DateTime.now().toString());
      await FirestoreOrder.addStaffOrder(staffOrder);
      await updateOrder(
          orderId: orderId,
          status: STATUS.PROGRESSING,
          staffId: _authController.userModel.value!.userId,
          staffName: _authController.userModel.value!.name,
          messagingStaffToken: token);
    } on FirebaseException catch (e) {
      Get.snackbar("Occurred Error!", e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
    _isLoading.value = false;
    // update();
  }

  Future unTakeOrder(String orderId) async {
    try {
      _isLoading.value = true;
      // update();
      var data = await FirestoreOrder.getStaffOrder();
      var staffOrderId = data
          .firstWhere((element) =>
              StaffOrderModel.fromMap(element.data()).orderId == orderId)
          .id;
      debugPrint(staffOrderId);
      await FirestoreOrder.deleteStaffOrder(staffOrderId);

      await updateOrder(orderId: orderId, status: STATUS.WAITING);
    } on FirebaseException catch (e) {
      Get.snackbar("Occurred Error!", e.message.toString(),
          snackPosition: SnackPosition.BOTTOM);
    }
    _isLoading.value = false;
    // update();
  }

  Future<bool> finishEating() async {
    try {
      _isLoading.value = true;
      // update();
      //await getOrder();
      var order =
          orders.firstWhere((element) => element.orderId == _userOrderId);
      debugPrint(order.status);
      if (order.status == STATUS.WAITING.name) {
        Get.snackbar("Big Smile", 'Please wait for your order to be delivered',
            snackPosition: SnackPosition.BOTTOM);
        _isLoading.value = false;
        //  update();
        return false;
      } else {
        await updateOrder(
            orderId: _userOrderId!,
            status: STATUS.COMPLETED,
            staffId: order.staffId,
            staffName: order.staffName,
            messagingStaffToken: order.messagingStaffToken);
        //increase count staff order
        var data = await FireStoreUser.getUserDataFromFireStore(
            order.staffId!, ROLE.STAFF);
        UserModel userModel = UserModel.fromMap(data.data());
        userModel.staffOrderDoneCount++;
        debugPrint(userModel.name);
        await FireStoreUser.updateStaffData(userModel);

        //send notification to staff
        DioHelper.sendMessageToSpaceficPerson(order: order);

        _isLoading.value = false;
        _userOrderId = null;
        CashHelper.clearKey(key: 'userOrder');
        //update();
        return true;
      }
    } catch (e) {
      Get.snackbar("Occurred Error!", e.toString(),
          snackPosition: SnackPosition.BOTTOM);
      _isLoading.value = false;
      //update();
      return false;
    }
  }

  Future updateOrder(
      {required String orderId,
      required STATUS status,
      String? staffId,
      String? staffName,
      String? messagingStaffToken}) async {
    var order = orders.firstWhere((element) => element.orderId == orderId);
    order.status = status.name;
    order.staffId = staffId;
    order.staffName = staffName;
    order.messagingStaffToken = messagingStaffToken;
    debugPrint(order.toString());
    await FirestoreOrder.updateOrder(order);
    //await getOrder();
    // update();
  }
}
