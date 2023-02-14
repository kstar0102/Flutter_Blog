import 'dart:convert';

import 'package:equatable/equatable.dart';

class Language extends Equatable {
  final int id;
  final String value;
  const Language({
    required this.id,
    required this.value,
  });

  Language copyWith({
    int? id,
    String? value,
  }) {
    return Language(
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

  factory Language.fromMap(Map<String, dynamic> map) {
    return Language(
      id: map['id']?.toInt() ?? 0,
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Language.fromJson(String source) =>
      Language.fromMap(json.decode(source));

  @override
  String toString() => 'Language(id: $id, value: $value)';

  @override
  List<Object> get props => [id, value];
}
