class ItemCategoryEntity {
	String name;
	String description;
	int color;

	ItemCategoryEntity({
		this.name,
		this.description,
		this.color,
	});

	factory ItemCategoryEntity.fromJson(Map<String, dynamic> json) => ItemCategoryEntity(
		name: json["name"],
		description: json["description"],
		color: json["color"],
	);

	Map<String, dynamic> toJson() => {
		"name": name,
		"description": description,
		"color": color,
	};
}

