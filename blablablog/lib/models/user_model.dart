class UserModel {
  String? nickName;
  int? userId;
  int? userGender;
  int? yearOfBirth;
  UserItemColor? color;
  UserModel({
    this.nickName,
    this.userId,
    this.userGender,
    this.yearOfBirth,
    this.color,
  });

  Map<String, dynamic> toMap() {
    return {
      'nickName': nickName,
      'id': userId,
      'gender': userGender,
      'yearOfBirth': yearOfBirth,
      'itemColor': color,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      nickName: map['nickName'],
      userId: map['id']?.toInt(),
      userGender: map['gender']?.toInt(),
      yearOfBirth: map['yearOfBirth']?.toInt(),
      color: map['itemColor'] != null ? UserItemColor.fromMap(map['itemColor']) : null,
    );
  }
}

class UserItemColor {
  int? id;
  int? index;
  String? value;
  String? fatherName;
  String? color;
  bool? isSpecial;
  int? fatherId;
  UserItemColor({
    this.id,
    this.index,
    this.value,
    this.fatherName,
    this.color,
    this.isSpecial,
    this.fatherId,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'index': index,
      'value': value,
      'fatherName': fatherName,
      'colorHex': color,
      'isSpecial': isSpecial,
      'fatherId': fatherId,
    };
  }

  factory UserItemColor.fromMap(Map<String, dynamic> map) {
    return UserItemColor(
      id: map['id']?.toInt(),
      index: map['index']?.toInt(),
      value: map['value'],
      fatherName: map['fatherName'],
      color: map['colorHex'],
      isSpecial: map['isSpecial'],
      fatherId: map['fatherId']?.toInt(),
    );
  }
}
