import 'package:equatable/equatable.dart';
import 'package:inv/model/item_category.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class ItemCategoryLoaded extends ItemEvent{}

class ItemCategoryAdded extends ItemEvent {
  final ItemCategory itemCategory;
  ItemCategoryAdded({this.itemCategory});

  @override
  List<Object> get props => [itemCategory];

  @override
  String toString() {
    return 'ItemCategoryAdded{itemCategory: $itemCategory}';
  }
}

class ItemCategoryUpdated extends ItemEvent {
  final ItemCategory itemCategory;
  ItemCategoryUpdated({this.itemCategory});

  @override
  List<Object> get props => [itemCategory];

  @override
  String toString() {
    return 'ItemCategoryUpdated{itemCategory: $itemCategory}';
  }
}

class ItemCategoryDeleted extends ItemEvent {
  final ItemCategory itemCategory;
  ItemCategoryDeleted({this.itemCategory});

  @override
  List<Object> get props => [itemCategory];

  @override
  String toString() {
    return 'ItemCategoryDeleted{itemCategory: $itemCategory}';
  }
}