import 'package:clean_api/clean_api.dart';
import 'package:blabloglucy/domain/story/comments/make_comment.dart';

abstract class IMakeCommentRepo {
  Future<Either<CleanFailure, Unit>> makeComment(MakeCommentModel comment);
}
