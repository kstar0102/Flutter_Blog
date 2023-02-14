import 'dart:convert';
import 'dart:math';

import 'package:bot_toast/bot_toast.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';
import 'package:blabloglucy/Localization/localization_service.dart';
import 'package:blabloglucy/domain/story/story_model.dart';
import 'package:blabloglucy/providers/widget_provider.dart';
import 'package:blabloglucy/screens/consult/consult_screen.dart';
import 'package:blabloglucy/screens/consult/create_consult_post.dart';
import 'package:blabloglucy/utills/api_network.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/widgets/story_card_new.dart';

import '../../utills/utils.dart';

class ConsultDetailScreen extends StatefulWidget {
  const ConsultDetailScreen({
    Key? key,
    this.imagePath,
    this.consultName,
    this.builder,
    required this.consultGroupName,
  }) : super(key: key);

  final MyBuilder? builder;
  final String? imagePath;
  final String? consultName;
  final String? consultGroupName;

  @override
  State<ConsultDetailScreen> createState() => _ConsultDetailScreenState();
}

class _ConsultDetailScreenState extends State<ConsultDetailScreen> {
  final localizationController = Get.find<LocalizationController>();
  var list = ['assets/images/bg1.png'];
  var box = GetStorage();
  bool isLoadedForConsult = false;
  List<StoryModel> storiesByGroups = [];

  int pageNumber = 0;
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    // TODO
    // StoryProvider _storyProvider = Provider.of<StoryProvider>(
    //   context,
    //   listen: false,
    // );
    //
    // _storyProvider.getStoriesbyGroup(
    //   context: context,
    //   pageNo: pageNumber.toString(),
    //   groupName: widget.consultGroupName,
    // );
    getStories();

    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        pageNumber++;
        getStories();
      }
    });
    super.initState();
  }

  void getStories() async {
    Uri uri = Uri.tryParse(
      '${ApiNetwork.getStoriesByTopic}${widget.consultGroupName!}&page=$pageNumber',
    )!;
    WidgetProvider widgetProvider = Provider.of<WidgetProvider>(
      context,
      listen: false,
    );

    // pageNumber == '0' ? storiesByGroups = [] : null;
    pageNumber == 0 ? storiesByGroups = [] : storiesByGroups;
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
        Logger.e(response['payload'].length);
        if (response['payload'].length < 7) {
          isLoadedForConsult = true;
        }
        response['payload'].forEach(
          (element) {
            storiesByGroups.add(StoryModel.fromMap(element));
          },
        );

        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO
    // UserProvider _userProvider = Provider.of<UserProvider>(context);
    // StoryProvider _storyProvider = Provider.of<StoryProvider>(context);
    return SafeArea(
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: Column(
              children: [
                SizedBox(
                  height: 108,
                  child: Card(
                    elevation: 0,
                    clipBehavior: Clip.antiAlias,
                    child: Stack(
                      children: [
                        SizedBox(
                            height: 108,
                            width: MediaQuery.of(context).size.width,
                            child: Image.asset(
                              widget.imagePath!,
                              fit: BoxFit.fitWidth,
                            )),
                        Container(
                          decoration:
                              const BoxDecoration(color: Color(0x4B000000)),
                        ),
                        InkWell(
                          onTap: () => widget.builder!.call(context, () {}),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 15),
                            child: Icon(
                              Icons.arrow_back_ios,
                              size: 25,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width,
                                child: Text(
                                  widget.consultName!,
                                  // textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    fontFamily: Constants.fontFamilyName,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                storiesByGroups.isEmpty
                    ? isLoadedForConsult
                        ? Container()
                        : const Expanded(
                            child: Center(
                              child: SpinKitFadingFour(
                                size: 60,
                                color: Color(0xff52527a),
                              ),
                            ),
                          )
                    : Expanded(
                        flex: 1,
                        child: ListView.builder(
                          controller: _scrollController,
                          itemCount: storiesByGroups.length + 1,
                          itemBuilder: (context, i) {
                            if (i < storiesByGroups.length) {
                              return StoryCardNew(
                                img:
                                    bgImages[Random().nextInt(bgImages.length)],
                                story: storiesByGroups[i],
                                route: widget.consultGroupName!,
                              );
                            } else {
                              return isLoadedForConsult
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
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Align(
              alignment: box.read('lang') == 'he'
                  ? Alignment.bottomLeft
                  : Alignment.bottomRight,
              child: FloatingActionButton(
                backgroundColor: const Color(0xff19334D),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (builder) => CreateConsultScreen(
                        image: widget.imagePath!,
                        consultGroupName: widget.consultGroupName!,
                      ),
                    ),
                  );
                },
                child: const Icon(Icons.add),
              ),
            ),
          )
        ],
      ),
    );
  }
}
