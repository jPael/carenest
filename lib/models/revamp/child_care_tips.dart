class ChildCareTips {
  final int id;
  final String imagePath;
  final String title;
  final String description;

  ChildCareTips({
    required this.id,
    required this.imagePath,
    required this.title,
    required this.description,
  });

  static ChildCareTips fromJson(Map<String, dynamic> json) => ChildCareTips(
      id: json['id'],
      imagePath: json['image_path'],
      title: json['title'],
      description: json['description']);
}
