class Treatment {
  final int? id;
  final String description;
  final bool? value;

  Treatment({
    required this.description,
    this.id,
    this.value,
  });

  static Treatment fromJson(Map<String, dynamic> json) =>
      Treatment(id: json['id'], description: json['description'], value: (json['value'] == 1));

  Map<String, dynamic> toJson() => {
        'description': description,
        'value': value,
      };
}
