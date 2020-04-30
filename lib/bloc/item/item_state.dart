import 'package:equatable/equatable.dart';
import 'package:inv/model/item_category.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

class ItemCategoryLoadSuccess extends ItemState {
  final List<ItemCategory> category;

  const ItemCategoryLoadSuccess([this.category = const []]);

  @override
  List<Object> get props => [category];

  @override
  String toString() {
    return 'ItemCategoryLoadSuccess{category: $category}';
  }
}

class ItemCategoryLoading extends ItemState {}

class ItemCategoryLoadFailure extends ItemState {}