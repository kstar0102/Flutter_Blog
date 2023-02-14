class NotificationModel {
  int? id;
  int? storyOwnerId;
  int? commentUserId;
  int? storyId;
  int? commentId;
  String? notificationType;
  int? isRead;
  String? message;
  String? storyTitle;
  String? notificationDate;
  String? nickName;
  String? userColor;
  String? userGender;
  NotificationModel({
    this.id,
    this.storyOwnerId,
    this.commentUserId,
    this.storyId,
    this.commentId,
    this.notificationType,
    this.isRead,
    this.message,
    this.storyTitle,
    this.notificationDate,
    this.nickName,
    this.userColor,
    this.userGender,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'storyOwnerId': storyOwnerId,
      'commentUserId': commentUserId,
      'storyId': storyId,
      'commentId': commentId,
      'type': notificationType,
      'isRead': isRead,
      'message': message,
      'storyTitle': storyTitle,
      'notifDate': notificationDate,
      'nickName': nickName,
      'color': userColor,
      'gender': userGender,
    };
  }

  factory NotificationModel.fromMap(Map<String, dynamic> map) {
    return NotificationModel(
      id: map['id']?.toInt(),
      storyOwnerId: map['storyOwnerId']?.toInt(),
      commentUserId: map['commentUserId']?.toInt(),
      storyId: map['storyId']?.toInt(),
      commentId: map['commentId']?.toInt(),
      notificationType: map['type'],
      isRead: map['isRead']?.toInt(),
      message: map['message'],
      storyTitle: map['storyTitle'],
      notificationDate: map['notifDate'],
      nickName: map['nickName'],
      userColor: map['color'],
      userGender: map['gender'],
    );
  }
}
