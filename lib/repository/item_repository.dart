import 'dart:async';
import 'dart:core';

import 'package:inv/entity/item_category_entity.dart';
import 'package:sqflite/sqflite.dart';

class ItemRepository {
  final Database database;
  ItemRepository({this.database});

  List<ItemCategoryEntity> item = [];

  Future<List<ItemCategoryEntity>> loadItemCategory() async {
    final List<Map<String, dynamic>> itmCategory = await database.query('ITEM_CATEGORY');
    return List.generate(itmCategory.length, (index) {
      return ItemCategoryEntity.fromJson(itmCategory[index]);
    });
  }

  Future<void> addItem(ItemCategoryEntity itm) async {
    await database.insert(
      'ITEM_CATEGORY',
      itm.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateItem(ItemCategoryEntity itm) async {
    await database.update(
      'ITEM_CATEGORY',
      itm.toJson(),
      where: "id = ?",
      whereArgs: [itm.id],
    );
  }

  Future<void> deleteItem(ItemCategoryEntity itm) async {
    await database.delete(
      'ITEM_CATEGORY',
      where: "id = ?",
      whereArgs: [itm.id]
    );
  }

}