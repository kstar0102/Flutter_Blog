import 'package:clean_api/clean_api.dart';

import 'package:blabloglucy/domain/story/create_story.dart';

import 'package:blabloglucy/domain/story/story_model.dart';

abstract class IStoryRepo {
  Future<Either<CleanFailure, List<StoryModel>>> getStory();
  Future<Either<CleanFailure, Unit>> createStory(CreateStory createStory);
  Future<Either<CleanFailure, Unit>> like(int id);
  Future<Either<CleanFailure, Unit>> deleteComment(int id);
  Future<Either<CleanFailure, Unit>> viewStory(int id);
  Future<Either<CleanFailure, Unit>> deleteStory(int postId);
}
