import 'package:clean_api/clean_api.dart';
import 'package:blabloglucy/domain/story/post_topic/i_topic_repo.dart';
import 'package:blabloglucy/domain/story/post_topic/topic.dart';

class TopicRepo extends ITopicRepo {
  final cleanApi = CleanApi.instance;
  @override
  Future<Either<CleanFailure, List<Topics>>> getTopics() async {
    return await cleanApi.get(
      fromData: (json) =>
          List<Topics>.from(json['payload'].map((e) => Topics.fromMap(e))),
      endPoint: 'lists/topics',
    );
  }
}
