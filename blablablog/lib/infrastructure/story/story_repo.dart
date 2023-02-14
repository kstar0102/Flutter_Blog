import 'package:clean_api/clean_api.dart';
import 'package:blabloglucy/domain/story/create_story.dart';
import 'package:blabloglucy/domain/story/i_story_repo.dart';
import 'package:blabloglucy/domain/story/story_model.dart';

class StoryRepo extends IStoryRepo {
  final cleanApi = CleanApi.instance;
  @override
  Future<Either<CleanFailure, List<StoryModel>>> getStory() async {
    return await cleanApi.get(
      fromData: ((json) => List<StoryModel>.from(
            json['payload'].map(
              (e) => StoryModel.fromMap(e),
            ),
          )),
      endPoint: 'stories',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> createStory(
    CreateStory createStory,
  ) async {
    return await cleanApi.post(
      fromData: (json) => unit,
      body: createStory.toMap(),
      endPoint: 'stories',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> like(int id) async {
    return await cleanApi.post(
        fromData: (json) => unit, body: {}, endPoint: 'stories/$id/like');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteComment(int id) async {
    return await cleanApi.delete(
      fromData: (json) => unit,
      endPoint: 'comments/$id',
    );
  }

  @override
  Future<Either<CleanFailure, Unit>> viewStory(int id) async {
    return await cleanApi.post(
        fromData: (json) => unit, body: {}, endPoint: 'stories/$id/view');
  }

  @override
  Future<Either<CleanFailure, Unit>> deleteStory(int postId) async {
    return await cleanApi.delete(
        showLogs: true, fromData: (json) => unit, endPoint: 'stories/$postId');
  }
}
