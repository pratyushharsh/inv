import 'package:inv/entity/item_category_entity.dart';

itemCategoryEntityFromJson(ItemCategoryEntity data, Map<String, dynamic> json) {
	if (json['name'] != null) {
		data.name = json['name']?.toString();
	}
	if (json['description'] != null) {
		data.description = json['description']?.toString();
	}
	if (json['color'] != null) {
		data.color = json['color'];
	}
	return data;
}

Map<String, dynamic> itemCategoryEntityToJson(ItemCategoryEntity entity) {
	final Map<String, dynamic> data = new Map<String, dynamic>();
	data['name'] = entity.name;
	data['description'] = entity.description;
	data['color'] = entity.color;
	return data;
}