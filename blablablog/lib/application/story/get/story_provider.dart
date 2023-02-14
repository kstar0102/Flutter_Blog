import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blabloglucy/application/story/get/story_state.dart';
import 'package:blabloglucy/domain/story/i_story_repo.dart';
import 'package:blabloglucy/infrastructure/story/story_repo.dart';

final storyProvider = StateNotifierProvider<StoryNotifier, StoryState>((ref) {
  return StoryNotifier(StoryRepo());
});

class StoryNotifier extends StateNotifier<StoryState> {
  final IStoryRepo storyRepo;
  StoryNotifier(this.storyRepo) : super(StoryState.init());

  getStories() async {
    state = state.copyWith(loading: true);
    final data = await storyRepo.getStory();
    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
        loading: false,
        storyList: r,
      ),
    );
  }

  like(int id) async {
    state = state.copyWith(loading: true);
    final data = await storyRepo.like(id);
    data.fold(
        (l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(
              loading: false,
            ));

    getStories();
  }

  deleteComment(int id) async {
    state = state.copyWith(loading: true);
    final data = await storyRepo.deleteComment(id);
    data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(
        loading: false,
      ),
    );
  }

  viewStory(int id) async {
    state = state.copyWith(loading: true);
    final data = await storyRepo.viewStory(id);
    data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => state.copyWith(loading: false),
    );
    getStories();
  }

  deleteStory(int storyId) async {
    state = state.copyWith(loading: true);
    final data = await storyRepo.deleteComment(storyId);
    data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false));
    getStories();
  }
}
