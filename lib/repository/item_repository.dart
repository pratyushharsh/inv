import 'dart:async';
import 'dart:core';

import 'package:inv/entity/item_category_entity.dart';

class ItemRepository {
  List<ItemCategoryEntity> item = [];

  Future<List<ItemCategoryEntity>> loadItemCategory() async {
//    item.add(ItemCategoryEntity(name: "Home",description: "Home Category", ));
//    item.add(ItemCategoryEntity(name: "Fashion",description: "Home Category",));
    await Future.delayed(Duration(seconds: 1));
    return item;
  }

  Future<List<ItemCategoryEntity>> addItem(ItemCategoryEntity itm) async {
    item.add(itm);
    await Future.delayed(Duration(seconds: 1));
    return item;
  }

}