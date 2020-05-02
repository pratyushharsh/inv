class ItemEntity {
  int itemId;
  String name;
  String description;
  String category;
  int price;
  int measureRequired;
  int nonInventory;
  String dimSys;
  int dim1;
  int dim2;
  int dim3;

  ItemEntity({
    this.itemId,
    this.name,
    this.description,
    this.category,
    this.price,
    this.measureRequired,
    this.nonInventory,
    this.dimSys,
    this.dim1,
    this.dim2,
    this.dim3,
  });

  factory ItemEntity.fromJson(Map<String, dynamic> json) => ItemEntity(
    itemId: json["item_id"],
    name: json["name"],
    description: json["description"],
    category: json["category"],
    price: json["price"],
    measureRequired: json["measure_required"],
    nonInventory: json["non_inventory"],
    dimSys: json["dim_sys"],
    dim1: json["dim_1"],
    dim2: json["dim_2"],
    dim3: json["dim_3"],
  );

  Map<String, dynamic> toJson() => {
    "item_id": itemId,
    "name": name,
    "description": description,
    "category": category,
    "price": price,
    "measure_required": measureRequired,
    "non_inventory": nonInventory,
    "dim_sys": dimSys,
    "dim_1": dim1,
    "dim_2": dim2,
    "dim_3": dim3,
  };
}