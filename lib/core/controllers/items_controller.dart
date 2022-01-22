// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/models/category_model.dart';
import 'package:resturant_app/models/item_model.dart';
import 'package:resturant_app/models/offers_model.dart';
import 'package:resturant_app/shared/network/sevices/firestore_items.dart';

class ItemsController extends GetxController {
  // RxList<String> offerImages = <String>[].obs;
  List<String> offerImages = [];
  List<CategoryModel> categories = [
    CategoryModel(
        name: 'sandwich',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/restaurant-app-34135.appspot.com/o/category_images%2Fsandwich-20.png?alt=media&token=06ce03b6-fca6-4621-af6f-61b872e4e84a'),
    CategoryModel(
        name: 'pizza',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/restaurant-app-34135.appspot.com/o/category_images%2Fpizza-20.png?alt=media&token=842a8f98-72ee-43d1-99d1-51492f4d7160'),
    CategoryModel(
        name: 'chicken',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/restaurant-app-34135.appspot.com/o/category_images%2Fchickenalt.png?alt=media&token=75f6bf41-9ec2-4367-b781-73365cdea712'),
    CategoryModel(
        name: 'seafood',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/restaurant-app-34135.appspot.com/o/category_images%2Ffish-multiple.png?alt=media&token=7bbba961-df51-4901-8fa1-fa43adcb7c4a'),
    CategoryModel(
        name: 'beverage',
        imageUrl:
            'https://firebasestorage.googleapis.com/v0/b/restaurant-app-34135.appspot.com/o/category_images%2Fdrink.png?alt=media&token=fd67e697-a253-45a1-af57-173c9a3ae8d6'),
  ];
  var items = <ItemModel>[].obs;
  List<ItemModel> get chickenItems =>
      items.where((element) => element.category == 'chicken').toList().obs;
  List<ItemModel> get seafoodItems =>
      items.where((element) => element.category == 'seafood').toList().obs;
  List<ItemModel> get sandwichItems =>
      items.where((element) => element.category == 'sandwich').toList().obs;
  List<ItemModel> get pizzaItems =>
      items.where((element) => element.category == 'pizza').toList().obs;
  List<ItemModel> get beverageItems =>
      items.where((element) => element.category == 'beverage').toList().obs;

  final RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  @override
  void onInit() async {
    super.onInit();

    await getOffers();
    //offerImages.bindStream(FirestoreItems.getStreamOffers());
    items.bindStream(FirestoreItems.getStreamItem());
  }

  getOffers() async {
    _isLoading.value = true;
    var data = await FirestoreItems.getOffers();
    offerImages = OffersModel.fromMap(data.first.data()).images;
    //  print(offerImages);
    _isLoading.value = false;
  }

  ItemModel findItemById(String id) {
    return items.firstWhere((item) => item.id == id);
  }

  // getCategories() async {
  //   var data = await FirebaseItems.getCategories();
  //   data.forEach((element) {
  //     categories.add(CategoryModel.fromMap(element.data()));
  //   });
  //   // print(categories.first.name);
  // }

  // getItems() async {
  //   var data = await FirestoreItems.getItems();
  //   data.forEach((element) {
  //     items.add(ItemModel.fromMap(element.data()));
  //   });
  // }
}
