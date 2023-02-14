// To parse this JSON data, do
//
//     final storyModel = storyModelFromMap(jsonString);

import 'dart:convert';

import 'package:blabloglucy/domain/story/comments/comment_model.dart';

import 'story.dart';

class StoryModel {
  StoryModel(
      {required this.story,
      required this.totalComments,
      required this.likedByMe,
      required this.viewedByMe,
      required this.userId,
      required this.myPost,
      required this.userNick,
      required this.userColor,
      required this.userGender,
      required this.comments,
      this.consultImage = '',
      this.image,
      this.category});

  Story story;
  int totalComments;
  bool likedByMe;
  bool viewedByMe;
  int userId;
  bool myPost;
  String userNick;
  String userColor;
  String userGender;
  List<CommentModel> comments;
  String consultImage;
  String? image;
  String? category;

  StoryModel copyWith(
          {required Story story,
          required int totalComments,
          required bool likedByMe,
          required bool viewedByMe,
          required int userId,
          required bool myPost,
          required String userNick,
          required String userColor,
          required String userGender,
          required List<CommentModel> comments,
          String? category}) =>
      StoryModel(
          story: story,
          consultImage: consultImage,
          totalComments: totalComments,
          likedByMe: likedByMe,
          viewedByMe: viewedByMe,
          userId: userId,
          myPost: myPost,
          userNick: userNick,
          userColor: userColor,
          userGender: userGender,
          comments: comments,
          image: image,
          category: this.category);

  factory StoryModel.fromJson(String str) =>
      StoryModel.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());
  factory StoryModel.consultFromMap(Map<String, dynamic> json) {
    return StoryModel(
        story: Story.fromMap(json['story']),
        totalComments: json['totalComments'],
        likedByMe: json['likedByMe'],
        viewedByMe: json['viewedByMe'],
        userId: json['userId'],
        myPost: json['myPost'],
        userNick: json['userNick'],
        userColor: json['userColor'],
        userGender: json['userGender'],
        comments: List<CommentModel>.from(
            json['comments'].map((x) => CommentModel.fromMap(x))),
        consultImage: json['consultImage'],
        category: json['Category']);
  }
  factory StoryModel.fromMap(Map<String, dynamic> json) => StoryModel(
        story: Story.fromMap(json['story']),
        totalComments: json['totalComments'],
        likedByMe: json['likedByMe'],
        category: json['Category'],
        viewedByMe: json['viewedByMe'],
        userId: json['userId'],
        myPost: json['myPost'],
        userNick: json['userNick'],
        userColor: json['userColor'],
        userGender: json['userGender'],
        comments: List<CommentModel>.from(
            json['comments'].map((x) => CommentModel.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        'story': story.toMap(),
        'totalComments': totalComments,
        'consultImage': consultImage,
        'likedByMe': likedByMe,
        'viewedByMe': viewedByMe,
        'userId': userId,
        'myPost': myPost,
        'userNick': userNick,
        'userColor': userColor,
        'userGender': userGender,
        'Category': category,
        'comments': List<dynamic>.from(comments.map((e) => e.toMap())),
      };
}
