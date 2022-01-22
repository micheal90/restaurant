// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:resturant_app/models/cart_item.dart';

class OrderModel {
  String? orderId;
  String userId;
  String name;
  String tableNumber;
  List<CartItem> items;
  double totalPrice;
  String status;
  String? staffName;
  String? staffId;
  String? messagingStaffToken;
  String? messagingCostumerToken;

  String date;
  OrderModel({
    this.orderId,
    required this.userId,
    required this.name,
    required this.tableNumber,
    required this.items,
    required this.totalPrice,
    required this.status,
    this.staffName,
    this.staffId,
    this.messagingStaffToken,
    this.messagingCostumerToken,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'userId': userId,
      'name': name,
      'tableNumber': tableNumber,
      'items': items.map((x) => x.toMap()).toList(),
      'totalPrice': totalPrice,
      'status': status,
      'staffName': staffName,
      'staffId': staffId,
      'messagingStaffToken': messagingStaffToken,
      'messagingCostumerToken': messagingCostumerToken,
      'date': date,
    };
  }

  factory OrderModel.fromSnapshot(DocumentSnapshot snap) {
    return OrderModel(
      orderId: snap['orderId'],
      userId: snap['userId'] ?? '',
      name: snap['name'] ?? '',
      tableNumber: snap['tableNumber'] ?? '',
      items:
          List<CartItem>.from(snap['items']?.map((x) => CartItem.fromMap(x))),
      totalPrice: snap['totalPrice']?.toDouble() ?? 0.0,
      status: snap['status'] ?? '',
      staffName: snap['staffName'],
      staffId: snap['staffId'],
      messagingStaffToken: snap['messagingStaffToken'],
      messagingCostumerToken: snap['messagingCostumerToken'],
      date: snap['date'] ?? '',
    );
  }
}
