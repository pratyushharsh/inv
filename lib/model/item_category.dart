import 'package:equatable/equatable.dart';
import 'package:inv/entity/item_category_entity.dart';

class ItemCategory  extends Equatable{
  String name;
  String description;
  int color;

	ItemCategory({ this.name, this.description, this.color});

	ItemCategory copyWith({String name, String description, String color}) {
		return ItemCategory(
			name: name ?? this.name,
			description: description ?? this.description,
			color: color ?? this.color
		);
	}

	@override
  List<Object> get props => [name, description, color];

	ItemCategoryEntity toEntity() {
		return ItemCategoryEntity(name: name, description: description, color: color);
	}

	static ItemCategory fromEntity(ItemCategoryEntity entity) {
		return ItemCategory(
			name: entity.name,
			description: entity.description,
			color: entity.color
		);
	}

	@override
	String toString() {
		return 'ItemCategory{name: $name, description: $description, color: $color}';
	}
}
