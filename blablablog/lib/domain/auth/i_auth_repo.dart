import 'package:clean_api/clean_api.dart';
import 'package:blabloglucy/domain/auth/models/recovery.dart';
import 'package:blabloglucy/domain/auth/models/colors.dart';
import 'package:blabloglucy/domain/auth/models/countries.dart';
import 'package:blabloglucy/domain/auth/models/language.dart';
import 'package:blabloglucy/domain/auth/models/registration.dart';
import 'package:blabloglucy/domain/auth/models/user_info.dart';

abstract class IAuthRepo {
  Future<Either<CleanFailure, UserInfo>> login({
    required String email,
    required String password,
  });

  Future<Either<CleanFailure, UserInfo>> tryLogin();

  Future<Either<CleanFailure, UserInfo>> getUserInfo();
  Future<Either<CleanFailure, Unit>> registration(Registration registration);
  Future<void> logOut();
  Future<Either<CleanFailure, bool>> nickNameCheck(String nickname);
  Future<Either<CleanFailure, Unit>> passwordRecovary(Recovery recovery);
  Future<Either<CleanFailure, bool>> emailCheck(String email);
  Future<Either<CleanFailure, List<Countries>>> getCountries();
  Future<Either<CleanFailure, List<Language>>> getLanguages();
  Future<Either<CleanFailure, List<ColorsModel>>> getColors();
}
