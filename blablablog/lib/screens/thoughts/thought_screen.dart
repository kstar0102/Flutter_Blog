import 'dart:convert';
import 'dart:developer' as d;

import 'package:bot_toast/bot_toast.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart' as provider;
import 'package:blabloglucy/Localization/localization_service.dart';
import 'package:blabloglucy/domain/story/story_model.dart';
import 'package:blabloglucy/post_background_image_controller.dart';
import 'package:blabloglucy/providers/widget_provider.dart';
import 'package:blabloglucy/screens/thoughts/components/story_card.dart';
import 'package:blabloglucy/screens/thoughts/create_thought_post/create_thought_post.dart';
import 'package:blabloglucy/utills/api_network.dart';
import 'package:blabloglucy/utills/constant.dart';

class ThoughtsScreen extends StatefulWidget {
  const ThoughtsScreen({Key? key}) : super(key: key);
  @override
  State<ThoughtsScreen> createState() => _ThoughtsScreenState();
}

class _ThoughtsScreenState extends State<ThoughtsScreen> {
  ScrollController? _scrollController;
  int pageNumber = 0;
  String? lang;
  int imageIndex = 0;
  int index = 0;
  List<StoryModel> userStories = [];
  bool hideBottomLoader = false;
  final localizationController = Get.find<LocalizationController>();

  bool isLoadedAll = false;

  int randomNumber = 0;
  final box = GetStorage();
  @override
  void initState() {
    debugPrint('fss=====================================');
    // bgImages.forEach((element) {
    //   listRandom.add(Random().nextInt(bgImages.length));
    // });

    _scrollController = ScrollController();
    getThoughts();
    _scrollController!.addListener(() {
      if (_scrollController!.position.pixels ==
          _scrollController!.position.maxScrollExtent) {
        setState(() {
          pageNumber++;
        });
        getThoughts();
      }
    });

    super.initState();
  }

  getThoughts() async {
    Uri uri = Uri.tryParse(
      '${ApiNetwork.getStories}?page=$pageNumber',
    )!;
    WidgetProvider localWidgetProvider = provider.Provider.of<WidgetProvider>(
      context,
      listen: false,
    );
    pageNumber == 0 ? userStories = [] : userStories;
    if (pageNumber == 0) {
      index = 0;
      imageIndex = 0;
    }
    await localWidgetProvider
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
            userStories.add(StoryModel.fromMap(e));
            userStories[index].image =
                PostBackgroundImageController.bgImages[imageIndex];
            index++;
            if (imageIndex ==
                PostBackgroundImageController.bgImages.length - 1) {
              imageIndex = -1;
            }
            imageIndex++;
          });

          if (pageNumber >= 0 && response['payload'].length == 0 ||
              response['payload'].length < 8) {
            Logger.i(response['payload']);
            hideBottomLoader = true;
          }
          setState(() {
            isLoadedAll = true;
          });
          // changeUserStories(userStories: userStories!);
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    d.log('isLoaded: $isLoadedAll');
    lang = box.read('lang');
    return Scaffold(
      body: isLoadedAll == false && userStories.isEmpty
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
                SizedBox(
                  height: 50,
                ),
              ],
            )
          : Column(
              children: [
                Flexible(
                  child: ListView.builder(
                    controller: _scrollController,
                    itemCount: userStories.length + 1,
                    itemBuilder: (context, index) {
                      if (index < userStories.length) {
                        // Logger.e(userStories[index].likedByMe);
                        return StoryCard(
                          image: userStories[index].image!,
                          item: userStories[index].image!,
                          story: userStories[index],
                          route: 'thoughtScreen',
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
                  ),
                ),
              ],
            ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xff19334D),
        onPressed: () {
          //  print(box.read('lang'));
          //
          // setState(() {
          //   (box.read('lang')) == 'en' ? box.write('lang', 'he') : box.write('lang', 'en');
          // });
          //  print(box.read('lang'));
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (builder) => CreateThoughtPostScreen(),
            ),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
    );
  }
}
