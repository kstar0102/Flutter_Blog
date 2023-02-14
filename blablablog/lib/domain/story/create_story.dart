import 'dart:convert';

import 'package:equatable/equatable.dart';

class CreateStory extends Equatable {
  final String topic;
  final String body;
  final String title;
  final int storyStatus;
  final int isCommentsAlowed;
  final String description;
  final String topicValue;
  const CreateStory({
    required this.topic,
    required this.body,
    required this.title,
    required this.storyStatus,
    required this.isCommentsAlowed,
    required this.description,
    required this.topicValue,
  });

  CreateStory copyWith({
    String? topic,
    String? body,
    String? title,
    int? storyStatus,
    int? isCommentsAlowed,
    String? description,
    String? topicValue,
  }) {
    return CreateStory(
      topic: topic ?? this.topic,
      body: body ?? this.body,
      title: title ?? this.title,
      storyStatus: storyStatus ?? this.storyStatus,
      isCommentsAlowed: isCommentsAlowed ?? this.isCommentsAlowed,
      description: description ?? this.description,
      topicValue: topicValue ?? this.topicValue,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'topic': topic,
      'body': body,
      'title': title,
      'storyStatus': storyStatus,
      'isCommentsAlowed': isCommentsAlowed,
      'description': description,
      'topicValue': topicValue,
    };
  }

  factory CreateStory.fromMap(Map<String, dynamic> map) {
    return CreateStory(
      topic: map['topic'] ?? '',
      body: map['body'] ?? '',
      title: map['title'] ?? '',
      storyStatus: map['storyStatus']?.toInt() ?? 0,
      isCommentsAlowed: map['isCommentsAlowed']?.toInt() ?? 0,
      description: map['description'] ?? '',
      topicValue: map['topicValue'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreateStory.fromJson(String source) =>
      CreateStory.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreateStory(topic: $topic, body: $body, title: $title, storyStatus: $storyStatus, isCommentsAlowed: $isCommentsAlowed, description: $description, topicValue: $topicValue)';
  }

  @override
  List<Object> get props {
    return [
      topic,
      body,
      title,
      storyStatus,
      isCommentsAlowed,
      description,
      topicValue,
    ];
  }
}
