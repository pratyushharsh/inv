import 'dart:async';
import 'dart:core';

import 'package:inv/entity/item.dart';
import 'package:inv/entity/item_category_entity.dart';
import 'package:inv/entity/item_image.dart';
import 'package:sqflite/sqflite.dart';

class ItemRepository {
  final Database database;
  ItemRepository({this.database});

  Future<List<ItemCategoryEntity>> loadItemCategory() async {
    final List<Map<String, dynamic>> itmCategory =
        await database.query('ITEM_CATEGORY');
    return List.generate(itmCategory.length, (index) {
      return ItemCategoryEntity.fromJson(itmCategory[index]);
    });
  }

  Future<void> addItemCategory(ItemCategoryEntity itm) async {
    await database.insert(
      'ITEM_CATEGORY',
      itm.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateItemCategory(ItemCategoryEntity itm) async {
    await database.update(
      'ITEM_CATEGORY',
      itm.toJson(),
      where: "name = ?",
      whereArgs: [itm.name],
    );
  }

  Future<void> deleteItemCategory(ItemCategoryEntity itm) async {
    await database
        .delete('ITEM_CATEGORY', where: "name = ?", whereArgs: [itm.name]);
  }

  Future<List<ItemEntity>> loadItems() async {
    final List<Map<String, dynamic>> itm = await database.query('ITEM');
    return List.generate(itm.length, (index) {
      return ItemEntity.fromJson(itm[index]);
    });
  }

  Future<void> addItem(ItemEntity itm, ItemImageEntity image) async {
    await database.insert(
      'ITEM',
      itm.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    if (image != null) {
      await database.insert('ITEM_IMAGE', image.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace);
    }
  }

  Future<void> updateItem(ItemEntity itm) async {
    await database.update(
      'ITEM',
      itm.toJson(),
      where: "item_id = ?",
      whereArgs: [itm.itemId],
    );
  }

  Future<void> deleteItem(ItemEntity itm) async {
    await database.delete(
      'ITEM',
      where: "item_id = ?",
      whereArgs: [itm.itemId],
    );
  }

  Future<List<ItemImageEntity>> getItemImage(int itemId) async {
    final List<Map<String, dynamic>> itmImage = await database.query(
      "ITEM_IMAGE",
      where: "item_id = ?",
      whereArgs: [itemId]
    );

    return List.generate(itmImage.length, (index) {
      return ItemImageEntity.fromJson(itmImage[index]);
    });
  }
}
