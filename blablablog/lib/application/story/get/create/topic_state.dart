import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:blabloglucy/domain/story/post_topic/topic.dart';

class TopicState extends Equatable {
  final List<Topics> topicList;
  final CleanFailure failure;
  final bool loading;
  const TopicState({
    required this.topicList,
    required this.failure,
    required this.loading,
  });

  @override
  List<Object?> get props => [topicList, loading, failure];

  TopicState copyWith({
    List<Topics>? topicList,
    CleanFailure? failure,
    bool? loading,
  }) {
    return TopicState(
      topicList: topicList ?? this.topicList,
      failure: failure ?? this.failure,
      loading: loading ?? this.loading,
    );
  }

  factory TopicState.init() => TopicState(
      topicList: const [], failure: CleanFailure.none(), loading: false);
}
