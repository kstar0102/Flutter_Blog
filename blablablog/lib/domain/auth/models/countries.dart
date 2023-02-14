import 'dart:convert';

import 'package:equatable/equatable.dart';

class Countries extends Equatable {
  final int id;
  final String value;
  const Countries({
    required this.id,
    required this.value,
  });

  Countries copyWith({
    int? id,
    String? value,
  }) {
    return Countries(
      id: id ?? this.id,
      value: value ?? this.value,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
    };
  }

  factory Countries.fromMap(Map<String, dynamic> map) {
    return Countries(
      id: map['id']?.toInt() ?? 0,
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Countries.fromJson(String source) =>
      Countries.fromMap(json.decode(source));

  @override
  String toString() => 'Countries(id: $id, value: $value)';

  @override
  List<Object> get props => [id, value];
}
