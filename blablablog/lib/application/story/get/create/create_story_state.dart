import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';

class CreateStoryState extends Equatable {
  final bool loading;
  final CleanFailure failure;
  const CreateStoryState({
    required this.loading,
    required this.failure,
  });

  @override
  List<Object?> get props => [loading, failure];

  @override
  String toString() => 'CreateStoryState(loading: $loading, failure: $failure)';

  CreateStoryState copyWith({
    bool? loading,
    CleanFailure? failure,
  }) {
    return CreateStoryState(
      loading: loading ?? this.loading,
      failure: failure ?? this.failure,
    );
  }
}
