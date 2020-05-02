import 'package:equatable/equatable.dart';
import 'package:inv/entity/item.dart';

class Item extends Equatable {
  int itemId;
  String name;
  String description;
  String category;
  int price;
  int measureRequired;
  int nonInventory;
  String dimSys;
  int dim1;
  int dim2;
  int dim3;

  Item(
      {this.itemId,
      this.name,
      this.description,
      this.category,
      this.price,
      this.measureRequired,
      this.nonInventory,
      this.dimSys,
      this.dim1,
      this.dim2,
      this.dim3});

  Item copyWith(
      {int itemId,
      String name,
      String description,
      String category,
      int price,
      int measureRequired,
      int nonInventory,
      String dimSys,
      int dim1,
      int dim2,
      int dim3}) {
    return Item(
      itemId: itemId ?? this.itemId,
      name: name ?? this.name,
      description: description ?? this.description,
      category: category ?? this.category,
      price: price ?? this.price,
      measureRequired: measureRequired ?? this.measureRequired,
      nonInventory: nonInventory ?? this.nonInventory,
      dimSys: dimSys ?? this.dimSys,
      dim1: dim1 ?? this.dim1,
      dim2: dim2 ?? this.dim2,
      dim3: dim3 ?? this.dim3,
    );
  }

  @override
  List<Object> get props => [
        itemId,
        name,
        description,
        category,
        price,
        measureRequired,
        nonInventory,
        dimSys,
        dim1,
        dim2,
        dim3
      ];

  ItemEntity toEntity() {
    return ItemEntity(
        itemId: itemId,
        name: name,
        description: description,
        category: category,
        price: price,
        measureRequired: measureRequired,
        nonInventory: nonInventory,
        dimSys: dimSys,
        dim1: dim1,
        dim2: dim2,
        dim3: dim3);
  }

  static Item fromEntity(ItemEntity entity) {
    return Item(
      itemId: entity.itemId,
      name: entity.name,
      description: entity.description,
      category: entity.category,
      price: entity.price,
      measureRequired: entity.measureRequired,
      nonInventory: entity.nonInventory,
      dimSys: entity.dimSys,
      dim1: entity.dim1,
      dim2: entity.dim2,
      dim3: entity.dim3,
    );
  }
}
