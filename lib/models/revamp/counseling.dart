class Counseling {
  final int? id;
  final String description;

  Counseling({this.id, required this.description});

  static Counseling fromJson(Map<String, dynamic> json) =>
      Counseling(id: json['id'], description: json['description']);

  Map<String, dynamic> toJson() => {'name': description};
}
