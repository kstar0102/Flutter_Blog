import 'dart:convert';

import 'package:equatable/equatable.dart';

class MakeCommentModel extends Equatable {
  final int storyId;
  final String body;
  const MakeCommentModel({
    required this.storyId,
    required this.body,
  });

  MakeCommentModel copyWith({
    int? storyId,
    String? body,
  }) {
    return MakeCommentModel(
      storyId: storyId ?? this.storyId,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'StoryId': storyId,
      'Body': body,
    };
  }

  factory MakeCommentModel.fromMap(Map<String, dynamic> map) {
    return MakeCommentModel(
      storyId: map['StoryId']?.toInt() ?? 0,
      body: map['Body'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory MakeCommentModel.fromJson(String source) => MakeCommentModel.fromMap(json.decode(source));

  @override
  String toString() => 'SubmitCommentModel(StoryId: $storyId, Body: $body)';

  @override
  List<Object> get props => [storyId, body];
}
