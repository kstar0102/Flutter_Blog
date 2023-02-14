import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blabloglucy/application/story/get/create/create_story_state.dart';
import 'package:blabloglucy/domain/story/create_story.dart';
import 'package:blabloglucy/domain/story/i_story_repo.dart';
import 'package:blabloglucy/infrastructure/story/story_repo.dart';

final createStoryProvider =
    StateNotifierProvider<CreateStoryNotifier, CreateStoryState>((ref) {
  return CreateStoryNotifier(storyRepo: StoryRepo());
});

class CreateStoryNotifier extends StateNotifier<CreateStoryState> {
  final IStoryRepo storyRepo;
  CreateStoryNotifier({
    required this.storyRepo,
  }) : super(CreateStoryState(loading: false, failure: CleanFailure.none()));

  createStory(CreateStory createStory) async {
    final data = await storyRepo.createStory(createStory);

    state = data.fold(
      (l) => state.copyWith(loading: false, failure: l),
      (r) => CreateStoryState(
        loading: false,
        failure: CleanFailure.none(),
      ),
    );
  }
}
