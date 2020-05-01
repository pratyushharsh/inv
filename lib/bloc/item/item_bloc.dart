import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:inv/model/item.dart';
import 'package:inv/repository/item_repository.dart';
import './bloc.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {

  final ItemRepository itemRepository;
  ItemBloc({this.itemRepository});
  @override
  ItemState get initialState => ItemLoading();

  @override
  Stream<ItemState> mapEventToState(
    ItemEvent event,
  ) async* {
    if (event is ItemLoaded) {
      yield* _mapItemsToState();
    } else if (event is ItemAdded) {

    } else if (event is ItemUpdated) {

    } else if (event is ItemDeleted) {

    } else {
      yield ItemLoadFailure();
    }
  }

  Stream<ItemState> _mapItemsToState() async* {
    yield ItemLoading();
    try {
      final itms = await itemRepository.loadItems();
      yield ItemLoadSuccess(
        itms.map(Item.fromEntity).toList(),
      );
    } catch(e) {
      print(e);
      yield ItemLoadFailure();
    }
  }

  Stream<ItemState> _mapAddItemsToState() async* {

  }

  Stream<ItemState> _mapUpdateItemsToState() async* {

  }

  Stream<ItemState> _mapDeleteItemsToState() async* {

  }
}
