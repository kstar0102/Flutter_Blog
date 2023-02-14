class StoryTopic {
  int? id;
  int? index;
  String? value;
  int? fatherId;
  String? storyTopic;
  StoryTopic({
    this.id,
    this.index,
    this.value,
    this.fatherId,
    this.storyTopic,
  });

  StoryTopic copyWith({
    int? id,
    int? index,
    String? value,
    int? fatherId,
    String? storyTopic,
  }) {
    return StoryTopic(
      id: id ?? this.id,
      index: index ?? this.index,
      value: value ?? this.value,
      fatherId: fatherId ?? this.fatherId,
      storyTopic: storyTopic ?? this.storyTopic,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'index': index,
      'value': value,
      'fatherId': fatherId,
      'storyTopic': storyTopic,
    };
  }

  factory StoryTopic.fromMap(Map<String, dynamic> map) {
    return StoryTopic(
      id: map['id']?.toInt(),
      index: map['index']?.toInt(),
      value: map['value'],
      fatherId: map['fatherId']?.toInt(),
      storyTopic: map['storyTopic'],
    );
  }
}
