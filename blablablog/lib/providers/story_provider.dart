import 'dart:convert';
import 'dart:developer' as log;

import 'package:bot_toast/bot_toast.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
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

class StoryProvider with ChangeNotifier {
  List<StoryModel>? userStories;
  bool showLoading = false;
  int index = 0;
  int imageIndex = 0;
  bool isLoaded = false;
  bool isLoadedForConsult = false;
  bool isAllConsultPostLoaded = false;
  bool isAllCommentsLoaded = false;
  bool isConsultPost = false;
  List<String> bgImages1 = [
    'assets/images/PostBackground/1.png',
    'assets/images/PostBackground/2.png',
    'assets/images/PostBackground/3.png',
    'assets/images/PostBackground/4.png',
    'assets/images/PostBackground/5.png',
    'assets/images/PostBackground/6.png',
    'assets/images/PostBackground/7.png',
    'assets/images/PostBackground/8.png',
    'assets/images/PostBackground/9.png',
    'assets/images/PostBackground/10.png',
    'assets/images/PostBackground/11.png',
    'assets/images/PostBackground/12.png',
    'assets/images/PostBackground/13.png',
    'assets/images/PostBackground/14.png',
    'assets/images/PostBackground/15.png',
    'assets/images/PostBackground/16.png',
    'assets/images/PostBackground/17.png',
    'assets/images/PostBackground/18.png',
  ];

  var box = GetStorage();

  changeConsultValue({required bool value}) {
    isConsultPost = value;
    notifyListeners();
  }

  changeUserStories({required List<StoryModel> userStories}) {
    this.userStories = userStories;

    notifyListeners();

    return this.userStories;
  }

  List<String> consultImage = bgImages;
  changeConsultImage({required List<String> image}) {
    consultImage = image;
    notifyListeners();
  }

  Future<List<StoryModel>> getStories({
    required BuildContext context,
    int? pageNumber = 0,
  }) async {
    Uri uri = Uri.tryParse(
      '${ApiNetwork.getStories}?page=$pageNumber',
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    pageNumber == 0 ? userStories = [] : userStories ??= [];
    if (pageNumber == 0) {
      index = 0;
      imageIndex = 0;
    }
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
    ).then(
      (value) {
        // if(value != null)

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
          Logger.w(
              '$pageNumber  ${response['payload'].length} =====================================');
          response['payload'].forEach((e) {
            userStories!.add(StoryModel.fromMap(e));
            userStories![index].image =
                PostBackgroundImageController.bgImages[imageIndex];
            index++;
            if (imageIndex ==
                PostBackgroundImageController.bgImages.length - 1) {
              imageIndex = -1;
            }
            imageIndex++;
          });

          // changeUserStories(userStories: userStories!);
        }
      },
    );
    return userStories!;
  }

  List<CommentModel>? singleStoryComments;
  changeSingleStoryComments({required List<CommentModel> singleStoryComments}) {
    this.singleStoryComments = singleStoryComments;
    notifyListeners();
  }

  Future<List<CommentModel>?> getSingleStoryComments(
      {required BuildContext context,
      int? storyId,
      int? pageNumber,
      String? authTOKEN}) async {
    Uri uri = Uri.tryParse(
      '${ApiNetwork.getComments}$storyId?page=$pageNumber&limit=10',
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(

      context,
      listen: false,
    );
    pageNumber == 0 ? singleStoryComments = [] : singleStoryComments ??= [];

    await widgetProvider
        .returnConnection()
        .get(
          uri,
          headers: Constants.authenticatedHeaders(
              context: context, userToken: authTOKEN),
        )
        .catchError(
      (err) {
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
              singleStoryComments!
                  .add(CommentModel.fromMap(response['payload'][i]));
            }

            Logger.w(response['payload'].length);

            if (response['payload'].length == 0 ||
                response['payload'].length < 9) {
              isAllCommentsLoaded = true;
            } else {
              isAllCommentsLoaded = false;
            }
            for (int i = 0; i < singleStoryComments!.length; i++) {
              singleStoryComments![i].showInput = false;
            }
            changeSingleStoryComments(
                singleStoryComments: singleStoryComments!);
          }
        }
      },
    );
    return singleStoryComments;
  }

  Map<String, List<StoryModel>>? storiesByGroups;
  changeStoriesByGroups(
      {required Map<String, List<StoryModel>> storiesByGroups}) {
    this.storiesByGroups = storiesByGroups;
    notifyListeners();
  }

  Future getStoriesbyGroup({
    required BuildContext context,
    String? pageNo = '0',
    String? pageSize,
    String? groupName,
  }) async {
    Uri uri = Uri.tryParse(
      '${ApiNetwork.getStoriesByTopic}${groupName!}&page=${pageNo!}',
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );

    storiesByGroups ??= {};

    pageNo == '0' ? storiesByGroups![groupName] = [] : null;
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
        storiesByGroups ??= {};
        storiesByGroups![groupName] ??= [];
        Logger.e(response['payload']);
        if (response['payload'].length == 0) {
          isLoadedForConsult = true;
        }
        response['payload'].forEach(
          (element) {
            storiesByGroups![groupName]!.add(StoryModel.fromMap(element));
          },
        );

        if (response['payload'].length == 0) {
          isAllConsultPostLoaded = true;
        } else {
          isAllConsultPostLoaded = false;
        }
        changeStoriesByGroups(storiesByGroups: storiesByGroups!);
      }
    });
  }

  List<StoryModel>? myPublishedStories;

  changeMyPublishedStories({required List<StoryModel> myPublishedStories}) {
    isLoaded = true;
    this.myPublishedStories = myPublishedStories;
    notifyListeners();
  }

  Future getMyPublishedStories({required BuildContext context}) async {
    Uri uri = Uri.tryParse(ApiNetwork.getMyPublishedStories)!;
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
        myPublishedStories ??= [];
        response['payload'].forEach(
          (element) {
            myPublishedStories!.add(StoryModel.fromMap(element));
          },
        );
        changeMyPublishedStories(myPublishedStories: myPublishedStories!);
      }
    });
  }

  List<StoryModel>? myDraftStories;
  changeMyDraftStories({required List<StoryModel> myDraftStories}) {
    this.myDraftStories = myDraftStories;
    notifyListeners();
  }

  Future getMyDraftStories({required BuildContext context}) async {
    Uri uri = Uri.tryParse(ApiNetwork.getMyDraftStories)!;
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
        myDraftStories ??= [];
        response['payload'].forEach(
          (element) {
            myDraftStories!.add(StoryModel.fromMap(element));
          },
        );
        changeMyDraftStories(myDraftStories: myDraftStories!);
      }
    });
  }

  List<StoryModel>? myPendingStories;
  changeMyPendingStories({required List<StoryModel> myPendingStories}) {
    this.myPendingStories = myPendingStories;
    notifyListeners();
  }

  Future getMyPendingStories({required BuildContext context}) async {
    Uri uri = Uri.tryParse(ApiNetwork.getMyPendingStories)!;
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
        myPendingStories ??= [];
        response['payload'].forEach(
          (element) {
            myPendingStories!.add(StoryModel.fromMap(element));
          },
        );
        changeMyPendingStories(myPendingStories: myPendingStories!);
      }
    });
  }

  List<StoryModel>? myDeclinedStories;
  changeMyRejectedStories({required List<StoryModel> myRejectedStories}) {
    myDeclinedStories = myRejectedStories;
    notifyListeners();
  }

  Future getMyRejectedStories({required BuildContext context}) async {
    Uri uri = Uri.tryParse(ApiNetwork.getMyDeclinedStories)!;
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
        myDeclinedStories ??= [];
        response['payload'].forEach(
          (element) {
            myDeclinedStories!.add(StoryModel.fromMap(element));
          },
        );
        changeMyRejectedStories(myRejectedStories: myDeclinedStories!);
      }
    });
  }

  Future deleteMyStory(
      {required BuildContext context, required StoryModel story}) async {
    Uri uri = Uri.tryParse(ApiNetwork.deleteStory)!;
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
          body: json.encode(
            {
              'story_id': '2389',
            },
          ),
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
          text: 'Story deleted successfully',
          contentColor: Constants.blueColor,
          textStyle: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
        getMyPublishedStories(context: context);
        getMyDraftStories(context: context);
        getMyPendingStories(context: context);
        getMyRejectedStories(context: context);
      }
    });
  }

  Future disableComments(
      {required BuildContext context, required StoryModel story}) async {
    Uri uri = Uri.tryParse(
      '${ApiNetwork.toggleComments}${story.story.id}/togglecomments',
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );

    await widgetProvider
        .returnConnection()
        .post(
          uri,
          headers: Constants.authenticatedHeaders(
              context: context, userToken: box.read('userTokenForAuth')),
        )
        .catchError(
      (err) {
        throw err;
      },
    ).then((value) {
      // var response = json.decode(value.body);

      BotToast.showText(
        text: 'Comments disabled successfully',
        contentColor: Constants.blueColor,
        textStyle: const TextStyle(
          color: Colors.white,
          fontSize: 12,
        ),
      );
    });
  }

  bool isLoad = false;
  Future createStory(
      {required BuildContext context,
      required String consultGroup,
      required String storyBody,
      required String image,
      String? whichPage,
      int? storyStatus,
      bool? isEditMode}) async {
    Uri uri = Uri.tryParse(ApiNetwork.createStory)!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    image != ''
        ? consultImage.insert(0, image)
        : consultImage.insert(0, Constants.consult2);
    log.log('image: $image');

    if (isEditMode == true) {
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      Logger.e('data is updated $storyStatus');
      await widgetProvider
          .returnConnection()
          .put(
            uri,
            headers: Constants.authenticatedHeaders(
                context: context, userToken: box.read('userTokenForAuth')),
            body: json.encode(
              {
                'Description': 'Some Cool Description',
                'Body': storyBody,
                'Category': whichPage == 'thought' ? null : consultGroup,
                'CategoryRename': consultGroup,
                'consultImage': image,
                'Title': whichPage == 'thought' ? consultGroup : '',
                'SubCategory': null,
                'IsCommentsAlowed': true,
                'StoryStatus': storyStatus,
              },
            ),
          )
          .catchError(
        (err) {
          log.log(err);
          Logger.e(err);
          throw err;
        },
      ).then((value) {
        var response = json.decode(value.body);
        Logger.e(response);
        if (response['errors'] != null && response['errors'].isNotEmpty) {
          Navigator.pop(context);
        } else {
          Navigator.pop(context);

          userProvider.notifications ??= [];
          userProvider.getNotifications(context: context);

          myPendingStories ??= [];
          myPendingStories!.add(
            StoryModel.fromMap(
              response['payload']['model'],
            ),
          );
          userStories!.add(
            StoryModel.fromMap(
              response['payload']['model'],
            ),
          );
          myPublishedStories!.add(
            StoryModel.fromMap(
              response['payload']['model'],
            ),
          );
          changeConsultValue(value: image == '');
        }
      });
    } else {
      UserProvider userProvider =
          Provider.of<UserProvider>(context, listen: false);
      await widgetProvider
          .returnConnection()
          .post(
            uri,
            headers: Constants.authenticatedHeaders(
                context: context, userToken: box.read('userTokenForAuth')),
            body: json.encode(
              {
                'Description': 'Some Cool Description',
                'Body': storyBody,
                'Category': whichPage == 'thought' ? null : consultGroup,
                'CategoryRename': consultGroup,
                'consultImage': image,
                'Title': whichPage == 'thought' ? consultGroup : '',
                'SubCategory': null,
                'IsCommentsAlowed': true,
                'StoryStatus': storyStatus,
              },
            ),
          )
          .catchError(
        (err) {
          Logger.e(err);
          throw err;
        },
      ).then((value) {
        var response = json.decode(value.body);
        Logger.w(response);
        if (response['errors'] != null && response['errors'].isNotEmpty) {
          Navigator.pop(context);
        } else {
          Navigator.pop(context);

          userProvider.notifications ??= [];
          userProvider.getNotifications(context: context);

          myPendingStories ??= [];
          myPendingStories!.add(
            StoryModel.fromMap(
              response['payload']['model'],
            ),
          );
          userStories!.add(
            StoryModel.fromMap(
              response['payload']['model'],
            ),
          );
          myPublishedStories!.add(
            StoryModel.fromMap(
              response['payload']['model'],
            ),
          );
          changeConsultValue(value: image == '');
        }
      });
    }
  }


}
