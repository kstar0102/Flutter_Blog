import 'dart:convert';

import 'package:blabloglucy/domain/story/comments/comment.dart';
import 'package:blabloglucy/domain/story/comments/comment_item_color.dart';
import 'package:blabloglucy/domain/story/replies/reply.dart';
import 'package:blabloglucy/domain/story/user.dart';

class ReplyModal {
  final Reply reply;
  final User user;
  bool? showInput;
  final CommentItemColor itemColor;
  ReplyModal(
      {required this.reply,
        required this.user,
        required this.itemColor,
        this.showInput});

  ReplyModal copyWith({
    Reply? reply,
    User? user,
    CommentItemColor? itemColor,
  }) {
    return ReplyModal(
      reply: reply ?? this.reply,
      user: user ?? this.user,
      itemColor: itemColor ?? this.itemColor,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'comment': reply.toMap(),
      'user': user.toMap(),
      'itemColor': itemColor.toMap(),
    };
  }

  factory ReplyModal.fromMap(Map<String, dynamic> map) {
    return ReplyModal(
      reply: Reply.fromMap(map['reply']),
      user: User.fromMap(map['user']),
      itemColor: CommentItemColor.fromMap(map['itemColor']),
    );
  }

  String toJson() => json.encode(toMap());

  factory ReplyModal.fromJson(String source) =>
      ReplyModal.fromMap(json.decode(source));

  @override
  String toString() =>
      'CommentModel(reply: $reply, user: $user, itemColor: $itemColor)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is ReplyModal &&
        other.reply == reply &&
        other.user == user &&
        other.itemColor == itemColor;
  }

  @override
  int get hashCode => reply.hashCode ^ user.hashCode ^ itemColor.hashCode;
}
