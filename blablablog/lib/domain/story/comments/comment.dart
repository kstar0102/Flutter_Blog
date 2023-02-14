import 'dart:convert';

class Comment {
  final int id;
  final String publishDate;
  final String body;
  final int userId;
  final int storyId;
  Comment({
    required this.id,
    required this.publishDate,
    required this.body,
    required this.userId,
    required this.storyId,
  });

  Comment copyWith({
    int? id,
    String? publishDate,
    String? body,
    int? userId,
    int? storyId,
  }) {
    return Comment(
      id: id ?? this.id,
      publishDate: publishDate ?? this.publishDate,
      body: body ?? this.body,
      userId: userId ?? this.userId,
      storyId: storyId ?? this.storyId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'publishDate': publishDate,
      'body': body,
      'userId': userId,
      'storyId': storyId,
    };
  }

  factory Comment.fromMap(Map<String, dynamic> map) {
    return Comment(
      id: map['id']?.toInt() ?? 0,
      publishDate: map['publishDate'] ?? '',
      body: map['body'] ?? '',
      userId: map['userId']?.toInt() ?? 0,
      storyId: map['storyId']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory Comment.fromJson(String source) =>
      Comment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Comment(id: $id, publishDate: $publishDate, body: $body, userId: $userId, storyId: $storyId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.id == id &&
        other.publishDate == publishDate &&
        other.body == body &&
        other.userId == userId &&
        other.storyId == storyId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        publishDate.hashCode ^
        body.hashCode ^
        userId.hashCode ^
        storyId.hashCode;
  }
}
