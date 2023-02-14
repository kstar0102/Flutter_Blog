import 'package:clean_api/clean_api.dart';
import 'package:equatable/equatable.dart';
import 'package:get_storage/get_storage.dart';

var box = GetStorage();
class UserInfo extends Equatable {
  final int totalPending;
  final int totalDrafts;
  final int totalApproval;
  final int totalImTailing;
  final int deniedPublished;
  final String name;
  final String color;
  final int count;
  final int id;
  final String gender;
  final int inboxCount;
  final int newImTailingCount;
  final int unreadNotifsNo;
  final int yearOfBirth;
  const UserInfo({
    required this.totalPending,
    required this.totalDrafts,
    required this.totalApproval,
    required this.totalImTailing,
    required this.deniedPublished,
    required this.name,
    required this.color,
    required this.count,
    required this.id,
    required this.gender,
    required this.inboxCount,
    required this.newImTailingCount,
    required this.unreadNotifsNo,
    required this.yearOfBirth,
  });

  factory UserInfo.empty() => const UserInfo(
      color: '',
      count: 0,
      deniedPublished: 0,
      gender: '',
      id: 0,
      inboxCount: 0,
      name: '',
      newImTailingCount: 0,
      totalApproval: 0,
      totalDrafts: 0,
      totalImTailing: 0,
      totalPending: 0,
      unreadNotifsNo: 0,
      yearOfBirth: 0);
  UserInfo copyWith({
    int? totalPending,
    int? totalDrafts,
    int? totalApproval,
    int? totalImTailing,
    int? deniedPublished,
    String? name,
    String? color,
    int? count,
    int? id,
    String? gender,
    int? inboxCount,
    int? newImTailingCount,
    int? unreadNotifsNo,
    int? yearOfBirth,
  }) {
    return UserInfo(
      totalPending: totalPending ?? this.totalPending,
      totalDrafts: totalDrafts ?? this.totalDrafts,
      totalApproval: totalApproval ?? this.totalApproval,
      totalImTailing: totalImTailing ?? this.totalImTailing,
      deniedPublished: deniedPublished ?? this.deniedPublished,
      name: name ?? this.name,
      color: color ?? this.color,
      count: count ?? this.count,
      id: id ?? this.id,
      gender: gender ?? this.gender,
      inboxCount: inboxCount ?? this.inboxCount,
      newImTailingCount: newImTailingCount ?? this.newImTailingCount,
      unreadNotifsNo: unreadNotifsNo ?? this.unreadNotifsNo,
      yearOfBirth: yearOfBirth ?? this.yearOfBirth,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'totalPending': totalPending,
      'totalDrafts': totalDrafts,
      'totalApproval': totalApproval,
      'totalImTailing': totalImTailing,
      'deniedPublished': deniedPublished,
      'name': name,
      'color': color,
      'count': count,
      'id': id,
      'gender': gender,
      'inboxCount': inboxCount,
      'newImTailingCount': newImTailingCount,
      'unreadNotifsNo': unreadNotifsNo,
      'yearOfBirth': yearOfBirth,
    };
  }

  factory UserInfo.fromMap(Map<String, dynamic> map) {
    return UserInfo(
      totalPending: map['totalPending']?.toInt() ?? 0,
      totalDrafts: map['totalDrafts']?.toInt() ?? 0,
      totalApproval: map['totalApproval']?.toInt() ?? 0,
      totalImTailing: map['totalImTailing']?.toInt() ?? 0,
      deniedPublished: map['deniedPublished']?.toInt() ?? 0,
      name: map['name'] ?? '',
      color: map['color'] ?? '',
      count: map['count']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
      gender:
          map['gender'] != null && map['gender'] is String ? map['gender'] : '',
      inboxCount: map['inboxCount']?.toInt() ?? 0,
      newImTailingCount: map['newImTailingCount']?.toInt() ?? 0,
      unreadNotifsNo: map['unreadNotifsNo']?.toInt() ?? 0,
      yearOfBirth: map['yearOfBirth']?.toInt() ?? 0,
    );
  }

  // String toJson() => json.encode(toMap());

  // factory UserInfo.fromJson(String source) => UserInfo.fromMap(json.decode(source));

  @override
  String toString() {
    box.write('userID' , id);
    Logger.e(box.read('UserID'));
    return 'UserInfo(totalPending: $totalPending, totalDrafts: $totalDrafts, totalApproval: $totalApproval, totalImTailing: $totalImTailing, deniedPublished: $deniedPublished, name: $name, color: $color, count: $count, id: $id, gender: $gender, inboxCount: $inboxCount, newImTailingCount: $newImTailingCount, unreadNotifsNo: $unreadNotifsNo, yearOfBirth: $yearOfBirth)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserInfo &&
        other.totalPending == totalPending &&
        other.totalDrafts == totalDrafts &&
        other.totalApproval == totalApproval &&
        other.totalImTailing == totalImTailing &&
        other.deniedPublished == deniedPublished &&
        other.name == name &&
        other.color == color &&
        other.count == count &&
        other.id == id &&
        other.gender == gender &&
        other.inboxCount == inboxCount &&
        other.newImTailingCount == newImTailingCount &&
        other.unreadNotifsNo == unreadNotifsNo &&
        other.yearOfBirth == yearOfBirth;
  }

  @override
  int get hashCode {
    return totalPending.hashCode ^
        totalDrafts.hashCode ^
        totalApproval.hashCode ^
        totalImTailing.hashCode ^
        deniedPublished.hashCode ^
        name.hashCode ^
        color.hashCode ^
        count.hashCode ^
        id.hashCode ^
        gender.hashCode ^
        inboxCount.hashCode ^
        newImTailingCount.hashCode ^
        unreadNotifsNo.hashCode ^
        yearOfBirth.hashCode;
  }

  @override
  List<Object> get props {
    return [
      totalPending,
      totalDrafts,
      totalApproval,
      totalImTailing,
      deniedPublished,
      name,
      color,
      count,
      id,
      gender,
      inboxCount,
      newImTailingCount,
      unreadNotifsNo,
      yearOfBirth,
    ];
  }
}
