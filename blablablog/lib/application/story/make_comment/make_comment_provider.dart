import 'package:clean_api/clean_api.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blabloglucy/application/story/make_comment/make_comment_state.dart';
import 'package:blabloglucy/domain/story/comments/i_make_comment_repo.dart';
import 'package:blabloglucy/domain/story/comments/make_comment.dart';
import 'package:blabloglucy/infrastructure/story/make_comment/make_comment_repo.dart';

final makeCommentProvider =
    StateNotifierProvider<MakeCommentNotifier, MakeCommentState>((ref) {
  return MakeCommentNotifier(MakeCommentRepo());
});

class MakeCommentNotifier extends StateNotifier<MakeCommentState> {
  final IMakeCommentRepo makeCommentRepo;
  MakeCommentNotifier(this.makeCommentRepo)
      : super(MakeCommentState(loading: false, failure: CleanFailure.none()));

  makeComment(MakeCommentModel makeCommentModel) async {
    state = state.copyWith(loading: true);
    final data = await makeCommentRepo.makeComment(makeCommentModel);
    state = data.fold((l) => state.copyWith(loading: false, failure: l),
        (r) => state.copyWith(loading: false));
  }
}
