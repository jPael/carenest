class Laboratory {
  final int? id;
  final String name;
  final String description;

  Laboratory({this.id, required this.name, required this.description});

  static Laboratory fromJson(Map<String, dynamic> json) =>
      Laboratory(id: json['id'], name: json['name'], description: json['description'] ?? "");

  Map<String, dynamic> toJson() => {"description": description, "name": name};
}
