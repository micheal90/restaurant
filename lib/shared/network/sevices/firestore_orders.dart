// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:resturant_app/models/order_model.dart';
import 'package:resturant_app/models/staff_order_model.dart';

class FirestoreOrder {
  static final CollectionReference ordersCollectionReference =
      FirebaseFirestore.instance.collection('orders');
  static final CollectionReference staffOrdersCollectionReference =
      FirebaseFirestore.instance.collection('staff_orders');
  static final CollectionReference countStaffOrdersCollectionReference =
      FirebaseFirestore.instance.collection('staff_orders_count');

  static Future<String> addOrder(OrderModel orderModel) async {
    String docId = ordersCollectionReference.doc().id;

    OrderModel newOrder = OrderModel(
        orderId: docId,
        userId: orderModel.userId,
        name: orderModel.name,
        tableNumber: orderModel.tableNumber,
        items: orderModel.items,
        totalPrice: orderModel.totalPrice,
        status: orderModel.status,
        date: orderModel.date,
        messagingCostumerToken: orderModel.messagingCostumerToken);
    await ordersCollectionReference.doc(docId).set(newOrder.toMap());
    return docId;
  }

  static updateOrder(OrderModel orderModel) async {
    await ordersCollectionReference
        .doc(orderModel.orderId)
        .update(orderModel.toMap());
  }

  static getOrder() async {
    var data = await ordersCollectionReference.get();
    return data.docs;
  }

  static Stream<List<OrderModel>> getStreamOrder() {
    return ordersCollectionReference.orderBy('date',descending: true).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => OrderModel.fromSnapshot(doc)).toList());
  }

  

// i used for get doc id or order
  static getStaffOrder() async {
    var data = await staffOrdersCollectionReference.get();
    return data.docs;
  }

  static Stream<List<StaffOrderModel>> getStreamStaffOrder() {
    return staffOrdersCollectionReference.snapshots().map((snap) =>
        snap.docs.map((doc) => StaffOrderModel.fromSnapshot(doc)).toList());
  }

  static addStaffOrder(StaffOrderModel staffOrderModel) async {
    await staffOrdersCollectionReference.doc().set(staffOrderModel.toMap());
  }

  static deleteStaffOrder(String id) async {
    await staffOrdersCollectionReference.doc(id).delete();
  }
}
