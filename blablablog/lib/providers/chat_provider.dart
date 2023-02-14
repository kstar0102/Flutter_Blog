import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/models/chat.dart';
import 'package:blabloglucy/providers/widget_provider.dart';
import 'package:blabloglucy/utills/api_network.dart';
import 'package:blabloglucy/utills/constant.dart';

class ChatProvider with ChangeNotifier {
  List<UserChat>? userChats;
  var box = GetStorage();
  changeUserChats({required List<UserChat> userChats}) {
    this.userChats = userChats;
    notifyListeners();
  }

  Future getUserChatList({required BuildContext context}) async {
    Uri uri = Uri.tryParse(ApiNetwork.inbox)!;
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
        .catchError(
      (err) {
        throw err;
      },
    ).then((value) {
      userChats = [];
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
        userChats ??= [];
        response['payload']['userMessages'].forEach(
          (element) {
            userChats!.add(UserChat.fromMap(element));
          },
        );
        changeUserChats(userChats: userChats!);
      }
    });
  }

  Future deleteSingleChat({
    required BuildContext context,
    required String chatId,
  }) async {
    Uri uri = Uri.tryParse(ApiNetwork.deleteConversation + chatId)!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    await widgetProvider
        .returnConnection()
        .delete(
          uri,
          headers: Constants.authenticatedHeaders(
              context: context, userToken: box.read('userTokenForAuth')),
        )
        .catchError(
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
          text: TKeys.chatDelete.translate(context),
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
      }
    });
  }
}
