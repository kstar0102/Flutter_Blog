import 'dart:convert';

import 'package:equatable/equatable.dart';

class Reply extends Equatable {

  final int id;
  final String publishDate;
  final String body;
  final int commentId;
  final int storyId;
  final int userId;
  final String language;
  final bool isPendingApproval;
  final bool isDeniedApproval;

  const Reply({
    required this.id,
    required this.publishDate,
    required this.body,
    required this.commentId,
    required this.storyId,
    required this.userId,
    required this.language,
    required this.isPendingApproval,
    required this.isDeniedApproval
  });

  Reply copyWith({
    int? id,
    String? publishDate,
    String? body,
    int? commentId,
    int? storyId,
    int? userId,
    String? language,
    bool? isPendingApproval,
    bool? isDeniedApproval
  }) {
    return Reply(
        id: id ?? this.id,
        publishDate: publishDate ?? this.publishDate,
        body: body ?? this.body,
        commentId: commentId ?? this.commentId,
        storyId: storyId ?? this.storyId,
        userId: userId ?? this.userId,
        language: language ?? this.language,
        isPendingApproval: isPendingApproval ?? this.isPendingApproval,
        isDeniedApproval: isDeniedApproval ?? this.isDeniedApproval
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'publishDate': publishDate,
      'body': body,
      'commentId': commentId,
      'storyId': storyId,
      'userId': userId,
      'language': language,
      'isPendingApproval': isPendingApproval,
      'isDeniedApproval': isDeniedApproval
    };
  }

  factory Reply.fromMap(Map<String, dynamic> map) {
    return Reply(
        id: int.parse(map['id']) ?? 0,
        publishDate: map['publishDate'] ?? '',
        body: map['body'] ?? '',
        commentId: int.parse(map['commentId']) ?? 0,
        storyId: int.parse(map['storyId']) ?? 0,
        userId: int.parse(map['userId']) ?? 0,
        language: map['language'] ?? '',
        isPendingApproval: map['isPendingApproval'] ?? true,
        isDeniedApproval: map['isDeniedApproval'] ?? false
    );
  }

  String toJson() => json.encode(toMap());

  factory Reply.fromJson(String source) => Reply.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Reply(id: $id, publishDate: $publishDate, body: $body, userId: $userId, storyId: $storyId, commentId: $commentId, language: $language, isPendingApproval: $isPendingApproval, isDeniedApproval: $isDeniedApproval)';
  }


  @override
  // TODO: implement props
  List<Object?> get props => [id, publishDate, body, userId, storyId, commentId, language, isPendingApproval, isDeniedApproval];

}