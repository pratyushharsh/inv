import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:inv/entity/item_image.dart';
import 'package:inv/model/item.dart';
import 'package:inv/model/item_image.dart';
import 'package:inv/repository/item_repository.dart';
import 'package:path_provider/path_provider.dart';
import './bloc.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {

  final random = new Random();

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
      yield* _mapAddItemsToState(event.item, event.imageFile);
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

  Stream<ItemState> _mapAddItemsToState(Item item, File file) async* {
    yield ItemLoading();
    try {
      // Save and send update
      ItemImage itmImage;
      String img_url = '${random.nextInt(5000)}${item.itemId.toString()}.jpg';
      if (file != null) {
        final directory = await getApplicationDocumentsDirectory();
        File image_file = File('${directory.path}/$img_url');
        image_file.writeAsBytesSync(file.readAsBytesSync());
        itmImage = ItemImage(itemId: item.itemId, imageUrl: img_url, sort: 10);
        file.delete();
      }
      itemRepository.addItem(item.toEntity(), itmImage == null ? null : itmImage.toEntity());
      yield* _mapItemsToState();
    } catch (_) {
      print(_);
      yield ItemLoadFailure();
    }
  }

  Stream<ItemState> _mapUpdateItemsToState() async* {

  }

  Stream<ItemState> _mapDeleteItemsToState() async* {

  }

  Future<File> getItemImage(int itemId) async {
    try {
      List<ItemImageEntity> images = await itemRepository.getItemImage(itemId);
      if(images.length <= 0) return null;
      final directory = await getApplicationDocumentsDirectory();
      File imageFile = File('${directory.path}/${images[0].imageUrl}');
      return imageFile;
    } catch (_) {
      print(_);
    }
    return null;
  }
}
