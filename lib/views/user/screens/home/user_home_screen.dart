// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/items_controller.dart';
import 'package:resturant_app/views/user/screens/home/widgets/custom_search.dart';
import 'package:resturant_app/views/user/screens/home/widgets/image_slider.dart';
import 'package:resturant_app/views/user/screens/home/widgets/item_widget.dart';

class UserHomeScreen extends StatefulWidget {
  const UserHomeScreen({Key? key}) : super(key: key);

  @override
  State<UserHomeScreen> createState() => _UserHomeScreenState();
}

class _UserHomeScreenState extends State<UserHomeScreen>
    with TickerProviderStateMixin {
  final ItemsController controller = Get.find<ItemsController>();
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => controller.isLoading.value
          ? const Center(child: CircularProgressIndicator())
          : DefaultTabController(
              length: controller.categories.length,
              child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                  leading: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(
                          'https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg'),
                    ),
                  ),
                  // centerTitle: true,
                  actions: [CustomSearchWidget(size: size)],
                  bottom: TabBar(
                    isScrollable: true,
                    tabs: List.generate(
                      controller.categories.length,
                      (index) => Tab(
                        child: Row(
                          children: [
                            Image.network(
                                controller.categories[index].imageUrl),
                            const SizedBox(
                              width: 10,
                            ),
                            Text(controller.categories[index].name),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                body: Column(
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    ImageSlider(imageCoverList: controller.offerImages),
                    Expanded(
                      child: TabBarView(children: [
                        sandwichPage(controller),
                        pizzaPage(controller),
                        chickenPage(controller),
                        seafoodPage(controller),
                        beveragePage(controller),
                      ]),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  Widget chickenPage(ItemsController controller) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ItemWidget(itemModel: controller.chickenItems[index]);
        },
        itemCount: controller.chickenItems.length);
  }

  Widget pizzaPage(ItemsController controller) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ItemWidget(itemModel: controller.pizzaItems[index]);
        },
        itemCount: controller.pizzaItems.length);
  }

  Widget sandwichPage(ItemsController controller) {
    return ListView(children: [
      ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return ItemWidget(
              itemModel: controller.sandwichItems[index],
            );
          },
          itemCount: controller.sandwichItems.length)
    ]);
  }

  Widget seafoodPage(ItemsController controller) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ItemWidget(itemModel: controller.seafoodItems[index]);
        },
        itemCount: controller.seafoodItems.length);
  }

  Widget beveragePage(ItemsController controller) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return ItemWidget(itemModel: controller.beverageItems[index]);
        },
        itemCount: controller.beverageItems.length);
  }
}
