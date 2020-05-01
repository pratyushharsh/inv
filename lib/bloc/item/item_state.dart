import 'package:equatable/equatable.dart';
import 'package:inv/model/item.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object> get props => [];
}

class ItemLoadSuccess extends ItemState {
  final List<Item> items;

  const ItemLoadSuccess([this.items = const []]);

  @override
  List<Object> get props => [items];

  @override
  String toString() {
    return 'ItemLoadSuccess{items: $items}';
  }
}

class ItemLoading extends ItemState {}

class ItemLoadFailure extends ItemState {}