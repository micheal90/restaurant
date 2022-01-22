// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class OffersModel {
  List<String> images;
  OffersModel({
    required this.images,
  });

  Map<String, dynamic> toMap() {
    return {
      'images': images,
    };
  }

  factory OffersModel.fromSnapshot(DocumentSnapshot snap) {
    return OffersModel(
      images: List<String>.from(snap['images']),
    );
  }

  factory OffersModel.fromMap(Map<String, dynamic> map) {
    return OffersModel(
      images: List<String>.from(map['images']),
    );
  }

  
}
