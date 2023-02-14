import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blabloglucy/application/story/get/create/topic_state.dart';
import 'package:blabloglucy/domain/story/post_topic/i_topic_repo.dart';
import 'package:blabloglucy/infrastructure/story/topic_repo.dart';

final topicProvider = StateNotifierProvider<TopicNotifier, TopicState>((ref) {
  return TopicNotifier(TopicRepo());
});

class TopicNotifier extends StateNotifier<TopicState> {
  final ITopicRepo topicRepo;
  TopicNotifier(this.topicRepo) : super(TopicState.init());

  getTopics() async {
    state = state.copyWith(loading: true);
    final data = await topicRepo.getTopics();
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false, topicList: r));
  }
}
