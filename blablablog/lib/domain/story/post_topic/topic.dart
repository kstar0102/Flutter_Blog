import 'dart:convert';

import 'package:equatable/equatable.dart';

class Topics extends Equatable {
  final int id;
  final String value;
  const Topics({
    required this.id,
    required this.value,
  });

  Topics copyWith({
    int? id,
    String? value,
  }) {
    return Topics(
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

  factory Topics.fromMap(Map<String, dynamic> map) {
    return Topics(
      id: map['id']?.toInt() ?? 0,
      value: map['value'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Topics.fromJson(String source) => Topics.fromMap(json.decode(source));

  @override
  String toString() => 'Topics(id: $id, value: $value)';

  @override
  List<Object> get props => [id, value];
}
