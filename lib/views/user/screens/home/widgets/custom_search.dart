// Flutter imports:
import 'package:flutter/material.dart';

// Package imports:
import 'package:get/get.dart';

// Project imports:
import 'package:resturant_app/core/controllers/items_controller.dart';
import 'package:resturant_app/models/item_model.dart';
import 'package:resturant_app/shared/local/constants.dart';
import 'package:resturant_app/views/user/screens/details_item_screen.dart';

class CustomSearchWidget extends StatelessWidget {
  const CustomSearchWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width * 0.6,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 5),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8.0)),
      child: IntrinsicHeight(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.search,
              color: KprimaryColor,
            ),
            const VerticalDivider(
              color: KprimaryColor,
              thickness: 2,
              endIndent: 8,
              indent: 8,
            ),
            Expanded(
              child: TextField(
                onTap: () =>
                    showSearch(context: context, delegate: SearchItem()),
                readOnly: true,
                decoration: const InputDecoration(
                    contentPadding: EdgeInsets.only(bottom: 10),
                    // hintStyle: TextStyle(color: Colors.white),
                    hintText: "Search...",
                    border: InputBorder.none),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchItem extends SearchDelegate<String> {
  var itemController = Get.find<ItemsController>();
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          onPressed: () {
            query = '';
          },
          icon: const Icon(Icons.clear))
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          close(context, '');
        },
        icon: AnimatedIcon(
          icon: AnimatedIcons.menu_arrow,
          progress: transitionAnimation,
        ));
  }

  @override
  Widget buildResults(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final List<ItemModel> searchList = itemController.items;
    final suggestionList = searchList
        .where((element) =>
            element.name.toLowerCase().startsWith(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemBuilder: (context, index) => ListTile(
        onTap: () {
          var item = itemController.findItemById(suggestionList[index].id);
          DetailItemScreen(
            item: item,
          );
          Get.to(DetailItemScreen(item: item));
        },
        leading: const Icon(Icons.fastfood),
        title: RichText(
          text: TextSpan(
            text: suggestionList[index].name.substring(0, query.length),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
            ),
            children: [
              TextSpan(
                text: suggestionList[index].name.substring(query.length),
                style: const TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          ),
        ),
      ),
      itemCount: suggestionList.length,
    );
  }
}
