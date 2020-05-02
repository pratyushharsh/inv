import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:inv/model/item.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object> get props => [];
}

class ItemLoaded extends ItemEvent{}

class ItemAdded extends ItemEvent {
  final Item item;
  final File imageFile;
  ItemAdded({this.item, this.imageFile});

  @override
  List<Object> get props => [item];

  @override
  String toString() {
    return 'ItemAdded{item: $item}';
  }
}

class ItemUpdated extends ItemEvent {
  final Item item;
  ItemUpdated({this.item});

  @override
  List<Object> get props => [item];

  @override
  String toString() {
    return 'ItemUpdated{item: $item}';
  }
}

class ItemDeleted extends ItemEvent {
  final Item item;
  ItemDeleted({this.item});

  @override
  List<Object> get props => [item];

  @override
  String toString() {
    return 'ItemAdded{item: $item}';
  }
}

class LoadItemImage extends ItemEvent {
  final int itemId;
  LoadItemImage(this.itemId);
  @override
  List<Object> get props => [itemId];
}