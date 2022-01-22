// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

class ItemModel {
  String id;
  String name;
  String description;
  String imageUrl;
  double price;
  bool bestOffer;
  String category;
  ItemModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.price,
    required this.bestOffer,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'price': price,
      'bestOffer': bestOffer,
      'category': category,
    };
  }

  factory ItemModel.fromSnapshot(DocumentSnapshot snap) {
    return ItemModel(
      id: snap['id'] ?? '',
      name: snap['name'] ?? '',
      description: snap['description'] ?? '',
      imageUrl: snap['imageUrl'] ?? '',
      price: snap['price']?.toDouble() ?? 0.0,
      bestOffer: snap['bestOffer'] ?? false,
      category: snap['category'] ?? '',
    );
  }

 
}
