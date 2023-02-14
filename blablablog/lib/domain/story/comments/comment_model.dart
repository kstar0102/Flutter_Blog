import 'dart:convert';

import 'package:blabloglucy/domain/story/comments/comment.dart';
import 'package:blabloglucy/domain/story/comments/comment_item_color.dart';
import 'package:blabloglucy/domain/story/user.dart';

class CommentModel {
  final Comment comment;
  final User user;
  bool? showInput;
  final CommentItemColor itemColor;
  CommentModel(
      {required this.comment,
      required this.user,
      required this.itemColor,
      this.showInput});

  CommentModel copyWith({
    Comment? comment,
    User? user,
    CommentItemColor? itemColor,
  }) {
    return CommentModel(
      comment: comment ?? this.comment,
      user: user ?? this.user,
      itemColor: itemColor ?? this.itemColor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': comment.toMap(),
      'user': user.toMap(),
      'itemColor': itemColor.toMap(),
    };
  }

  factory CommentModel.fromMap(Map<String, dynamic> map) {
    return CommentModel(
      comment: Comment.fromMap(map['comment']),
      user: User.fromMap(map['user']),
      itemColor: CommentItemColor.fromMap(map['itemColor']),
    );
  }

  String toJson() => json.encode(toMap());

  factory CommentModel.fromJson(String source) =>
      CommentModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'CommentModel(comment: $comment, user: $user, itemColor: $itemColor)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is CommentModel &&
        other.comment == comment &&
        other.user == user &&
        other.itemColor == itemColor;
  }

  @override
  int get hashCode => comment.hashCode ^ user.hashCode ^ itemColor.hashCode;
}
