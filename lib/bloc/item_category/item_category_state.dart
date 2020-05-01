import 'package:equatable/equatable.dart';
import 'package:inv/model/item_category.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ItemCategoryState extends Equatable {
  const ItemCategoryState();

  @override
  List<Object> get props => [];
}

class ItemCategoryLoadSuccess extends ItemCategoryState {
  final List<ItemCategory> category;

  const ItemCategoryLoadSuccess([this.category = const []]);

  @override
  List<Object> get props => [category];

  @override
  String toString() {
    return 'ItemCategoryLoadSuccess{category: $category}';
  }
}

class ItemCategoryLoading extends ItemCategoryState {}

class ItemCategoryLoadFailure extends ItemCategoryState {}