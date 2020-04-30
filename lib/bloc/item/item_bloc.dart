import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:inv/model/item_category.dart';
import 'package:inv/repository/item_repository.dart';
import './bloc.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {

  final ItemRepository itemRepository;

  ItemBloc({@required this.itemRepository});

  @override
  ItemState get initialState => ItemCategoryLoading();

  @override
  Stream<ItemState> mapEventToState(
    ItemEvent event,
  ) async* {
    if (event is ItemCategoryAdded) {
      yield* _mapAddItemCategoryToState(event.itemCategory);
    } else if (event is ItemCategoryLoaded) {
      yield* _mapItemCategoryToState();
    }
  }

  Stream<ItemState> _mapItemCategoryToState() async* {
    yield ItemCategoryLoading();
    try {
      final itmCategory = await itemRepository.loadItemCategory();
      yield ItemCategoryLoadSuccess(
        itmCategory.map(ItemCategory.fromEntity).toList(),
      );
    } catch(_) {
      yield ItemCategoryLoadFailure();
    }
  }

  Stream<ItemState> _mapAddItemCategoryToState(ItemCategory itm) async* {
    yield ItemCategoryLoading();
    try {
      final itmCategory = await itemRepository.addItem(itm.toEntity());
      yield ItemCategoryLoadSuccess(
        itmCategory.map(ItemCategory.fromEntity).toList(),
      );
    } catch (_) {
      yield ItemCategoryLoadFailure();
    }
  }
}

