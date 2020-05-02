class ItemImageEntity {
  int itemId;
  int sort;
  String imageUrl;

  ItemImageEntity({
    this.itemId,
    this.sort,
    this.imageUrl,
  });

  factory ItemImageEntity.fromJson(Map<String, dynamic> json) => ItemImageEntity(
    itemId: json["item_id"],
    sort: json["sort"],
    imageUrl: json["image_url"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "sort": sort,
    "image_url": imageUrl,
  };
}