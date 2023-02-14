import 'dart:convert';

class User {
  User({
    required this.id,
    required this.nickName,
    required this.gender,
  });

  int id;
  String nickName;
  int gender;

  User copyWith({
    required int id,
    required String nickName,
    required int gender,
  }) =>
      User(
        id: id,
        nickName: nickName,
        gender: gender,
      );

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json['id'],
        nickName: json['nickName'],
        gender: json['gender'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'nickName': nickName,
        'gender': gender,
      };
}
