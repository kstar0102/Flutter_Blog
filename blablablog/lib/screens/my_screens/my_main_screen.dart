import 'dart:convert';
import 'dart:developer';

import 'package:avatar_view/avatar_view.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:blabloglucy/Localization/localization_service.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/domain/auth/models/user_info.dart';
import 'package:blabloglucy/providers/widget_provider.dart';
import 'package:blabloglucy/screens/comment_screen/comment_screen.dart';
import 'package:blabloglucy/screens/my_screens/my_declined_stories.dart';
import 'package:blabloglucy/screens/my_screens/my_draft_stories.dart';
import 'package:blabloglucy/screens/my_screens/my_pending_stories.dart';
import 'package:blabloglucy/screens/my_screens/my_published_stories.dart';
import 'package:blabloglucy/utills/api_network.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/widgets/custom_user_avatar.dart';

class MyMainScreen extends StatefulWidget {
  const MyMainScreen({Key? key}) : super(key: key);

  @override
  State<MyMainScreen> createState() => _MyMainScreenState();
}

class _MyMainScreenState extends State<MyMainScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  UserInfo? userInfo;
  bool isLoading = true;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    super.initState();
    getUserInfo();
  }

  getUserInfo() async {
    var box = GetStorage();

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
        userInfo = UserInfo.fromMap(response['payload']);
        // changeUserInfo(userInfo: UserInfo.fromMap(response['payload']));
        setState(() {
          isLoading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO
    // UserProvider _userProvider = Provider.of<UserProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: isLoading
              ? const Center(
                  child: SpinKitFadingFour(
                    size: 60,
                    color: Color(0xff52527a),
                  ),
                )
              : Column(
                  children: [
                    SizedBox(
                      height: 120,
                      width: Get.width,
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 100,
                            width: Get.width,
                            child: Image.asset(
                              Constants.consult1,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Container(
                            color: Colors.white.withOpacity(0.2),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: InkWell(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_back_ios,
                                size: 30,
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomLeft,
                            child: Padding(
                              padding: box.read('lang') == 'he'
                                  ? const EdgeInsets.only(right: 40.0, top: 10)
                                  : const EdgeInsets.only(left: 40.0, top: 10),
                              child: Row(
                                children: [
                                  Transform.scale(
                                    scale: 2,
                                    child: CustomUserAvatar(
                                      imageUrl: userInfo!.gender == 'Male'
                                          ? 'assets/icons/male.png'
                                          : 'assets/icons/female.png',
                                      userColor: userInfo!.color,
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 35,
                                  ),
                                  Container(
                                    height: 38,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(10),
                                        boxShadow: const [
                                          BoxShadow(
                                              color: Colors.black12,
                                              offset: Offset(1, 1),
                                              spreadRadius: 0.3)
                                        ]),
                                    child: Center(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Text(
                                          userInfo!.name,
                                          style: GoogleFonts.montserrat(
                                            color: const Color(0xff132952),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Container(child: toolbar()),
                    Container(
                      color: Colors.white,
                      width: Get.width,
                      alignment: Alignment.center,
                      child: TabBar(
                        isScrollable: true,
                        indicator: const BoxDecoration(),
                        labelStyle: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                        // unselectedLabelStyle: TextStyle(fontFamily: 'Family Name',),
                        unselectedLabelStyle: const TextStyle(
                            fontWeight: FontWeight.normal, fontSize: 14),
                        labelColor: const Color(0xff19334D),
                        unselectedLabelColor: const Color(0xff19334D),
                        tabs: [
                          Tab(text: TKeys.published_text.translate(context)),
                          Tab(text: TKeys.drafts_text.translate(context)),
                          Tab(text: TKeys.pending_text.translate(context)),
                          Tab(text: TKeys.declined_text.translate(context)),
                        ],
                        controller: _tabController,
                        // indicatorSize: TabBarIndicatorSize.tab,
                      ),
                    ),
                    Expanded(
                      child: TabBarView(
                        controller: _tabController,
                        children: [
                          MyPublishedStories(
                            userInfo: userInfo,
                            context: context,
                          ),
                          MyDraftStories(userInfo: userInfo),
                          MyPendingStories(
                            userInfo: userInfo,
                          ),
                          MyDeclinedStories(
                            userInfo: userInfo,
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
    );
  }
}

class PostStory extends StatefulWidget {
  const PostStory({Key? key}) : super(key: key);

  @override
  State<PostStory> createState() => _PostStoryState();
}

class _PostStoryState extends State<PostStory> {
  final localizationController = Get.find<LocalizationController>();
  var list = ['assets/images/bg1.png'];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: [
          Container(
            color: Colors.white,
            child: ListView.builder(
              itemCount: list.length,
              itemBuilder: (context, i) {
                return itemDesign(list[i]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget itemDesign(String item) {
    return Card(
      elevation: 0,
      //4
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
      // margin: EdgeInsets.only(left: 16,top: 16,right: 16),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(0),
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
                        item,
                        fit: BoxFit.fitWidth,
                      )),
                  Container(
                    decoration: const BoxDecoration(color: Color(0x4B000000)),
                  ),
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      start: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          alignment: AlignmentDirectional.topEnd,
                          child: PopupMenuButton<int>(
                            icon: const Icon(
                              Icons.more_vert,
                              color: Colors.white,
                              size: 25,
                            ),
                            itemBuilder: (context) {
                              return <PopupMenuEntry<int>>[
                                PopupMenuItem(
                                    value: 0,
                                    child: Text(
                                        TKeys.delete_post.translate(context))),
                                PopupMenuItem(
                                    value: 2,
                                    child: Text(
                                        TKeys.edit_post.translate(context))),
                                PopupMenuItem(
                                    value: 2,
                                    child: Text(TKeys.disable_comment
                                        .translate(context))),
                              ];
                            },
                          ),
                        ),
                        Row(
                          children: [
                            const AvatarView(
                              radius: 20,
                              borderWidth: 2,
                              borderColor: Colors.white,
                              avatarType: AvatarType.CIRCLE,
                              imagePath: 'assets/images/user_profile.png',
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Nick name',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: Constants.fontFamilyName,
                                    ),
                                  ),
                                  Text(
                                    '10/30/2021',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontFamily: Constants.fontFamilyName,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Text(
                        TKeys.what_should_i_do.translate(context),
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: Constants.fontFamilyName,
                            color: const Color(0xff19334D),
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(
                      '119',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        fontFamily: Constants.fontFamilyName,
                        color: const Color(0xff19334D),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.only(start: 8.0),
                      child: SvgPicture.asset(
                        'assets/icons/story_view.svg',
                        height: 22,
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: localizationController.directionRTL
                      ? const EdgeInsets.only(left: 25)
                      : const EdgeInsets.only(right: 25),
                  child: Text(
                    'this is a sample story this is a sample '
                    'this is a sample story this is a sample '
                    'this is a sample story this is a sample '
                    'this is a sample story this is a sample '
                    'this is a sample story this is a sample ',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: 13,
                        fontFamily: Constants.fontFamilyName,
                        color: Colors.black),
                  ),
                ),
                Text(
                  'read more',
                  style: TextStyle(
                    fontSize: 13,
                    fontFamily: Constants.fontFamilyName,
                    color: const Color(0xff19334D),
                  ),
                ),
              ],
            ),
          ),
          Divider(
            color: Constants.lineColor,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3.5, horizontal: 4),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(start: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                          'assets/images/ICONS/New folder/Liked.svg',
                          height: 20,
                          color: const Color(0xff19334D),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 6.0),
                          child: Text(
                            '152',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: Constants.fontFamilyName,
                              color: const Color(0xff19334D),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(start: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        /*Icon(
                          Icons.chat_bubble_rounded,
                          size: 20,
                          color: Colors.black54,
                        ),*/
                        GestureDetector(
                          child: SvgPicture.asset(
                            'assets/images/ICONS/New folder/Comment.svg',
                            height: 20,
                            color: const Color(0xff19334D),
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentScreen(
                                  comments: const [],
                                  postId: 1,
                                  route: 'myMainScreen',
                                ),
                              ),
                            );
                          },
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 6.0),
                          child: Text(
                            '23',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: Constants.fontFamilyName,
                              color: const Color(0xff19334D),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        child: Text(
                          TKeys.comment_text.translate(context),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            fontFamily: Constants.fontFamilyName,
                            color: const Color(0xff19334D),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentScreen(
                                comments: const [],
                                postId: 1,
                                route: 'myMainScreen',
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Constants.lineColor,
            thickness: 1,
          ),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CommentScreen(
                    comments: const [],
                    postId: 1,
                    route: 'myMainScreen',
                  ),
                ),
              );
            },
            child: userComment(),
          ),
        ],
      ),
    );
  }

  Widget userComment() {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      decoration: BoxDecoration(
          color: Constants.commentBackgroundColor,
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AvatarView(
              radius: 16,
              avatarType: AvatarType.CIRCLE,
              imagePath: 'assets/images/user_profile.png',
            ),
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Nick name',
                          style: TextStyle(
                            fontSize: 14,
                            color: Constants.textTitleColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.fontFamilyName,
                          ),
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          '10/30/2021',
                          style: TextStyle(
                            fontSize: 13,
                            color: Constants.commentDateColor,
                            fontWeight: FontWeight.normal,
                            fontFamily: Constants.fontFamilyName,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    Text(
                        'This is comment This is comment '
                        'This is comment This is comment '
                        'This is comment This is comment',
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontFamily: Constants.fontFamilyName,
                        )),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuButton<int>(
              child: Container(
                padding: const EdgeInsetsDirectional.only(
                  start: 10,
                ),
                height: 36,
                width: 48,
                child: Icon(
                  Icons.more_vert,
                  color: Constants.vertIconColor,
                ),
              ),
              itemBuilder: (context) {
                String userId = box.read('userID');
                log(userId);
                return <PopupMenuEntry<int>>[
                  PopupMenuItem(
                      value: 0,
                      child: Text(TKeys.delete_comment.translate(context))),
                  PopupMenuItem(
                    value: 2,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.popAndPushNamed(context, 'blockuser');
                      },
                      child: Text(
                        TKeys.report_block.translate(context),
                      ),
                    ),
                  ),
                ];
              },
            ),
          ],
        ),
      ),
    );
  }
}
