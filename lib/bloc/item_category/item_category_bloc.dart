import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inv/model/item_category.dart';
import 'package:inv/repository/item_repository.dart';
import './bloc.dart';

class ItemCategoryBloc extends Bloc<ItemCategoryEvent, ItemCategoryState> {

  final ItemRepository itemRepository;

  ItemCategoryBloc({@required this.itemRepository});

  @override
  ItemCategoryState get initialState => ItemCategoryLoading();

  @override
  Stream<ItemCategoryState> mapEventToState(
    ItemCategoryEvent event,
  ) async* {
    if (event is ItemCategoryLoaded) {
      yield* _mapItemCategoryToState();
    } else if (event is ItemCategoryAdded) {
      yield* _mapAddItemCategoryToState(event.itemCategory);
    } else if (event is ItemCategoryUpdated) {
      yield* _mapUpdateItemCategoryToState(event.itemCategory);
    } else if (event is ItemCategoryDeleted) {
      yield* _mapDeleteItemCategoryToState(event.itemCategory);
    } else {
      yield ItemCategoryLoadFailure();
    }
  }

  Stream<ItemCategoryState> _mapItemCategoryToState() async* {
    yield ItemCategoryLoading();
    try {
      final itmCategory = await itemRepository.loadItemCategory();
      yield ItemCategoryLoadSuccess(
        itmCategory.map(ItemCategory.fromEntity).toList(),
      );
    } catch(e) {
      print(e);
      yield ItemCategoryLoadFailure();
    }
  }

  Stream<ItemCategoryState> _mapAddItemCategoryToState(ItemCategory itm) async* {
    yield ItemCategoryLoading();
    try {
      await itemRepository.addItem(itm.toEntity());
      yield* _mapItemCategoryToState();
    } catch (e) {
      print(e);
      yield ItemCategoryLoadFailure();
    }
  }

  Stream<ItemCategoryState> _mapUpdateItemCategoryToState(ItemCategory itm) async* {
    yield ItemCategoryLoading();
    try {
      await itemRepository.updateItem(itm.toEntity());
      yield* _mapItemCategoryToState();
    } catch (e) {
      print(e);
      yield ItemCategoryLoadFailure();
    }
  }

  Stream<ItemCategoryState> _mapDeleteItemCategoryToState(ItemCategory itm) async* {
    yield ItemCategoryLoading();
    try {
      await itemRepository.deleteItem(itm.toEntity());
      yield* _mapItemCategoryToState();
    } catch (e) {
      print(e);
      yield ItemCategoryLoadFailure();
    }
  }
}

