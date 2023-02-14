// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

import 'package:equatable/equatable.dart';

class Registration extends Equatable {
  final String email;
  final String password;
  final bool termsAndConditions;
  final int application;
  final int ItemColorID;
  final bool isTrySignup;
  final String nickName;
  final int yearOfBirth;
  final int CountryId;
  final int LanguageId;
  final String gender;
  const Registration({
    required this.email,
    required this.password,
    required this.termsAndConditions,
    required this.application,
    required this.ItemColorID,
    required this.isTrySignup,
    required this.nickName,
    required this.yearOfBirth,
    required this.CountryId,
    required this.LanguageId,
    required this.gender,
  });

  Registration copyWith({
    String? email,
    String? password,
    bool? termsAndConditions,
    int? application,
    int? ItemColorID,
    bool? isTrySignup,
    String? nickName,
    int? yearOfBirth,
    int? CountryId,
    int? LanguageId,
    String? gender,
  }) {
    return Registration(
      email: email ?? this.email,
      password: password ?? this.password,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
      application: application ?? this.application,
      ItemColorID: ItemColorID ?? this.ItemColorID,
      isTrySignup: isTrySignup ?? this.isTrySignup,
      nickName: nickName ?? this.nickName,
      yearOfBirth: yearOfBirth ?? this.yearOfBirth,
      CountryId: CountryId ?? this.CountryId,
      LanguageId: LanguageId ?? this.LanguageId,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'password': password,
      'termsAndConditions': termsAndConditions,
      'application': application,
      'ItemColorID': ItemColorID,
      'isTrySignup': isTrySignup,
      'nickName': nickName,
      'yearOfBirth': yearOfBirth,
      'CountryId': CountryId,
      'LanguageId': LanguageId,
      'gender': gender == 'גבר'
          ? 'Male'
          : gender == 'אישה'
              ? 'Female'
              : gender,
    };
  }

  factory Registration.fromMap(Map<String, dynamic> map) {
    return Registration(
      email: map['email'] ?? '',
      password: map['password'] ?? '',
      termsAndConditions: map['termsAndConditions'] ?? false,
      application: map['application']?.toInt() ?? 0,
      ItemColorID: map['ItemColorID']?.toInt() ?? 0,
      isTrySignup: map['isTrySignup'] ?? false,
      nickName: map['nickName'] ?? '',
      yearOfBirth: map['yearOfBirth']?.toInt() ?? 0,
      CountryId: map['CountryId']?.toInt() ?? 0,
      LanguageId: map['LanguageId']?.toInt() ?? 0,
      gender: map['gender'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory Registration.fromJson(String source) =>
      Registration.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Registration(email: $email, password: $password, termsAndConditions: $termsAndConditions, application: $application, ItemColorID: $ItemColorID, isTrySignup: $isTrySignup, nickName: $nickName, yearOfBirth: $yearOfBirth, CountryId: $CountryId, LanguageId: $LanguageId, gender: $gender)';
  }

  @override
  List<Object> get props {
    return [
      email,
      password,
      termsAndConditions,
      application,
      ItemColorID,
      isTrySignup,
      nickName,
      yearOfBirth,
      CountryId,
      LanguageId,
      gender,
    ];
  }
}
