import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blabloglucy/Localization/localization_service.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/application/auth/auth_provider.dart';
import 'package:blabloglucy/application/story/get/story_provider.dart';
import 'package:blabloglucy/domain/story/story_model.dart';
import 'package:blabloglucy/screens/comment_screen/comment_screen.dart';
import 'package:blabloglucy/screens/thoughts/components/comment_part.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/utills/counter_function.dart';
import 'package:blabloglucy/widgets/custom_user_avatar.dart';

class WritersStoryCard extends HookConsumerWidget {
  final String item;
  final String image;
  final StoryModel story;
  WritersStoryCard({
    Key? key,
    required this.item,
    required this.image,
    required this.story,
  }) : super(key: key);

  final localizationsController = Get.find<LocalizationController>();

  @override
  Widget build(BuildContext context, ref) {
    final expended = useState(false);
    final userInfo = ref.watch(authProvider);
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
            height: 110,
            width: MediaQuery.of(context).size.width,
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
                      start: 5,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        PopupMenuButton<int>(
                          icon: const Icon(
                            Icons.more_vert,
                            color: Colors.white,
                            size: 25,
                          ),
                          itemBuilder: (context) {
                            return <PopupMenuEntry<int>>[
                              PopupMenuItem(
                                value: 0,
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Text(
                                    TKeys.follow.translate(context),
                                  ),
                                ),
                              ),
                              PopupMenuItem(
                                value: 2,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.popAndPushNamed(
                                        context, 'blockuser');
                                  },
                                  child: Text(
                                    TKeys.report_block.translate(context),
                                  ),
                                ),
                              ),
                            ];
                          },
                        ),
                        Row(
                          children: [
                            // AvatarView(
                            //   radius: 20,
                            //   borderWidth: 0,
                            //   borderColor: fromRGBColor(story.userColor),
                            //   avatarType: AvatarType.CIRCLE,
                            //   imagePath: story.userGender == "Male"
                            //       ? "assets/icons/male.png"
                            //       : "assets/icons/female.png",
                            // ),
                            CustomUserAvatar(
                              imageUrl: story.userGender == 'Male'
                                  ? 'assets/icons/male.png'
                                  : 'assets/icons/female.png',
                              userColor: story.userColor,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsetsDirectional.only(start: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  GestureDetector(
                                    // onTap: () {
                                    //   Navigator.of(context).push(
                                    //       MaterialPageRoute(
                                    //           builder: (builder) =>
                                    //               WriterScreen(
                                    //                   item: item,
                                    //                   image: image,
                                    //                   story: story)));
                                    // },
                                    child: Text(
                                      story.userNick,
                                      //////////////////////////////////////////////// NICK NAME - BACKGROUND PICTURE //////////////////////////////////////
                                      //TKeys.nick_name.translate(context),
                                      style: GoogleFonts.montserrat(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            BoxShadow(
                                              blurRadius: 5,
                                              color:
                                                  Colors.grey.withOpacity(0.5),
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
                      ],
                    ),
                  ),
                  localizationsController.directionRTL
                      ? Align(
                          alignment: const Alignment(-1.08, 1.48),
                          child: GestureDetector(
                            onTap: () {},
                            //     Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => WriterScreen(
                            //       item: item,
                            //       image: image,
                            //       story: story,
                            //     ),
                            //   ),
                            // ),
                            child: Image.asset(
                              'assets/images/icon2.png',
                              height: 45,
                            ),
                          ))
                      : Align(
                          alignment: const Alignment(1.04, 1.42),
                          child: GestureDetector(
                            onTap: () {
                              //by OK fix bug blue icon
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (context) => WriterScreen(
                              //       item: item,
                              //       image: image,
                              //       story: story,
                              //     ),
                              //   ),
                              // );
                            },
                            child: Image.asset(
                              'assets/images/icon1.png',
                              height: 45,
                            ),
                          )),
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
            padding: EdgeInsets.only(
              right: localizationsController.directionRTL ? 10 : 0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        /////////////////////Story Title /////////////////////////////////////////////////////////////////////////////////////////////
                        story.story.title,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: const Color(0xff19334D),
                          fontFamily: Constants.fontFamilyName,
                        ),
                      ),
                    ),
                    ////////////////////// View Counter /////////////////////////////////////////////////////////////////////////////////////
                    Text(
                      CounterFunction.countforInt(
                              int.parse(story.story.views.toString()))
                          .toString(),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        fontFamily: Constants.fontFamilyName,
                        color: Constants.readMoreColor,
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
                const SizedBox(
                  height: 6,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: localizationsController.directionRTL ? 20 : 35,
              left: localizationsController.directionRTL ? 35 : 10,
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
              textAlign: localizationsController.directionRTL
                  ? TextAlign.justify
                  : TextAlign.justify,
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
              right: localizationsController.directionRTL == true ? 20 : 0,
            ),
            child: InkWell(
              onTap: () {
                if (!expended.value) {
                  ref.read(storyProvider.notifier).viewStory(story.story.id);
                }
                expended.value = !expended.value;
              },
              child: expended.value
                  ? Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
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
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Text(
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
          ),
          /*  Padding(
            padding: const EdgeInsets.only(left: 5,right: 35),
            child:
            // HtmlWidget(
            //   story.story.body,
            //   renderMode: RenderMode.column,
            //   textStyle: TextStyle(
            //     fontSize: 15,
            //     fontFamily: Constants.fontFamilyName,
            //     color: Colors.black,
            //   ),
            // ),
            //by OK
            Text(
              story.story.body
                  .replaceAll('<p>', '')
                  .replaceAll('</p>', ''),
              textAlign: TextAlign.justify,
              style:
              TextStyle(
                    fontSize: 15,
                    fontFamily: Constants.fontFamilyName,
                    color: Colors.black,
                  ),)
          ),*/
          Divider(
            color: Constants.lineColor,
            thickness: 1,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3.5),
            child: Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    margin: const EdgeInsetsDirectional.only(start: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        story.likedByMe
                            ? const Icon(
                                Icons.favorite_rounded,
                                color: Color(0xff19334D),
                              )
                            : InkWell(
                                onTap: () {},
                                child: const Icon(
                                  Icons.favorite_outline_rounded,
                                  color: Color(0xff19334D),
                                ),
                              ),
                        //color: const Color(0xff19334D)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 6),
                          child: Text(
                            // story.story.likes.toString(),
                            CounterFunction.countforInt(
                                    int.parse(story.story.likes.toString()))
                                .toString(),
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
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CommentScreen(
                                  comments: story.comments,
                                  postId: story.story.id,
                                  route: 'createStory',
                                ),
                              ),
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/images/ICONS/New folder/Comment.svg',
                            height: 20,
                            color: const Color(0xff19334D),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsetsDirectional.only(start: 6.0),
                          child: Text(
                            CounterFunction.countforInt(
                                    int.parse(story.comments.length.toString()))
                                .toString(),
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
                      InkWell(
                        child: Text(
                          TKeys.comment_text.translate(context),
                          style: GoogleFonts.montserrat(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: const Color(0xff19334D),
                          ),
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CommentScreen(
                                comments: story.comments,
                                postId: story.story.id,
                                route: 'createStory',
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
          if (story.comments.isNotEmpty)
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CommentScreen(
                      comments: story.comments,
                      postId: story.story.id,
                      route: 'createStory',
                    ),
                  ),
                );
              },
              child: CommentPart(
                comments: story.comments[0],
                userInfo: userInfo.userInfo.id,
                postUserId: story.story.userId,
              ),
            ),
          // if (story.comments.isEmpty)
          //   const SizedBox(
          //     height: 10,
          //   ),
          // const Padding(
          //   padding: EdgeInsets.only(bottom: 4, left: 10, right: 4),
          //   child: Text('Write a comment'),
          // ),
          // const SizedBox(
          //   height: 5,
          // ),
          // Padding(
          //   padding: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
          //   child: Row(
          //     crossAxisAlignment: CrossAxisAlignment.end,
          //     children: [
          //       Expanded(
          //         child: Container(
          //           padding: const EdgeInsets.symmetric(horizontal: 10),
          //           height: 50,
          //           width: 60,
          //           decoration: BoxDecoration(
          //             color: Colors.grey.withOpacity(0.1),
          //             borderRadius: BorderRadius.circular(10),
          //           ),
          //           child: Row(
          //             children: [
          //               const CircleAvatar(
          //                 backgroundImage: AssetImage('assets/images/man.png'),
          //                 radius: 15,
          //               ),
          //               const SizedBox(
          //                 width: 10,
          //               ),
          //               Expanded(
          //                 child: TextFormField(
          //                   decoration: const InputDecoration(
          //                       border: OutlineInputBorder(
          //                           borderSide: BorderSide.none)),
          //                   style: const TextStyle(
          //                       color: Color(0xff121556), fontSize: 14),
          //                 ),
          //               ),
          //               const SizedBox(
          //                 width: 10,
          //               ),
          //               const Icon(
          //                 Icons.send,
          //                 color: Color(0xff121556),
          //               ),
          //             ],
          //           ),
          //         ),
          //       ),
          //     ],
          //   ),
          // ),
        ],
      ),
    );
  }
}
