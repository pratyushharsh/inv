import 'package:equatable/equatable.dart';
import 'package:inv/entity/item_image.dart';

class ItemImage extends Equatable {
  int itemId;
  int sort;
  String imageUrl;

  ItemImage({this.itemId, this.sort, this.imageUrl});

  ItemImage copyWith({int itemId, int sort, String imageUrl}) {
    return ItemImage(
      itemId: itemId ?? this.itemId,
      sort: sort ?? this.sort,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  @override
  List<Object> get props => [itemId, sort, imageUrl];

  ItemImageEntity toEntity() {
    return ItemImageEntity(itemId: itemId, sort: sort, imageUrl: imageUrl);
  }

  static ItemImage fromEntity(ItemImageEntity entity) {
    return ItemImage(
      itemId: entity.itemId,
      sort: entity.sort,
      imageUrl: entity.imageUrl,
    );
  }
}
