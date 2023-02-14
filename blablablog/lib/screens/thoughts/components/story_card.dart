import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:blabloglucy/Localization/localization_service.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/application/auth/auth_provider.dart';
import 'package:blabloglucy/application/story/get/story_provider.dart';
import 'package:blabloglucy/domain/auth/models/user_info.dart';
import 'package:blabloglucy/domain/story/story_model.dart';
import 'package:blabloglucy/providers/story_provider.dart';
import 'package:blabloglucy/providers/user_provider.dart';
import 'package:blabloglucy/screens/blocked_users/block_user.dart';
import 'package:blabloglucy/screens/comment_screen/comment_screen.dart';
import 'package:blabloglucy/screens/writerPage/writer_screen.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/widgets/custom_user_avatar.dart';
import 'package:blabloglucy/widgets/user_comment.dart';

import '../../../utills/counter_function.dart';

// ignore: must_be_immutable
class StoryCard extends HookConsumerWidget {
  final String item;
  final String image;
  final StoryModel story;
  final String route;
  StoryCard({
    Key? key,
    required this.item,
    required this.image,
    required this.story,
    required this.route,
  }) : super(key: key);

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
    'assets/images/PostBackground/19.png',
    'assets/images/PostBackground/20.png',
    'assets/images/PostBackground/21.png',
    'assets/images/PostBackground/22.png',
    'assets/images/PostBackground/23.png',
    'assets/images/PostBackground/24.png',
    'assets/images/PostBackground/25.png',
    'assets/images/PostBackground/49.png',
    'assets/images/PostBackground/26.png',
    'assets/images/PostBackground/27.png',
    'assets/images/PostBackground/28.png',
    'assets/images/PostBackground/29.png',
    'assets/images/PostBackground/30.png',
    'assets/images/PostBackground/31.png',
    'assets/images/PostBackground/32.png',
    'assets/images/PostBackground/33.png',
    'assets/images/PostBackground/34.png',
    'assets/images/PostBackground/35.png',
    'assets/images/PostBackground/36.png',
    'assets/images/PostBackground/37.png',
    'assets/images/PostBackground/38.png',
    'assets/images/PostBackground/39.png',
    'assets/images/PostBackground/40.png',
    'assets/images/PostBackground/41.png',
    'assets/images/PostBackground/42.png',
    'assets/images/PostBackground/43.png',
    'assets/images/PostBackground/44.png',
    'assets/images/PostBackground/45.png',
    'assets/images/PostBackground/46.png',
    'assets/images/PostBackground/47.png',
    'assets/images/PostBackground/48.png',
    'assets/images/PostBackground/49.png',
  ];

  final localizationscontroller = Get.find<LocalizationController>();
  var box = GetStorage();

  @override
  Widget build(BuildContext context, ref) {
    final liked = useState(story.likedByMe);
    final likes = useState(story.story.likes);
    final expended = useState(false);
    final commentAllowed = useState<bool?>(story.story.isCommentsAllowed);
    final userInfo = ref.watch(authProvider);
    UserProvider localUserProvider =
        provider.Provider.of<UserProvider>(context);
    StoryProvider localStoryProvider =
        provider.Provider.of<StoryProvider>(context);

    Logger.e(box.read('userGender'));
    return Card(
      elevation: 0,
      //4
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(0))),
      // margin: EdgeInsets.only(left: 16,top: 16,right: 16),
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 130,
            child: Card(
              elevation: 0,
              clipBehavior: Clip.antiAlias,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Stack(
                  children: [
                    SizedBox(
                      height: 148,
                      width: MediaQuery.of(context).size.width,
                      child: Image.asset(
                        item,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      decoration: const BoxDecoration(color: Color(0x4B000000)),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(start: 5, end: 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 0, right: 0),
                            child: PopupMenuButton<int>(
                              icon: const Icon(
                                Icons.more_vert,
                                color: Colors.white,
                                size: 28,
                              ),
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              itemBuilder: (context) {
                                bool? isFollowed = false;
                                if (localUserProvider.followingUsers != null &&
                                    localUserProvider
                                        .followingUsers!.isNotEmpty) {
                                  for (var element
                                      in localUserProvider.followingUsers!) {
                                    if (element.id == story.userId) {
                                      isFollowed = true;
                                    }
                                  }
                                }
                                return <PopupMenuEntry<int>>[
                                  if (userInfo.userInfo.id != story.userId)
                                    PopupMenuItem(
                                      onTap: () {
                                        if (!isFollowed!) {
                                          localUserProvider.followUser(
                                            context: context,
                                            userId: story.story.userId,
                                          );
                                          UserInfo user = UserInfo(
                                            totalPending: 0,
                                            totalDrafts: 0,
                                            totalApproval: 0,
                                            totalImTailing: 0,
                                            deniedPublished: 0,
                                            name: story.userNick,
                                            color: story.userColor,
                                            count: 0,
                                            id: story.userId,
                                            gender: story.userGender,
                                            inboxCount: 0,
                                            newImTailingCount: 0,
                                            unreadNotifsNo: 0,
                                            yearOfBirth: 1980,
                                          );
                                          localUserProvider.followingUsers ??=
                                              [];
                                          localUserProvider.followingUsers!
                                              .add(user);
                                        } else {
                                          localUserProvider.unfollowUser(
                                            context: context,
                                            userId: story.userId,
                                          );
                                          localUserProvider.followingUsers!
                                              .removeWhere(
                                            (element) =>
                                                element.id == story.userId,
                                          );
                                          localUserProvider
                                              .changeFollowingUsers(
                                            localUserProvider.followingUsers,
                                          );
                                        }
                                      },
                                      value: 0,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          isFollowed!
                                              ? 'UnFollow'
                                              : TKeys.follow.translate(context),
                                        ),
                                      ),
                                    ),
                                  if (userInfo.userInfo.id != story.userId)
                                    PopupMenuItem(
                                        value: 2,
                                        child: GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BlockedUser(
                                                  userId:
                                                      story.userId.toString(),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Text(
                                            TKeys.report_block.translate(
                                              context,
                                            ),
                                          ),
                                        )),
                                  if (userInfo.userInfo.id == story.userId)
                                    PopupMenuItem(
                                      onTap: () {
                                        // ref
                                        //     .read(storyProvider.notifier)
                                        //     .deleteStory(story.story.id);
                                        localUserProvider.deleteStory(
                                          context: context,
                                          storyId: story.story.id,
                                        );
                                        if (route
                                            .contains('myPublishedStories')) {
                                          localStoryProvider.myPublishedStories!
                                              .removeWhere(
                                            (element) =>
                                                element.story.id ==
                                                story.story.id,
                                          );
                                          localStoryProvider
                                              .changeMyPublishedStories(
                                            myPublishedStories:
                                                localStoryProvider
                                                    .myPublishedStories!,
                                          );
                                        } else if (route
                                            .contains('myDraftStories')) {
                                          localStoryProvider.myDraftStories!
                                              .removeWhere(
                                            (element) =>
                                                element.story.id ==
                                                story.story.id,
                                          );
                                          localStoryProvider
                                              .changeMyDraftStories(
                                            myDraftStories: localStoryProvider
                                                .myDraftStories!,
                                          );
                                        } else if (route
                                            .contains('myPendingStories')) {
                                          localStoryProvider.myPendingStories!
                                              .removeWhere(
                                            (element) =>
                                                element.story.id ==
                                                story.story.id,
                                          );
                                          localStoryProvider
                                              .changeMyPendingStories(
                                            myPendingStories: localStoryProvider
                                                .myPendingStories!,
                                          );
                                        } else if (route
                                            .contains('myDeclinedStories')) {
                                          localStoryProvider.myDeclinedStories!
                                              .removeWhere(
                                            (element) =>
                                                element.story.id ==
                                                story.story.id,
                                          );
                                          localStoryProvider
                                              .changeMyRejectedStories(
                                            myRejectedStories:
                                                localStoryProvider
                                                    .myDeclinedStories!,
                                          );
                                        } else {
                                          localStoryProvider
                                              .storiesByGroups![route]!
                                              .removeWhere((element) =>
                                                  element.story.id ==
                                                  story.story.id);
                                          localStoryProvider
                                              .changeStoriesByGroups(
                                            storiesByGroups: localStoryProvider
                                                .storiesByGroups!,
                                          );
                                        }
                                      },
                                      value: 3,
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Text(
                                          TKeys.delete_post.translate(
                                            context,
                                          ),
                                        ),
                                      ),
                                    ),
                                  // if (userInfo.userInfo.id == story.userId)
                                  //   PopupMenuItem(
                                  //     onTap: () {
                                  //       ref
                                  //           .read(storyProvider.notifier)
                                  //           .deleteStory(story.story.id);
                                  //     },
                                  //     child: SizedBox(
                                  //       width: double.infinity,
                                  //       child: Text(
                                  //         TKeys.delete_post.translate(context),
                                  //       ),
                                  //     ),
                                  //     value: 3,
                                  //   ),
                                  if (story.myPost)
                                    PopupMenuItem(
                                      onTap: () {
                                        // story.story.isCommentsAlowed =
                                        //     !story.story.isCommentsAlowed!;
                                        commentAllowed.value =
                                            !commentAllowed.value!;
                                        localStoryProvider.disableComments(
                                          context: context,
                                          story: story,
                                        );

                                        if (route
                                            .contains('myPublishedStories')) {
                                          if (localStoryProvider.userStories !=
                                                  null &&
                                              localStoryProvider
                                                  .userStories!.isNotEmpty) {
                                            int storyIndex = localStoryProvider
                                                .userStories!
                                                .indexWhere(
                                              (element) =>
                                                  element.story.id ==
                                                  story.story.id,
                                            );
                                            if (storyIndex != -1) {
                                              localStoryProvider
                                                      .userStories![storyIndex]
                                                      .story
                                                      .isCommentsAllowed =
                                                  commentAllowed.value;
                                            }
                                            localStoryProvider
                                                .changeUserStories(
                                              userStories: localStoryProvider
                                                  .userStories!,
                                            );
                                          }
                                        } else {
                                          if (localStoryProvider
                                                      .myPublishedStories !=
                                                  null &&
                                              localStoryProvider
                                                  .myPublishedStories!
                                                  .isNotEmpty) {
                                            int storyIndex = localStoryProvider
                                                .myPublishedStories!
                                                .indexWhere(
                                              (element) =>
                                                  element.story.id ==
                                                  story.story.id,
                                            );
                                            if (storyIndex != -1) {
                                              localStoryProvider
                                                      .myPublishedStories![
                                                          storyIndex]
                                                      .story
                                                      .isCommentsAllowed =
                                                  commentAllowed.value;
                                            }
                                            localStoryProvider
                                                .changeMyPublishedStories(
                                              myPublishedStories:
                                                  localStoryProvider
                                                      .myPublishedStories!,
                                            );
                                          }
                                        }
                                      },
                                      value: 0,
                                      child: Text(
                                        commentAllowed.value!
                                            ? TKeys.disable_comment
                                                .translate(context)
                                            : TKeys.enable_comment
                                                .translate(context),
                                      ),
                                    ),
                                ];
                              },
                            ),
                          ),
                          const SizedBox(
                            height: 26,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 8.0, bottom: 8.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                CustomUserAvatar(
                                  imageUrl: story.userGender == 'Male'
                                      ? 'assets/icons/male.png'
                                      : 'assets/icons/female.png',
                                  userColor: story.userColor,
                                ),
                                // CustomProfileAvatar(story: story),
                                Padding(
                                  padding: const EdgeInsetsDirectional.only(
                                    start: 8,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (builder) =>
                                                  WriterScreen(
                                                item: item,
                                                image: image,
                                                story: story,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Text(
                                          story.userNick,
                                          style: GoogleFonts.montserrat(
                                              fontSize: 18,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              shadows: [
                                                BoxShadow(
                                                  blurRadius: 5,
                                                  color: Colors.grey
                                                      .withOpacity(0.5),
                                                )
                                              ]),
                                        ),
                                      ),
                                      Text(
                                        story.story.publishDate,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontFamily: Constants.fontFamilyName,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    box.read('lang') == 'he'
                        ? Align(
                            alignment: const Alignment(-1.1, 1.42),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WriterScreen(
                                    item: item,
                                    image: image,
                                    story: story,
                                  ),
                                ),
                              ),
                              child: Image.asset(
                                'assets/images/icon2.png',
                                height: 45,
                              ),
                            ))
                        : Align(
                            alignment: const Alignment(1.1, 1.42),
                            child: GestureDetector(
                              onTap: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => WriterScreen(
                                    item: item,
                                    image: image,
                                    story: story,
                                  ),
                                ),
                              ),
                              child: Image.asset(
                                'assets/images/icon1.png',
                                height: 45,
                              ),
                            )),
                  ],
                ),
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(bottom: 5, right: 15, left: 15, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        right: box.read('lang') == 'he' ? 10 : 20,
                      ),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (builder) => WriterScreen(
                                item: item,
                                image: image,
                                story: story,
                              ),
                            ),
                          );
                        },
                        child: Text(
                          story.story.title,
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xff19334D),
                            fontFamily: Constants.fontFamilyName,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Text(
                      //By OK
                      '${CounterFunction.countforInt(int.parse(story.story.views.toString()))} ${TKeys.views.translate(context)}',
                      // '${story.story.views} ${TKeys.views.translate(context)}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        fontFamily: Constants.fontFamilyName,
                        color: Constants.readMoreColor,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsetsDirectional.only(start: 8.0),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       Logger.e(story.story.views.toString());
                    //     },
                    //     child: SvgPicture.asset(
                    //       'assets/icons/story_view.svg',
                    //       height: 22,
                    //     ),
                    //   ),
                    // )
                  ],
                ),
                const SizedBox(height: 2),
                Padding(
                  padding: EdgeInsets.only(
                    right: box.read('lang') == 'he' ? 10 : 35,
                    left: box.read('lang') == 'he' ? 35 : 0,
                  ),
                  child: Text(
                    expended.value
                        ? story.story.body
                            .replaceAll('<p>', '')
                            .replaceAll('</p>', '')
                        : story.story.body
                            .substring(0, 200)
                            .replaceAll('<p>', '')
                            .replaceAll('</p>', ''),
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: Constants.fontFamilyName,
                      color: Colors.black,
                      overflow: expended.value
                          ? TextOverflow.visible
                          : TextOverflow.visible,
                    ),
                    maxLines: expended.value ? null : 5,
                    textAlign: localizationscontroller.directionRTL
                        ? TextAlign.justify
                        : TextAlign.justify,
                  ),
                ),
                // HtmlWidget(
                //   expended.value
                //       ? story.story.body
                //       : story.story.body.substring(0, 200),
                //   renderMode: RenderMode.column,
                //   textStyle: TextStyle(
                //     fontSize: 15,
                //     fontFamily: Constant.fontFamilyName,
                //     color: Colors.black,
                //     overflow: TextOverflow.ellipsis,
                //   ),
                // ),
                Padding(
                  padding: EdgeInsets.only(
                    right: localizationscontroller.directionRTL ? 20 : 0,
                  ),
                  child: InkWell(
                    onTap: () {
                      if (!expended.value) {
                        ref
                            .read(storyProvider.notifier)
                            .viewStory(story.story.id);
                      }
                      expended.value = !expended.value;
                    },
                    child: expended.value
                        ? Text(
                            TKeys.read_less
                                .translate(context)
                                .capitalizeFirst
                                .toString(),
                            //"read less",
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: Constants.fontFamilyName,
                              color: const Color(0xff19334D),
                            ),
                          )
                        : Text(
                            TKeys.read_more
                                .translate(context)
                                .capitalizeFirst
                                .toString(),
                            //"read more",
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w500,
                              fontFamily: Constants.fontFamilyName,
                              color: const Color(0xff19334D),
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 8, top: 12, bottom: 12, right: 8.0),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(start: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            liked.value = !liked.value;
                            ref
                                .read(storyProvider.notifier)
                                .like(story.story.id);
                          },
                          child: liked.value
                              ? SvgPicture.asset(
                                  'assets/images/Liked.svg',
                                  height: 20,
                                  color: Colors.black87,
                                )
                              : SvgPicture.asset(
                                  'assets/images/Unliked.svg',
                                  height: 20,
                                  color: Colors.black87,
                                ),
                        ),
                        //color: const Color(0xff19334D)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                              start: 6, end: 6.0),
                          child: Text(
                            CounterFunction.countforInt(
                                    int.parse(likes.value.toString()))
                                .toString(),
                            // likes.value.toString(),
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              fontFamily: Constants.fontFamilyName,
                              color: const Color(0xff19334D),
                            ),
                          ),
                        ),
                        const Expanded(
                            child:
                                Divider(thickness: 1, color: Colors.black87)),
                      ],
                    ),
                  ),
                ),
                if (commentAllowed.value!)
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
                            onTap: () {
                              // _storyProvider.getSingleStoryComments(
                              //   context: context,
                              //   storyId: story.story.id,
                              //   pageNumber: 0,
                              // );
                              print("storyId: " + story.story.id.toString());
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CommentScreen(
                                    comments: story.comments,
                                    postId: story.story.id,
                                    storyModel: story,
                                    route: route,
                                    color: userInfo.userInfo.color,
                                    male: userInfo.userInfo.gender,
                                  ),
                                ),
                              );
                            },
                            child: SvgPicture.asset(
                              'assets/images/ICONS/New folder/Comment.svg',
                              height: 20,
                              color: Colors.black87,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsetsDirectional.only(
                                start: 6.0, end: 6.0),
                            child: Text(
                              // story.totalComments.toString(),
                              CounterFunction.countforInt(
                                      int.parse(story.totalComments.toString()))
                                  .toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                                fontFamily: Constants.fontFamilyName,
                                color: const Color(0xff19334D),
                              ),
                            ),
                          ),
                          const Expanded(
                              child:
                                  Divider(thickness: 1, color: Colors.black87)),
                          const SizedBox(width: 6.0),
                        ],
                      ),
                    ),
                  ),
                if (commentAllowed.value!)
                  InkWell(
                    child: Text(
                      TKeys.comment_text.translate(context),
                      textAlign: TextAlign.right,
                      style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: const Color(0xff19334D),
                      ),
                    ),
                    onTap: () {
                      //  _storyProvider.getSingleStoryComments(
                      //   context: context,
                      //   storyId: story.story.id,
                      //   pageNumber: 0,
                      // );
                      Logger.w('qqqqq${story.comments} ${story.story.id}');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CommentScreen(
                            comments: story.comments,
                            postId: story.story.id,
                            storyModel: story,
                            route: route,
                            color: userInfo.userInfo.color,
                            male: userInfo.userInfo.gender,
                          ),
                        ),
                      );
                    },
                  ),
              ],
            ),
          ),
          const SizedBox(
            height: 22,
          ),
          commentAllowed.value! && story.comments.isNotEmpty
              ? ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount:
                      story.comments.length > 2 ? 2 : story.comments.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: GestureDetector(
                        onTap: () {
                          // _storyProvider.getSingleStoryComments(
                          //   context: context,
                          //   storyId: story.story.id,
                          //   pageNumber: 0,
                          // );
                          print("storyId333: " + story.story.id.toString());
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentScreen(
                                comments: story.comments,
                                postId: story.story.id,
                                storyModel: story,
                                route: route,
                                color: userInfo.userInfo.color,
                                male: userInfo.userInfo.gender,
                              ),
                            ),
                          );
                        },
                        child: UserCommentCard(
                          storyUserId: story.story.user != null
                              ? story.story.user!.id.toString()
                              : story.story.userId.toString(),
                          comment: story.comments[index],
                          myID: box.read('userID'),
                          deleteCommentCallBack: () {
                            localUserProvider.deleteComment(
                              context: context,
                              commentId: story.comments[index].comment.id,
                            );
                            if (route.contains('thoughtScreen')) {
                              int storyIndex =
                                  localStoryProvider.userStories!.indexWhere(
                                (element) => element.story == story.story,
                              );
                              localStoryProvider
                                  .userStories![storyIndex].comments
                                  .remove(
                                story.comments[index],
                              );
                              localStoryProvider.changeUserStories(
                                userStories: localStoryProvider.userStories!,
                              );
                            } else {
                              int storyIndex = localStoryProvider
                                  .storiesByGroups![route]!
                                  .indexWhere(
                                (element) => element.story == story.story,
                              );
                              localStoryProvider
                                  .storiesByGroups![route]![storyIndex].comments
                                  .remove(
                                story.comments[index],
                              );
                              localStoryProvider.changeStoriesByGroups(
                                storiesByGroups:
                                    localStoryProvider.storiesByGroups!,
                              );
                            }
                          },
                          route: route,
                        ),
                      ),
                    );
                  },
                )
              : const SizedBox(),
          !commentAllowed.value!
              ? Container(
                  height: 40,
                  width: Get.width,
                  decoration: BoxDecoration(
                    color: const Color(0xffFAFAFA),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    TKeys.disabledComments.translate(context),
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 0),
          // commentAllowed.value!
          false
              ? Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 1),
                  //by OK fix comment gap
                  child: Center(
                    child:
                        //by OK changes
                        InkWell(
                      onTap: () {
                        // _storyProvider.getSingleStoryComments(
                        //   context: context,
                        //   storyId: story.story.id,
                        //   pageNumber: 0,
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentScreen(
                              comments: story.comments,
                              postId: story.story.id,
                              storyModel: story,
                              route: route,
                              color: userInfo.userInfo.color,
                              male: userInfo.userInfo.gender,
                            ),
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.only(
                            left: 5, bottom: 7, top: 7, right: 5),
                        decoration: BoxDecoration(
                            color: const Color(0xffFAFAFA),
                            borderRadius: BorderRadius.circular(12)),
                        child: Row(
                          children: [
                            CustomUserAvatar(
                              imageUrl: userInfo.userInfo.gender == 'Male'
                                  ? 'assets/icons/male.png'
                                  : 'assets/icons/female.png',
                              userColor: userInfo.userInfo.color,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                                // 'Comment',
                                //Comment translate changes by OK
                                TKeys.comment_text.translate(context)),
                          ],
                        ),
                      ),
                    ),
                    /*  ListTile(
                      onTap: () {
                        _storyProvider.getSingleStoryComments(
                          context: context,
                          storyId: story.story.id,
                          pageNumber: 0,
                        );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CommentScreen(
                              comments: story.comments,
                              postId: story.story.id,
                              storyModel: story,
                              route: route,
                            ),
                          ),
                        );
                      },
                      contentPadding: const EdgeInsets.only(left: 5, bottom: 2,right: 0),
                      leading: CustomUserAvatar(
                        imageUrl: userInfo.userInfo.gender == 'Male'
                            ? "assets/icons/male.png"
                            : "assets/icons/female.png",
                        userColor: userInfo.userInfo.color,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      tileColor: const Color(0xffFAFAFA),
                      title: const Text(
                        'Comment',
                      ),
                    ),*/
                  ),
                )
              : const SizedBox(),
          const SizedBox(height: 22),
          // if (story.comments.isNotEmpty)
          //   GestureDetector(
          //     onTap: () {
          //       Navigator.push(
          //         context,
          //         MaterialPageRoute(
          //           builder: (context) => CommentScreen(
          //             comments: story.comments,
          //             postId: story.story.id,
          //           ),
          //         ),
          //       );
          //     },
          //     child: CommentPart(
          //       comments: story.comments[0],
          //       userInfo: userInfo.userInfo.id,
          //       postUserId: story.userId,
          //     ),
          //   ),
        ],
      ),
    );
  }
}
