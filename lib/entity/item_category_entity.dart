class ItemCategoryEntity {
	int id;
	String name;
	String description;
	int color;

	ItemCategoryEntity({
		this.id,
		this.name,
		this.description,
		this.color,
	});

	factory ItemCategoryEntity.fromJson(Map<String, dynamic> json) => ItemCategoryEntity(
		id: json["id"],
		name: json["name"],
		description: json["description"],
		color: json["color"],
	);

	Map<String, dynamic> toJson() => {
		"id": id,
		"name": name,
		"description": description,
		"color": color,
	};
}

