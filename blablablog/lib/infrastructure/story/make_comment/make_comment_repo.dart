import 'package:clean_api/clean_api.dart';
import 'package:blabloglucy/domain/story/comments/i_make_comment_repo.dart';
import 'package:blabloglucy/domain/story/comments/make_comment.dart';

class MakeCommentRepo extends IMakeCommentRepo {
  @override
  Future<Either<CleanFailure, Unit>> makeComment(
    MakeCommentModel comment,
  ) async {
    final cleanApi = CleanApi.instance;
    return await cleanApi.post(
      fromData: (json) => unit,
      body: comment.toMap(),
      endPoint: 'comments',
    );
  }
}
