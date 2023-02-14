import 'dart:convert';

import 'package:bot_toast/bot_toast.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/domain/auth/models/user_info.dart';
import 'package:blabloglucy/domain/story/story_model.dart';
import 'package:blabloglucy/post_background_image_controller.dart';
import 'package:blabloglucy/providers/widget_provider.dart';
import 'package:blabloglucy/utills/api_network.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/widgets/story_card.dart';

// ignore: must_be_immutable
class MyPendingStories extends StatefulWidget {
  UserInfo? userInfo;
  MyPendingStories({Key? key, this.userInfo}) : super(key: key);

  @override
  State<MyPendingStories> createState() => _MyPendingStoriesState();
}

class _MyPendingStoriesState extends State<MyPendingStories> {
  List<StoryModel>? myPendingStories;
  bool isLoaded = false;
  int index = 0;
  int pageNumber = 0;
  int imageIndex = 0;
  bool hideBottomLoader = false;

  final ScrollController _scrollController = ScrollController();

  List<String> consultImages = [
    'assets/images/consult/1.png',
    'assets/images/consult/2.png',
    'assets/images/consult/3.png',
    'assets/images/consult/4.png',
    'assets/images/consult/5.png',
    'assets/images/consult/6.png',
    'assets/images/consult/7.png',
    'assets/images/consult/8.png',
  ];

  List<String> consultGroupNames = [
    'startup',
    'food',
    'motherhood',
    'divorced',
    'lgbt',
    'mankind',
    'discrimination',
    'Vegan',
  ];
  List<String> categories = [];

  @override
  void initState() {
    super.initState();
    getMyPending();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          pageNumber++;
        });

        getMyPending();
        // _storyProvider.getStoriesbyGroup(context: context, pageNo: '1');
      }
    });
  }

  getMyPending() async {
    var box = GetStorage();
    Logger.e(box.read('userTokenForAuth'));
    Uri uri = Uri.tryParse(
      '${ApiNetwork.getStories}?Me=1&status=0&page=$pageNumber',
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
        Logger.w(response['payload']);
        response['payload'].forEach(
          (element) {
            myPendingStories!.add(StoryModel.fromMap(element));

            if (element['story']['title'] == null ||
                element['story']['title'] == '') {
              myPendingStories![index].category = element['story']['category'];
            } else {
              myPendingStories![index].category = '1';
            }
            if (element['story']['title'] == null ||
                element['story']['title'] == '') {
              Logger.w(element['story']['category']);
              int categoryIndex =
                  consultGroupNames.indexOf(element['story']['category']);
              Logger.i(categoryIndex);
              myPendingStories![index].image = consultImages[categoryIndex];
            } else {
              myPendingStories![index].image =
                  PostBackgroundImageController.bgImages[imageIndex];
              String title = myPendingStories![index].story.title;
              if (consultGroupNames.contains(title)) {
                List<String> translatedName = [
                  TKeys.Relationship_text.translate(context),
                  TKeys.Women_talk_text.translate(context),
                  TKeys.Motherhood_text.translate(context),
                  TKeys.Divorced_text.translate(context),
                  TKeys.Lgbt_text.translate(context),
                  TKeys.Our_planet_text.translate(context),
                  TKeys.Discrimination_text.translate(context),
                  TKeys.Vegan_text.translate(context),
                ];
                int whichIndex = consultGroupNames.indexOf(title);
                myPendingStories![index].story.title =
                    translatedName[whichIndex];
              }
            }
            index++;
            if (imageIndex ==
                PostBackgroundImageController.bgImages.length - 1) {
              imageIndex = -1;
            }
            imageIndex++;
          },
        );
        // Logger.w(myPendingStories![0].category);

        if (pageNumber >= 0 && response['payload'].length == 0 ||
            response['payload'].length < 8) {
          Logger.i(response['payload']);
          hideBottomLoader = true;
        }

        setState(() {
          isLoaded = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    Logger.e(isLoaded);
    return myPendingStories == null && isLoaded == false
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: const [
              Center(
                child: SpinKitFadingFour(
                  size: 60,
                  color: Color(0xff52527a),
                ),
              ),
            ],
          )
        : Column(
            children: [
              myPendingStories!.isEmpty
                  ? Expanded(
                      child: Center(
                      child: Text(TKeys.NoNewPendingPosts.translate(context)),
                    ))
                  : Expanded(
                      child: ListView.builder(
                      shrinkWrap: true,
                      controller: _scrollController,
                      itemCount: myPendingStories!.length + 1,
                      itemBuilder: (context, index) {
                        // print(_storyProvider.consultImage!);
                        if (index < myPendingStories!.length) {
                          return StoryCard(
                            img: myPendingStories![index].image!,
                            // img: _storyProvider.consultImage!,
                            story: myPendingStories![index],
                            route: 'myPendingStories',
                            userInfo: widget.userInfo,
                          );
                        } else {
                          return hideBottomLoader
                              ? Container()
                              : const Center(
                                  child: SpinKitFadingFour(
                                    size: 40,
                                    color: Color(0xff52527a),
                                  ),
                                );
                        }
                      },
                    ))
            ],
          );
  }
}
