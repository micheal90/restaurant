// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class StaffOrderModel {
  String staffName;
  String staffId;
  String orderId;
  String date;
  StaffOrderModel({
    required this.staffName,
    required this.staffId,
    required this.orderId,
    required this.date,
  });

  Map<String, dynamic> toMap() {
    return {
      'staffName': staffName,
      'staffId': staffId,
      'orderId': orderId,
      'date': date,
    };
  }

  factory StaffOrderModel.fromSnapshot(DocumentSnapshot snap) {
    return StaffOrderModel(
      staffName: snap['staffName'] ?? '',
      staffId: snap['staffId'] ?? '',
      orderId: snap['orderId'] ?? '',
      date: snap['date'] ?? '',
    );
  }
   factory StaffOrderModel.fromMap(Map<String,dynamic> map) {
    return StaffOrderModel(
      staffName: map['staffName'] ?? '',
      staffId: map['staffId'] ?? '',
      orderId: map['orderId'] ?? '',
      date: map['date'] ?? '',
    );
  }
}
