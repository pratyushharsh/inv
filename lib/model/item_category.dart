import 'package:equatable/equatable.dart';
import 'package:inv/entity/item_category_entity.dart';

class ItemCategory  extends Equatable{
	int id;
  String name;
  String description;
  int color;

	ItemCategory({this.id, this.name, this.description, this.color});

	ItemCategory copyWith({String name, String description, String color}) {
		return ItemCategory(
			id: this.id,
			name: name ?? this.name,
			description: description ?? this.description,
			color: color ?? this.color
		);
	}

	@override
  List<Object> get props => [name, description, color];

	ItemCategoryEntity toEntity() {
		return ItemCategoryEntity(id: id, name: name, description: description, color: color);
	}

	static ItemCategory fromEntity(ItemCategoryEntity entity) {
		return ItemCategory(
			id: entity.id,
			name: entity.name,
			description: entity.description,
			color: entity.color
		);
	}

	@override
	String toString() {
		return 'ItemCategory{id: $id, name: $name, description: $description, color: $color}';
	}


}
