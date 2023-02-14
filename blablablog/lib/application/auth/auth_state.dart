import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:blabloglucy/domain/auth/models/colors.dart';
import 'package:blabloglucy/domain/auth/models/countries.dart';
import 'package:blabloglucy/domain/auth/models/language.dart';
import 'package:blabloglucy/domain/auth/models/user_info.dart';

class AuthState extends Equatable {
  final UserInfo userInfo;
  final List<Countries> countryList;
  final List<Language> languageList;
  final CleanFailure failure;
  final bool loading;
  final bool valueChecking;
  final List<ColorsModel> colorsList;
  final bool validEmail;
  final bool validName;
  const AuthState({
    required this.userInfo,
    required this.countryList,
    required this.languageList,
    required this.failure,
    required this.loading,
    required this.valueChecking,
    required this.colorsList,
    required this.validEmail,
    required this.validName,
  });

  // bool get loggedIn => userInfo != null;

  AuthState copyWith({
    UserInfo? userInfo,
    List<Countries>? countryList,
    List<Language>? languageList,
    CleanFailure? failure,
    bool? loading,
    bool? valueChecking,
    List<ColorsModel>? colorsList,
    bool? validEmail,
    bool? validName,
  }) {
    return AuthState(
      userInfo: userInfo ?? this.userInfo,
      countryList: countryList ?? this.countryList,
      languageList: languageList ?? this.languageList,
      failure: failure ?? this.failure,
      loading: loading ?? this.loading,
      valueChecking: valueChecking ?? this.valueChecking,
      colorsList: colorsList ?? this.colorsList,
      validEmail: validEmail ?? this.validEmail,
      validName: validName ?? this.validName,
    );
  }

  @override
  List<Object?> get props {
    return [
      userInfo,
      countryList,
      languageList,
      failure,
      loading,
      valueChecking,
      colorsList,
      validEmail,
      validName,
    ];
  }

  @override
  String toString() {
    return 'AuthState(userInfo: $userInfo, countryList: $countryList, languageList: $languageList, failure: $failure, loading: $loading, valueChecking: $valueChecking, colorsList: $colorsList, validEmail: $validEmail, validName: $validName)';
  }
}
