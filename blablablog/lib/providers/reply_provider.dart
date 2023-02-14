import 'dart:convert';
import 'dart:developer' as log;

import 'package:blabloglucy/domain/story/replies/reply_modal.dart';
import 'package:blabloglucy/domain/story/replies/reply_modal.dart';
import 'package:blabloglucy/domain/story/replies/reply_modal.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:blabloglucy/domain/story/comments/comment_model.dart';
import 'package:blabloglucy/domain/story/story_model.dart';
import 'package:blabloglucy/post_background_image_controller.dart';
import 'package:blabloglucy/providers/user_provider.dart';
import 'package:blabloglucy/providers/widget_provider.dart';
import 'package:blabloglucy/utills/api_network.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/utills/utils.dart';
import 'package:http/http.dart' as http;


class ReplyProvider with ChangeNotifier {
  List<ReplyModal>? repliesOnComment;
  bool isAllRepliesLoaded = false;

  Future<List<ReplyModal>?> getRepliesOnComment(
      {required BuildContext context,
        int? commentId,
        int? pageNumber = 0,
        String? authTOKEN}) async {
    Uri uri = Uri.tryParse(
      '${ApiNetwork.getRepliesOnComment}/$commentId?page=0&limit=100',
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    pageNumber == 0 ? repliesOnComment = [] : repliesOnComment ??= [];

    await widgetProvider
        .returnConnection()
        .get(
      uri,
      headers: Constants.authenticatedHeaders(
          context: context, userToken: authTOKEN),
    )
        .catchError(
          (err) {
            BotToast.showText(
              text: err.toString(),
              contentColor: Constants.blueColor,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
            );
        throw err;
      },
    ).then(
          (value) {
        if (value.body.isNotEmpty) {
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
            for (int i = 0; i < response['payload'].length; i++) {
              repliesOnComment!
                  .add(ReplyModal.fromMap(response['payload'][i]));
            }

            Logger.w(response['payload'].length);

            if (response['payload'].length == 0 ||
                response['payload'].length < 9) {
              isAllRepliesLoaded = true;
            } else {
              isAllRepliesLoaded = false;
            }
            for (int i = 0; i < repliesOnComment!.length; i++) {
              repliesOnComment![i].showInput = false;
            }
            changeSingleCommentReplies(
                repliesOnComment: repliesOnComment!);
          }
        }
      },
    );
    return repliesOnComment;
  }

  changeSingleCommentReplies({required List<ReplyModal> repliesOnComment}) {
    this.repliesOnComment = repliesOnComment;
    notifyListeners();
  }

  Future<String> postReplyOnComment (
      {
        required BuildContext context,
        String? authTOKEN,
        String? publishDate = "",
        String? body,
        int? commentId,
        int? storyId,
        int? userId,
        String? language,
        bool? isPendingApproval,
        bool? isDeniedApproval,
      }) async {
    String retStr = 'No return value to show';
    Uri uri = Uri.tryParse(
      '${ApiNetwork.getRepliesOnComment}/',
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(context, listen: false);

    await widgetProvider
        .returnConnection()
        .post(
      uri,
      // headers: Constants.authenticatedHeaders(
      //     context: context, userToken: authTOKEN),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authTOKEN',
        'Accept': '*/*',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br'
      },
      body: json.encode({
          "publishDate": publishDate,
          "body": body,
          "commentId": commentId,
          "storyId": storyId,
          "userId": userId,
          "language": language,
          "isPendingApproval": isPendingApproval,
          "isDeniedApproval": isDeniedApproval
      }),
    )
    .catchError((err){
      BotToast.showText(
        text: err.toString(),
        contentColor: Constants.blueColor,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      );
      throw err;
    })
    .then((value) {
      if (value.body.isNotEmpty) {
        var response = json.decode(value.body);
        retStr = response.toString();
        if (response['errors'] != null && response['errors'].isNotEmpty) {
          BotToast.showText(
            text: response['errors'][0]['message'],
            contentColor: Colors.red,
            textStyle: const TextStyle(
              color: Colors.white,
              fontSize: 12,
            ),
            duration: Duration(seconds: 5)
          );
        } else {
          if(response['success']) {
            BotToast.showText(
                text: "Successfully posted",
                contentColor: Constants.blueColor,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                duration: Duration(seconds: 3)
            );
          }
        }
      }
    });
    return retStr;
  }

  Future<String> likeComment (
      {
        required BuildContext context,
        String? authTOKEN,
        int? commentId,
        int? userId,
      }) async {
    String retStr = 'No return value to show';
    Uri uri = Uri.tryParse(
      '${ApiNetwork.likeComment}/',
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(context, listen: false);

    await widgetProvider
        .returnConnection()
        .put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authTOKEN',
        'Accept': '*/*',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br'
      },
      body: json.encode({
        "commentId": commentId,
        "userId": userId,
      }),
    )
        .catchError((err){
      BotToast.showText(
        text: err.toString(),
        contentColor: Constants.blueColor,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      );
      throw err;
    })
        .then((value) {
      if (value.body.isNotEmpty) {
        var response = json.decode(value.body);
        retStr = response.toString();
        if (response['errors'] != null && response['errors'].isNotEmpty) {
          BotToast.showText(
              text: response['errors'][0]['message'],
              contentColor: Colors.red,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              duration: Duration(seconds: 5)
          );
        } else {
          if(response['success']) {
            BotToast.showText(
                text: "You like this comment",
                contentColor: Constants.blueColor,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                duration: Duration(seconds: 3)
            );
          }
        }
      }
    });
    return retStr;
  }

  Future<String> unLikeComment (
      {
        required BuildContext context,
        String? authTOKEN,
        int? commentId,
        int? userId,
      }) async {
    String retStr = 'No return value to show';
    Uri uri = Uri.tryParse(
      '${ApiNetwork.unLikeComment}/',
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(context, listen: false);

    await widgetProvider
        .returnConnection()
        .put(
      uri,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $authTOKEN',
        'Accept': '*/*',
        'Connection': 'keep-alive',
        'Accept-Encoding': 'gzip, deflate, br'
      },
      body: json.encode({
        "commentId": commentId,
        "userId": userId,
      }),
    )
        .catchError((err){
      BotToast.showText(
        text: err.toString(),
        contentColor: Constants.blueColor,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      );
      throw err;
    })
        .then((value) {
      if (value.body.isNotEmpty) {
        var response = json.decode(value.body);
        retStr = response.toString();
        if (response['errors'] != null && response['errors'].isNotEmpty) {
          BotToast.showText(
              text: response['errors'][0]['message'],
              contentColor: Colors.red,
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 12,
              ),
              duration: Duration(seconds: 5)
          );
        } else {
          if(response['success']) {
            BotToast.showText(
                text: "You like this comment",
                contentColor: Constants.blueColor,
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
                duration: Duration(seconds: 3)
            );
          }
        }
      }
    });
    return retStr;
  }
}