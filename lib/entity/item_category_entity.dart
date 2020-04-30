import 'package:inv/generated/json/base/json_convert_content.dart';

class ItemCategoryEntity with JsonConvert<ItemCategoryEntity> {
	String name;
	String description;
	int color;

	ItemCategoryEntity({this.name, this.description, this.color});
}
