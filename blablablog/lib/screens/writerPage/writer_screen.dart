import 'dart:async';

import 'package:avatar_view/avatar_view.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart' as provider;
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/domain/story/story_model.dart';
import 'package:blabloglucy/providers/story_provider.dart';
import 'package:blabloglucy/screens/thoughts/components/story_card.dart';
import 'package:blabloglucy/utills/constant.dart';

class WriterScreen extends StatefulWidget {
  final String item;
  final String image;
  final StoryModel story;
  const WriterScreen(
      {Key? key, required this.item, required this.image, required this.story})
      : super(key: key);

  @override
  State<WriterScreen> createState() => _WriterScreenState();
}

class _WriterScreenState extends State<WriterScreen> {
  ScrollController? _scrollController;
  int pageNo = 0;
  String? lang;
  bool isLoadedAll = false;
  @override
  void initState() {
    debugPrint('fss=====================================');
    // bgImages.forEach((element) {
    //   listRandom.add(Random().nextInt(bgImages.length));
    // });
    Timer(
        const Duration(seconds: 5),
        () => setState(() {
              isLoadedAll = true;
            }));
    _scrollController = ScrollController();

    StoryProvider localStoryProvider =
        provider.Provider.of<StoryProvider>(context, listen: false);
    localStoryProvider.getStories(context: context, pageNumber: pageNo);
    _scrollController!.addListener(() {
      if (_scrollController!.position.pixels ==
          _scrollController!.position.maxScrollExtent) {
        setState(() {
          pageNo++;
        });
        localStoryProvider.getStories(context: context, pageNumber: pageNo);
        // localStoryProvider.getStoriesbyGroup(context: context, pageNo: '1');
      }
    });

    super.initState();
  }

  List<String> bgImages = [
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

  @override
  Widget build(BuildContext context) {
    StoryProvider localStoryProvider =
        provider.Provider.of<StoryProvider>(context);
    debugPrint('===================================');
    Logger.e(widget.story.userNick);

    List<StoryModel> modal = [
      ...localStoryProvider.userStories!
          .where((element) => element.userId == widget.story.userId)
    ];
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          '${widget.story.userNick} - ${TKeys.all_thoughts.translate(context)}',
          style: GoogleFonts.montserrat(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: const Color(0xff19334D),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Color(0xff19334D),
            )),
      ),
      body: SafeArea(
        child: localStoryProvider.userStories == null ||
                localStoryProvider.userStories!.isEmpty
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
                      itemCount: modal.length + 1,
                      itemBuilder: (context, index) {
                        if (index < modal.length) {
                          return StoryCard(
                            image: modal[index].image!,
                            item: modal[index].image!,
                            story: modal[index],
                            route: 'thoughtScreen',
                          );
                        } else {
                          return const Center(
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
    );
  }

  Widget toolbar(BuildContext context) {
    return Stack(
      children: [
        Column(
          children: [
            Stack(
              children: [
                SizedBox(
                    height: 110,
                    width: MediaQuery.of(context).size.width,
                    child: Image.asset(
                      'assets/images/background.jpg',
                      fit: BoxFit.fitWidth,
                    )),
                Container(
                  height: 110,
                  decoration: const BoxDecoration(color: Color(0x4BC2C2C2)),
                ),
              ],
            ),
            Container(
              height: 30,
              color: Colors.white,
            ),
          ],
        ),
        Positioned(
          bottom: 0,
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsetsDirectional.only(start: 20),
                child: AvatarView(
                  radius: 40,
                  avatarType: AvatarType.CIRCLE,
                  imagePath: 'assets/images/user_profile2.png',
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(bottom: 20.0),
                child: Text(
                  'Nick name',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: Constants.fontFamilyName,
                  ),
                ),
              ),
            ],
          ),
        ),
        Row(
          children: [
            InkWell(
              onTap: () => Navigator.pop(context),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 27,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
