import 'dart:convert';

class Car {
  late String make;
  String? id;
  String? model;
  int? miles;

  Car({
    this.id,
    required this.make,
    required this.model,
    required this.miles,
  });

  @override
  String toString() {
    final Map<String, dynamic> json = {};
    if (id != null) json['id'] = id;
    if (model != null) json['model'] = model;
    if (miles != null) json['miles'] = miles;
    json['make'] = make;
    return jsonEncode(json);
  }
}
