// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/domain/auth/models/user_info.dart';
import 'package:blabloglucy/models/notification.dart';
import 'package:blabloglucy/presentation/screens/main_screen.dart';
import 'package:blabloglucy/providers/chat_provider.dart';
import 'package:blabloglucy/providers/story_provider.dart';
import 'package:blabloglucy/providers/widget_provider.dart';
import 'package:blabloglucy/utills/api_network.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/utills/prefs.dart';

class UserProvider with ChangeNotifier {
  String? authToken;
  var box = GetStorage();
  changeAuthToken({required String authToken}) {
    this.authToken = authToken;
    notifyListeners();
  }

  Future userLogin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    Uri uri = Uri.tryParse(ApiNetwork.userLogin)!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    StoryProvider storyProvider = Provider.of<StoryProvider>(
      context,
      listen: false,
    );
    await widgetProvider.returnConnection().post(uri,
        body: json.encode({
          'Email': email,
          'Password': password,
        }),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
        }).catchError((e) {
      throw e;
    }).then((value) {
      var response = json.decode(value.body);
      if (response['errors'] != null && response['errors'].isNotEmpty) {
      } else {
        changeAuthToken(authToken: response['payload']);
        saveAuthToken(authToken!);
        getUserInfo(context: context);
        storyProvider.getStories(context: context);
        getNotifications(context: context, pageNumber: 0);
        getTopics(context: context);
        storyProvider.getStoriesbyGroup(context: context);
        storyProvider.getMyPublishedStories(context: context);
        storyProvider.getMyDraftStories(context: context);
        storyProvider.getMyPendingStories(context: context);
        storyProvider.getMyRejectedStories(context: context);

        Provider.of<ChatProvider>(context, listen: false).getUserChatList(
          context: context,
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) {
              return MainScreen();
            },
          ),
        );
      }
    });
  }

  UserInfo? userInfo;
  changeUserInfo({required UserInfo userInfo}) {
    this.userInfo = userInfo;
    notifyListeners();
  }

  Future getUserInfo({required BuildContext context}) async {
    // String authToken = await getAuthToken();
    // changeAuthToken(authToken: authToken);
    Uri uri = Uri.tryParse(ApiNetwork.getUserInfo)!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider
        .returnConnection()
        .get(
          uri,
          headers: Constants.authenticatedHeaders(
              context: context, userToken: box.read('userTokenForAuth')),
        )
        .catchError((e) {
      debugPrint(e);
    }).then((value) {
      var response = json.decode(value.body);
      if (response['errors'] != null && response['errors'].isNotEmpty) {
        BotToast.showText(
          text: '${response['errors'][0]['message']}',
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      } else {
        changeUserInfo(userInfo: UserInfo.fromMap(response['payload']));
        box.write('userID', response['payload']['id']);
        Logger.e(box.read('userID'));
      }
    });
  }

  Future getTopics({required BuildContext context}) async {
    String authToken = await getAuthToken();
    changeAuthToken(authToken: authToken);
    Uri uri = Uri.tryParse(ApiNetwork.getTopics)!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider.returnConnection().get(uri, headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $authToken',
    }).catchError(
      (err) {
        throw err;
      },
    ).then((value) {
      var response = json.decode(value.body);
      if (response['errors'] != null && response['errors'].isNotEmpty) {
        BotToast.showText(
          text: '${response['errors'][0]['message']}',
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      } else {}
    });
  }

  Future deleteComment({
    required BuildContext context,
    required int commentId,
  }) async {
    String authToken = await getAuthToken();
    changeAuthToken(authToken: authToken);
    Uri uri = Uri.tryParse(ApiNetwork.deleteComment + commentId.toString())!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider.returnConnection().delete(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    ).catchError(
      (err) {
        throw err;
      },
    ).then((value) {
      var response = json.decode(value.body);
      if (response['errors'] != null && response['errors'].isNotEmpty) {
        BotToast.showText(
          text: '${response['errors'][0]['message']}',
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      } else {
        BotToast.showText(
          text: TKeys.commentDeleted.translate(context),
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      }
    });
  }

  Future deleteStory({
    required BuildContext context,
    required int storyId,
  }) async {
    String authToken = await getAuthToken();
    changeAuthToken(authToken: authToken);
    Uri uri = Uri.tryParse(ApiNetwork.deleteStory + storyId.toString())!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider.returnConnection().delete(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    ).catchError(
      (err) {
        throw err;
      },
    ).then((value) {
      var response = json.decode(value.body);
      if (response['errors'] != null && response['errors'].isNotEmpty) {
        BotToast.showText(
          text: '${response['errors'][0]['message']}',
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      } else {
        BotToast.showText(
          text: TKeys.storyDelete.translate(context),
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      }
    });
  }

  Future blockUser({
    required BuildContext context,
    required int userId,
  }) async {
    String authToken = await getAuthToken();
    changeAuthToken(authToken: authToken);
    Uri uri = Uri.tryParse(ApiNetwork.blockUser)!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider.returnConnection().post(
      uri,
      body: json.encode({
        'Id': userId,
        'Reason': '',
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    ).catchError(
      (err) {
        throw err;
      },
    ).then((value) {
      var response = json.decode(value.body);
      if (response['errors'] != null && response['errors'].isNotEmpty) {
        BotToast.showText(
          text: '${response['errors'][0]['message']}',
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      } else {
        BotToast.showText(
          text: TKeys.userBlcoked.translate(context),
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      }
    });
  }

  Future reportUser({
    required BuildContext context,
    required int userId,
  }) async {
    String authToken = await getAuthToken();
    changeAuthToken(authToken: authToken);
    Uri uri = Uri.tryParse(ApiNetwork.reportUser)!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider.returnConnection().post(
      uri,
      body: json.encode({
        'Id': userId,
        'Reason': '',
      }),
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    ).catchError(
      (err) {
        throw err;
      },
    ).then((value) {
      var response = json.decode(value.body);
      if (response['errors'] != null && response['errors'].isNotEmpty) {
        BotToast.showText(
          text: 'You have already reported this user',
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      } else {
        BotToast.showText(
          text: TKeys.userReport.translate(context),
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      }
    });
  }

  Future followUser({
    required BuildContext context,
    required int userId,
  }) async {
    String authToken = await getAuthToken();
    changeAuthToken(authToken: authToken);
    Uri uri = Uri.tryParse('${ApiNetwork.followUser}$userId/tail')!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider.returnConnection().post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    ).catchError(
      (err) {
        throw err;
      },
    ).then((value) {
      var response = json.decode(value.body);
      if (response['errors'] != null && response['errors'].isNotEmpty) {
        BotToast.showText(
          text: '${response['errors'][0]['message']}',
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      } else {
        BotToast.showText(
          text: TKeys.userFollow.translate(context),
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      }
    });
  }

  Future unfollowUser({
    required BuildContext context,
    required int userId,
  }) async {
    String authToken = await getAuthToken();
    changeAuthToken(authToken: authToken);
    Uri uri = Uri.tryParse('${ApiNetwork.unfollowUser}$userId/tail')!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider.returnConnection().delete(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    ).catchError(
      (err) {
        throw err;
      },
    ).then((value) {
      var response = json.decode(value.body);
      if (response['errors'] != null && response['errors'].isNotEmpty) {
        BotToast.showText(
          text: '${response['errors'][0]['message']}',
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      } else {
        BotToast.showText(
          text: TKeys.unFollowUser.translate(context),
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      }
    });
  }

  Future unBlockUser({
    required BuildContext context,
    required int userId,
  }) async {
    String authToken = await getAuthToken();
    changeAuthToken(authToken: authToken);
    Uri uri = Uri.tryParse(
      ApiNetwork.blockUser,
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider.returnConnection().post(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    ).catchError(
      (err) {
        throw err;
      },
    ).then((value) {
      var response = json.decode(value.body);
      if (response['errors'] != null && response['errors'].isNotEmpty) {
        BotToast.showText(
          text: '${response['errors'][0]['message']}',
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      } else {
        BotToast.showText(
          text: TKeys.unBlock.translate(context),
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      }
    });
  }

  List<UserInfo>? followingUsers;
  changeFollowingUsers(List<UserInfo>? followingUsers) {
    this.followingUsers = followingUsers;
    notifyListeners();
  }

  Future getFollowingUsers({
    required BuildContext context,
  }) async {
    String authToken = await getAuthToken();
    changeAuthToken(authToken: authToken);
    Uri uri = Uri.tryParse(
      ApiNetwork.getFollowingUsers,
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider.returnConnection().get(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    ).catchError(
      (err) {
        throw err;
      },
    ).then((value) {
      var response = json.decode(value.body);
      if (response['errors'] != null && response['errors'].isNotEmpty) {
        BotToast.showText(
          text: '${response['errors'][0]['message']}',
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      } else {
        List<UserInfo> followingUsers = [];
        for (var user in response['payload']) {
          followingUsers.add(UserInfo.fromMap(user));
        }
        changeFollowingUsers(followingUsers);
      }
    });
  }

  List<UserInfo>? followers;
  changeFollowers(List<UserInfo>? followers) {
    this.followers = followers;
    notifyListeners();
  }

  Future getFollowers({
    required BuildContext context,
  }) async {
    String authToken = await getAuthToken();
    changeAuthToken(authToken: authToken);
    Uri uri = Uri.tryParse(
      ApiNetwork.getFollowers,
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider.returnConnection().get(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    ).catchError(
      (err) {
        throw err;
      },
    ).then(
      (value) {
        var response = json.decode(value.body);
        if (response['errors'] != null && response['errors'].isNotEmpty) {
          BotToast.showText(
            text: '${response['errors'][0]['message']}',
            contentColor: Constants.blueColor,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
          );
        } else {
          List<UserInfo> followers = [];
          for (var user in response['payload']) {
            followers.add(UserInfo.fromMap(user));
          }
          changeFollowers(followers);
        }
      },
    );
  }

  List<UserInfo>? blockedUsers;
  changeBlockedUsers(List<UserInfo>? blockedUsers) {
    this.blockedUsers = blockedUsers;
    notifyListeners();
  }

  Future getBlockedUsers({
    required BuildContext context,
  }) async {
    String authToken = await getAuthToken();
    changeAuthToken(authToken: authToken);
    Uri uri = Uri.tryParse(
      ApiNetwork.getBlockedUsers,
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider.returnConnection().get(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    ).catchError(
      (err) {
        throw err;
      },
    ).then((value) {
      var response = json.decode(value.body);
      if (response['errors'] != null && response['errors'].isNotEmpty) {
        BotToast.showText(
          text: '${response['errors'][0]['message']}',
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      } else {
        List<UserInfo> blockedUsers = [];
        for (var user in response['payload']) {
          blockedUsers.add(UserInfo.fromMap(user));
        }
        changeBlockedUsers(blockedUsers);
      }
    });
  }

  List<UserInfo>? hiddenUsers;
  changeHiddenUsers(List<UserInfo>? hiddenUsers) {
    this.hiddenUsers = hiddenUsers;
    notifyListeners();
  }

  Future getHiddenUsers({
    required BuildContext context,
  }) async {
    String authToken = await getAuthToken();
    changeAuthToken(authToken: authToken);
    Uri uri = Uri.tryParse(
      ApiNetwork.getHiddenUsers,
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider.returnConnection().get(
      uri,
      headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $authToken',
      },
    ).catchError(
      (err) {
        throw err;
      },
    ).then((value) {
      var response = json.decode(value.body);
      if (response['errors'] != null && response['errors'].isNotEmpty) {
        BotToast.showText(
          text: '${response['errors'][0]['message']}',
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      } else {
        List<UserInfo> hiddenUsers = [];
        for (var user in response['payload']) {
          hiddenUsers.add(UserInfo.fromMap(user));
        }
        changeHiddenUsers(hiddenUsers);
      }
    });
  }

  List<NotificationModel>? notifications;
  changeNotifications(List<NotificationModel>? notifications) {
    this.notifications = notifications;
    notifyListeners();
  }

  int? unReadNotificationCount;
  changeNotificationsCount(int notificationsCount) {
    unReadNotificationCount = notificationsCount;
    notifyListeners();
  }

  Future getNotifications({
    required BuildContext context,
    int pageNumber = 0,
  }) async {
    // await connection.invoke('SendMessage', args: ['Bob', 'Says hi!']);

    Uri uri = Uri.tryParse(
      ApiNetwork.getNotification + pageNumber.toString(),
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider
        .returnConnection()
        .get(
          uri,
          headers: Constants.authenticatedHeaders(
              context: context, userToken: box.read('userTokenForAuth')),
        )
        .then(
      (value) {
        Logger.w(value.body);
        pageNumber == 0 ? notifications = [] : null;
        notifications ??= [];
        pageNumber == 0 ? unReadNotificationCount = 0 : null;
        var response = json.decode(value.body);
        changeNotificationsCount(response['payload']['unread_notifs_no']);
        if (response['payload']['notifs_on_this_page'] != null &&
            response['payload']['notifs_on_this_page']!.isNotEmpty) {
          response['payload']['notifs_on_this_page'].forEach(
            (e) {
              notifications!.add(NotificationModel.fromMap(e));
            },
          );
        }
        changeNotifications(notifications);
      },
    );
    return null;
  }
}
