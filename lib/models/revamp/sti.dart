class Sti {
  final int? id;
  final String name;
  final String description;

  Sti({
    this.id,
    required this.name,
    required this.description,
  });

  static Sti fromJson(Map<String, dynamic> json) =>
      Sti(id: json['id'], name: json['name'], description: json['description']);
}
