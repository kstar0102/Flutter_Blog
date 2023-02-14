import 'package:clean_api/clean_api.dart';
import 'package:blabloglucy/domain/story/post_topic/topic.dart';

abstract class ITopicRepo {
  Future<Either<CleanFailure, List<Topics>>> getTopics();
}
