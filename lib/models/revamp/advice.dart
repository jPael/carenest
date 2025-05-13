class Advice {
  final int? id;
  final String content;

  Advice({
    this.id,
    required this.content,
  });

  static Advice fromJson(Map<String, dynamic> json) =>
      Advice(id: json['id'], content: json['content']);

  Map<String, dynamic> toJson() => {"name": content};
}
