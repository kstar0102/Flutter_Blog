// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'user.dart';

class Story extends Equatable {
  final int id;
  final int storyStatus;
  final String body;
  bool? isCommentsAllowed;
  String title;
  final String description;
  final int userId;
  final String publishDate;
  final int views;
  final int likes;
  final User? user;
  Story({
    required this.id,
    required this.storyStatus,
    required this.body,
    this.isCommentsAllowed,
    required this.title,
    required this.description,
    required this.userId,
    required this.publishDate,
    required this.views,
    required this.likes,
    required this.user,
  });

  Story copyWith({
    int? id,
    int? storyStatus,
    String? body,
    bool? isCommentsAllowed,
    String? title,
    String? description,
    int? userId,
    String? publishDate,
    int? views,
    int? likes,
    User? user,
  }) {
    return Story(
      id: id ?? this.id,
      storyStatus: storyStatus ?? this.storyStatus,
      body: body ?? this.body,
      isCommentsAllowed: isCommentsAllowed ?? this.isCommentsAllowed,
      title: title ?? this.title,
      description: description ?? this.description,
      userId: userId ?? this.userId,
      publishDate: publishDate ?? this.publishDate,
      views: views ?? this.views,
      likes: likes ?? this.likes,
      user: user ?? this.user,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'storyStatus': storyStatus,
      'body': body,
      'isCommentsAlowed': isCommentsAllowed,
      'title': title,
      'description': description,
      'userId': userId,
      'publishDate': publishDate,
      'views': views,
      'likes': likes,
      'user': user?.toMap(),
    };
  }

  factory Story.fromMap(Map<String, dynamic> map) {
    return Story(
      id: map['id']?.toInt() ?? 0,
      storyStatus: map['storyStatus']?.toInt() ?? 0,
      body: map['body'] ?? '',
      isCommentsAllowed: map['isCommentsAlowed'] ?? false,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      userId: map['userId']?.toInt() ?? 0,
      publishDate: map['publishDate'] ?? '',
      views: map['views']?.toInt() ?? 0,
      likes: map['likes']?.toInt() ?? 0,
      user: map['user'] != null ? User.fromMap(map['user']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Story.fromJson(String source) => Story.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Story(id: $id, storyStatus: $storyStatus, body: $body, isCommentsAlowed: $isCommentsAllowed, title: $title, description: $description, userId: $userId, publishDate: $publishDate, views: $views, likes: $likes, user: $user)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      storyStatus,
      body,
      isCommentsAllowed,
      title,
      description,
      userId,
      publishDate,
      views,
      likes,
      user,
    ];
  }
}
