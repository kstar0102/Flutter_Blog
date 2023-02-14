import 'dart:convert';

import 'package:equatable/equatable.dart';

class ColorsModel extends Equatable {
  final int id;
  final String colorHex;
  const ColorsModel({
    required this.id,
    required this.colorHex,
  });

  ColorsModel copyWith({
    int? id,
    String? colorHex,
  }) {
    return ColorsModel(
      id: id ?? this.id,
      colorHex: colorHex ?? this.colorHex,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'colorHex': colorHex,
    };
  }

  factory ColorsModel.fromMap(Map<String, dynamic> map) {
    return ColorsModel(
      id: map['id']?.toInt() ?? 0,
      colorHex: map['colorHex'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ColorsModel.fromJson(String source) =>
      ColorsModel.fromMap(json.decode(source));

  @override
  String toString() => 'Colors(id: $id, colorHex: $colorHex)';

  @override
  List<Object> get props => [id, colorHex];
}
