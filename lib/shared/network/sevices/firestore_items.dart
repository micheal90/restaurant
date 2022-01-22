// Package imports:
import 'package:cloud_firestore/cloud_firestore.dart';

// Project imports:
import 'package:resturant_app/models/item_model.dart';

class FirestoreItems {
  static final CollectionReference itemsCollectionReference =
      FirebaseFirestore.instance.collection('Items');
  static final CollectionReference offersCollectionReference =
      FirebaseFirestore.instance.collection('offers');
  static final CollectionReference categoriesCollectionReference =
      FirebaseFirestore.instance.collection('categories');

  static Future getOffers() async {
    var data = await offersCollectionReference.get();
    return data.docs;
  }

  // static Stream<List<String>> getStreamOffers() {
  //   return offersCollectionReference
  //       .snapshots()
  //       .map((snap) => snap.docs.map((doc) =>OffersModel.fromSnapshot(doc)).first.images);
  // }

  // static Future getItems() async {
  //   var data = await itemsCollectionReference.get();
  //   return data.docs;
  // }
static Stream<List<ItemModel>> getStreamItem() {
    return itemsCollectionReference
        .snapshots()
        .map((snap) => snap.docs.map((doc) => ItemModel.fromSnapshot(doc)).toList());
  }

  static getCategories() async {
    var data = await categoriesCollectionReference.get();
    return data.docs;
  }
}
