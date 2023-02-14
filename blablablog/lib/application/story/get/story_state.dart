import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

import 'package:blabloglucy/domain/story/story_model.dart';

class StoryState extends Equatable {
  final List<StoryModel> storyList;
  final CleanFailure failure;
  final bool loading;

  const StoryState(
    this.storyList,
    this.failure,
    this.loading,
  );

  StoryState copyWith({
    List<StoryModel>? storyList,
    CleanFailure? failure,
    bool? loading,
  }) {
    return StoryState(
      storyList ?? this.storyList,
      failure ?? this.failure,
      loading ?? this.loading,
    );
  }

  factory StoryState.init() => StoryState(const [], CleanFailure.none(), false);

  @override
  List<Object> get props => [storyList, loading, failure];
}
