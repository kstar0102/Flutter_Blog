import 'dart:convert';

import 'package:blabloglucy/models/user_model.dart';

class UserChat {
  bool? mine;
  int? chatId;
  bool? isUserBlocked;
  int? messageCount;
  UserModel? otherProfile;
  UserModel? myProfile;
  List<SingleMessage>? messages;
  UserChat({
    this.mine,
    this.chatId,
    this.isUserBlocked,
    this.messageCount,
    this.otherProfile,
    this.myProfile,
    this.messages,
  });

  Map<String, dynamic> toMap() {
    return {
      'mine': mine,
      'key': chatId,
      'isUserBlocked': isUserBlocked,
      'count': messageCount,
      'leftUser': otherProfile?.toMap(),
      'rightUser': myProfile?.toMap(),
      'messages': messages?.map((x) => x.toMap()).toList(),
    };
  }

  factory UserChat.fromMap(Map<String, dynamic> map) {
    return UserChat(
      mine: map['mine'],
      chatId: map['key'],
      isUserBlocked: map['isUserBlocked'],
      messageCount: map['count']?.toInt(),
      otherProfile:
          map['leftUser'] != null ? UserModel.fromMap(map['leftUser']) : null,
      myProfile:
          map['rightUser'] != null ? UserModel.fromMap(map['rightUser']) : null,
      messages: map['messages'] != null
          ? List<SingleMessage>.from(
              map['messages']?.map((x) => SingleMessage.fromMap(x)))
          : null,
    );
  }
}

class SingleMessage {
  int? id;
  int? otherProfileId;
  int? myProfileId;
  String? message;
  String? createdAt;
  bool? isRead;
  bool? isBlocked;
  bool? isOtherProfileCleared;
  bool? isMyProfileCleared;
  UserModel? oUser;
  SingleMessage({
    this.id,
    this.otherProfileId,
    this.myProfileId,
    this.message,
    this.createdAt,
    this.isRead,
    this.isBlocked,
    this.isOtherProfileCleared,
    this.isMyProfileCleared,
    this.oUser,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'leftId': otherProfileId,
      'rightId': myProfileId,
      'message': message,
      'messageDate': createdAt,
      'isRead': isRead,
      'isBlocked': isBlocked,
      'isClearedRight': isOtherProfileCleared,
      'isClearedLeft': isMyProfileCleared,
      'oUser': oUser?.toMap(),
    };
  }

  factory SingleMessage.fromMap(Map<String, dynamic> map) {
    return SingleMessage(
      id: map['id']?.toInt(),
      otherProfileId: map['leftId']?.toInt(),
      myProfileId: map['rightId']?.toInt(),
      message: map['message'],
      createdAt: map['messageDate'],
      isRead: map['isRead'],
      isBlocked: map['isBlocked'],
      isOtherProfileCleared: map['isClearedRight'],
      isMyProfileCleared: map['isClearedLeft'],
      oUser: map['oUser'] != null ? UserModel.fromMap(map['oUser']) : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory SingleMessage.fromJson(String source) =>
      SingleMessage.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SingleMessage(id: $id, otherProfileId: $otherProfileId, myProfileId: $myProfileId, message: $message, createdAt: $createdAt, isRead: $isRead, isBlocked: $isBlocked, isOtherProfileCleared: $isOtherProfileCleared, isMyProfileCleared: $isMyProfileCleared, oUser: $oUser)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SingleMessage &&
        other.id == id &&
        other.otherProfileId == otherProfileId &&
        other.myProfileId == myProfileId &&
        other.message == message &&
        other.createdAt == createdAt &&
        other.isRead == isRead &&
        other.isBlocked == isBlocked &&
        other.isOtherProfileCleared == isOtherProfileCleared &&
        other.isMyProfileCleared == isMyProfileCleared &&
        other.oUser == oUser;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        otherProfileId.hashCode ^
        myProfileId.hashCode ^
        message.hashCode ^
        createdAt.hashCode ^
        isRead.hashCode ^
        isBlocked.hashCode ^
        isOtherProfileCleared.hashCode ^
        isMyProfileCleared.hashCode ^
        oUser.hashCode;
  }
}
