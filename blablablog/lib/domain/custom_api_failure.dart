import 'dart:convert';

import 'package:equatable/equatable.dart';

class CustomApiFailure extends Equatable {
  final String key;
  final String message;
  const CustomApiFailure({
    required this.key,
    required this.message,
  });

  CustomApiFailure copyWith({
    String? key,
    String? message,
  }) {
    return CustomApiFailure(
      key: key ?? this.key,
      message: message ?? this.message,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'key': key,
      'message': message,
    };
  }

  factory CustomApiFailure.fromMap(Map<String, dynamic> map) {
    return CustomApiFailure(
      key: map['key'] ?? '',
      message: map['message'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CustomApiFailure.fromJson(String source) =>
      CustomApiFailure.fromMap(json.decode(source));

  @override
  String toString() => 'CustomApiFailure(key: $key, message: $message)';

  @override
  List<Object> get props => [key, message];
}
