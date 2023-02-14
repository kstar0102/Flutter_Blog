import 'dart:convert';

import 'package:equatable/equatable.dart';

class Recovery extends Equatable {
  final String email;
  const Recovery({
    required this.email,
  });

  Recovery copyWith({
    String? email,
  }) {
    return Recovery(
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
    };
  }

  factory Recovery.fromMap(Map<String, dynamic> map) {
    return Recovery(
      email: map['email'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Recovery.fromJson(String source) =>
      Recovery.fromMap(json.decode(source));

  @override
  String toString() => 'Recovery(email: $email)';

  @override
  List<Object> get props => [email];
}
