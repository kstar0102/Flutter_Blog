import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

class MakeCommentState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  const MakeCommentState({
    required this.loading,
    required this.failure,
  });

  MakeCommentState copyWith({
    bool? loading,
    CleanFailure? failure,
  }) {
    return MakeCommentState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
    );
  }

  @override
  List<Object?> get props => [loading, failure];
}
