import 'dart:developer';

import 'package:blabloglucy/domain/story/replies/reply.dart';
import 'package:blabloglucy/providers/reply_provider.dart';
import 'package:blabloglucy/screens/comment_screen/comment_screen.dart';
import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:readmore/readmore.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/domain/story/comments/comment_model.dart';
import 'package:blabloglucy/screens/blocked_users/block_user.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/widgets/custom_user_avatar.dart';

import '../Localization/localization_service.dart';
import '../application/auth/auth_provider.dart';
import '../domain/auth/models/user_info.dart';
import 'package:provider/provider.dart' as provider;

import '../domain/story/replies/reply_modal.dart';


// ignore: must_be_immutable
class UserCommentCard extends ConsumerStatefulWidget {
  const UserCommentCard({
    Key? key,
    required this.comment,
    required this.route,
    required this.storyUserId,
    required this.myID,
    required this.deleteCommentCallBack,

    this.newComment = true,
    this.recursiveComment = false,
  }) : super(key: key);

  final CommentModel comment;
  final String route, storyUserId;
  final VoidCallback deleteCommentCallBack;
  final int myID;
  final bool newComment;
  final bool recursiveComment;

  @override
  _UserCommentCardState createState() => _UserCommentCardState();
}

class _UserCommentCardState extends ConsumerState<UserCommentCard> {
  Offset _tapPosition = Offset.zero;

  final localizationController = Get.find<LocalizationController>();

  final replyController = TextEditingController();
  bool checkReply = false;
  bool showPreviousReply = false;
  bool likeComment = false;

  void _getTapPosition(TapDownDetails details) {
    final RenderBox referenceBox = context.findRenderObject() as RenderBox;
    setState(() {
      _tapPosition = referenceBox.globalToLocal(details.globalPosition);
    });
  }

  void _showMenu(BuildContext context) {
    int userId = box.read('userID');
    final RenderObject? overlay =
        Overlay.of(context)?.context.findRenderObject();
    showMenu(
      context: context,
      position: RelativeRect.fromRect(
          Rect.fromLTWH(_tapPosition.dx, _tapPosition.dy, 30, 30),
          Rect.fromLTWH(0, 0, overlay!.paintBounds.size.width,
              overlay.paintBounds.size.height)),
      items: <PopupMenuEntry<int>>[
        if (userId == widget.comment.comment.userId ||
            userId == int.parse(widget.storyUserId))
          PopupMenuItem(
            onTap: widget.deleteCommentCallBack,
            value: 0,
            child: Text(
              TKeys.delete_comment.translate(context),
            ),
          ),
        widget.comment.comment.userId != widget.myID
            ? PopupMenuItem(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (ctx) => BlockedUser(
                            userId: widget.comment.user.id.toString()),
                      ));
                },
                value: 1,

                //by OK delete comment
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (ctx) => BlockedUser(
                              userId: widget.comment.user.id.toString()),
                        ));
                  },
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Text(TKeys.report_User.translate(context)),
                  ),
                ),
              )
            : PopupMenuItem(
                enabled: false,
                height: 0,
                padding: EdgeInsets.zero,
                onTap: widget.deleteCommentCallBack,
                child: null,
                value: 5,
              ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    ReplyProvider replyProvider = provider.Provider.of<ReplyProvider>(context);

    if (widget.recursiveComment) {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 22),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  width: double.maxFinite,
                  margin: const EdgeInsets.symmetric(horizontal: 25),
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                  decoration: BoxDecoration(
                      color: const Color(0xFFF8F9FE),
                      borderRadius: BorderRadius.circular(15)),
                  child: ReadMoreText(
                    widget.comment.comment.body,
                    textAlign: TextAlign.justify,
                    trimCollapsedText: TKeys.read_more
                        .translate(context)
                        .capitalizeFirst
                        .toString(),
                    trimExpandedText: TKeys.read_less
                        .translate(context)
                        .capitalizeFirst
                        .toString(),
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    colorClickableText: Constants.vertIconColor,
                    style: TextStyle(
                      fontSize: 13,
                      color: Constants.userCommentColor,
                      fontWeight: FontWeight.normal,
                      fontFamily: Constants.fontFamilyName,
                    ),
                  ),
                ),
                Positioned(
                  top: -30,
                  left: 15,
                  child: CustomUserAvatar(
                    imageUrl: widget.comment.user.gender == 1
                        ? 'assets/icons/male.png'
                        : 'assets/icons/female.png',
                    userColor: widget.comment.itemColor.colorHex,
                    size: 18,
                  ),
                ),
                Positioned(
                  top: -20,
                  left: 20,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomUserAvatar(
                        imageUrl: widget.comment.user.gender == 1
                            ? 'assets/icons/male.png'
                            : 'assets/icons/female.png',
                        userColor: widget.comment.itemColor.colorHex,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.comment.user.nickName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Constants.textTitleColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: Constants.fontFamilyName,
                        ),
                      ),
                      const SizedBox(width: 100),
                      Text(
                        widget.comment.comment.publishDate,
                        style: TextStyle(
                          fontSize: 13,
                          color: Constants.commentDateColor,
                          fontWeight: FontWeight.normal,
                          fontFamily: Constants.fontFamilyName,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -8,
                  right: 45,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(width: 16),
                      Text(
                        'view previous replies',
                        style: TextStyle(
                          fontSize: 13,
                          color: Constants.commentDateColor,
                          fontWeight: FontWeight.normal,
                          fontFamily: Constants.fontFamilyName,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '135',
                        style: TextStyle(
                          fontSize: 13,
                          color: Constants.commentDateColor,
                          fontWeight: FontWeight.normal,
                          fontFamily: Constants.fontFamilyName,
                        ),
                      ),
                      const SizedBox(width: 3),
                      SvgPicture.asset(
                        'assets/images/Unliked.svg',
                        height: 14,
                        color: Constants.commentDateColor,
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        child: Text(
                          TKeys.reply_text.translate(context),
                          style: TextStyle(
                            fontSize: 13,
                            color: Constants.commentDateColor,
                            fontWeight: FontWeight.normal,
                            fontFamily: Constants.fontFamilyName,
                          ),
                        ),
                        onTap: () {
                          showPreviousReply = showPreviousReply ? false : true;
                          replyProvider.getRepliesOnComment(
                              context: context,
                              commentId: widget.comment.comment.id,
                              authTOKEN: box.read('userTokenForAuth')
                          ).then((value) {
                            if (replyProvider.repliesOnComment!.isEmpty) {
                              BotToast.showText(
                                text: 'No previous replies on this comment.',
                                contentColor: Constants.blueColor,
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              );
                            }
                          });
                        },
                      ),
                      const SizedBox(width: 16),
                      GestureDetector(
                        child: Text(
                          TKeys.view_prev_reply.translate(context),
                          style: TextStyle(
                            fontSize: 13,
                            color: Constants.readMoreColor,
                            fontWeight: FontWeight.normal,
                            fontFamily: Constants.fontFamilyName,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            checkReply = checkReply ? false : true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          checkReply ? replyWidget(replyProvider) : Container(),
          showPreviousReply ? Column(
            children: getPreviousReplies(replyProvider),
          ) : Stack()
        ],
      );
    }
    if (widget.newComment) {
      return Column(
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 22),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                GestureDetector(
                  // onTapDown: (details) => _getTapPosition(details),
                  onLongPress: () => _showMenu(context),
                  child: Container(
                    width: double.maxFinite,
                    margin: const EdgeInsets.symmetric(horizontal: 25),
                    padding:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 25),
                    decoration: BoxDecoration(
                        color: const Color(0xFFF8F9FE),
                        borderRadius: BorderRadius.circular(15)),
                    child: ReadMoreText(
                      widget.comment.comment.body,
                      textAlign: TextAlign.justify,
                      trimCollapsedText: TKeys.read_more
                          .translate(context)
                          .capitalizeFirst
                          .toString(),
                      trimExpandedText: TKeys.read_less
                          .translate(context)
                          .capitalizeFirst
                          .toString(),
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      colorClickableText: Constants.vertIconColor,
                      style: TextStyle(
                        fontSize: 13,
                        color: Constants.userCommentColor,
                        fontWeight: FontWeight.normal,
                        fontFamily: Constants.fontFamilyName,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -20,
                  left: localizationController.directionRTL ? null : 20,
                  right: localizationController.directionRTL ? 20 : null,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomUserAvatar(
                        imageUrl: widget.comment.user.gender == 1
                            ? 'assets/icons/male.png'
                            : 'assets/icons/female.png',
                        userColor: widget.comment.itemColor.colorHex,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.comment.user.nickName,
                        style: TextStyle(
                          fontSize: 14,
                          color: Constants.textTitleColor,
                          fontWeight: FontWeight.bold,
                          fontFamily: Constants.fontFamilyName,
                        ),
                      ),
                      const SizedBox(width: 100),
                      Text(
                        widget.comment.comment.publishDate,
                        style: TextStyle(
                          fontSize: 13,
                          color: Constants.commentDateColor,
                          fontWeight: FontWeight.normal,
                          fontFamily: Constants.fontFamilyName,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: -8,
                  right: localizationController.directionRTL ? null : 45,
                  left: localizationController.directionRTL ? 45 : null,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const SizedBox(width: 16),
                      Text(
                        '',
                        style: TextStyle(
                          fontSize: 13,
                          color: Constants.commentDateColor,
                          fontWeight: FontWeight.normal,
                          fontFamily: Constants.fontFamilyName,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        '',
                        style: TextStyle(
                          fontSize: 13,
                          color: Constants.commentDateColor,
                          fontWeight: FontWeight.normal,
                          fontFamily: Constants.fontFamilyName,
                        ),
                      ),
                      const SizedBox(width: 3),
                      GestureDetector(
                        child: SvgPicture.asset(
                          likeComment ? 'assets/images/Liked.svg' : 'assets/images/Unliked.svg',
                          height: 14,
                          color: Constants.commentDateColor,
                        ),
                        onTap: () {
                          if (likeComment) {
                            replyProvider.unLikeComment(
                                context: context,
                                commentId: widget.comment.comment.id,
                                userId: box.read('userID'),
                                authTOKEN: box.read('userTokenForAuth')
                            ).catchError((err) {
                              BotToast.showText(
                                text: err.toString(),
                                contentColor: Colors.red,
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              );
                            }).then((value) {
                              print('unLikeComment$value');
                              setState(() {
                                likeComment = false;
                              });
                            });
                          } else {
                            replyProvider.likeComment(
                                context: context,
                                commentId: widget.comment.comment.id,
                                userId: box.read('userID'),
                                authTOKEN: box.read('userTokenForAuth')
                            ).catchError((err) {
                              BotToast.showText(
                                text: err.toString(),
                                contentColor: Colors.red,
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              );
                            }).then((value) {
                              print('likeComment$value');
                              setState(() {
                                likeComment = true;
                              });
                            });
                          }
                        },
                      ),
                      const SizedBox(width: 50),
                      GestureDetector(
                        child: Text(
                          TKeys.view_prev_reply.translate(context),
                          style: TextStyle(
                            fontSize: 13,
                            color: Constants.commentDateColor,
                            fontWeight: FontWeight.normal,
                            fontFamily: Constants.fontFamilyName,
                          ),
                        ),
                        onTap: () {
                          showPreviousReply = showPreviousReply ? false : true;
                          replyProvider.getRepliesOnComment(
                              context: context,
                              commentId: widget.comment.comment.id,
                              authTOKEN: box.read('userTokenForAuth')
                          ).then((value) {
                            if (replyProvider.repliesOnComment!.isEmpty) {
                              BotToast.showText(
                                text: 'No previous replies on this comment.',
                                contentColor: Constants.blueColor,
                                textStyle: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                              );
                            }
                          });
                        },
                      ),
                      const SizedBox(width: 50),
                      GestureDetector(
                        child: Text(
                          TKeys.reply_text.translate(context),
                          style: TextStyle(
                            fontSize: 13,
                            color: Constants.readMoreColor,
                            fontWeight: FontWeight.normal,
                            fontFamily: Constants.fontFamilyName,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            checkReply = checkReply ? false : true;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          checkReply ? replyWidget(replyProvider) : Container(),
          showPreviousReply ? Column(
            children: getPreviousReplies(replyProvider),
          ) : Stack()
        ],
      );
    }
    return Container(
      margin: const EdgeInsets.only(top: 0, bottom: 4),
      decoration: BoxDecoration(
        color: Constants.commentBackgroundColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsetsDirectional.all(5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // AvatarView(
            //   radius: 16,
            //   avatarType: AvatarType.CIRCLE,
            //   borderColor: fromRGBColor(comment.itemColor.colorHex),
            //   imagePath: comment.user.gender == 1
            //       ? "assets/icons/male.png"
            //       : 'assets/icons/female.png',
            // ),
            CustomUserAvatar(
              imageUrl: widget.comment.user.gender == 1
                  ? 'assets/icons/male.png'
                  : 'assets/icons/female.png',
              userColor: widget.comment.itemColor.colorHex,
              size: 18,
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
                          widget.comment.user.nickName,
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
                          widget.comment.comment.publishDate,
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
                    ReadMoreText(
                      widget.comment.comment.body,
                      textAlign: TextAlign.justify,
                      trimCollapsedText: TKeys.read_more
                          .translate(context)
                          .capitalizeFirst
                          .toString(),
                      trimExpandedText: TKeys.read_less
                          .translate(context)
                          .capitalizeFirst
                          .toString(),
                      trimLines: 2,
                      trimMode: TrimMode.Line,
                      colorClickableText: Constants.vertIconColor,
                      style: TextStyle(
                        fontSize: 13,
                        color: Constants.userCommentColor,
                        fontWeight: FontWeight.normal,
                        fontFamily: Constants.fontFamilyName,
                      ),
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                  ],
                ),
              ),
            ),
            PopupMenuButton<int>(
              onSelected: (value) {},
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
              itemBuilder: (ctx) {
                int userId = box.read('userID');
                log(userId.toString());
                log(widget.storyUserId.toString());
                return <PopupMenuEntry<int>>[
                  if (userId == widget.comment.comment.userId ||
                      userId == int.parse(widget.storyUserId))
                    PopupMenuItem(
                      onTap: widget.deleteCommentCallBack,
                      value: 0,
                      child: Text(
                        TKeys.delete_comment.translate(ctx),
                      ),
                    ),
                  widget.comment.comment.userId != widget.myID
                      ? PopupMenuItem(
                          onTap: () {
                            Navigator.push(
                                ctx,
                                MaterialPageRoute(
                                  builder: (ctx) => BlockedUser(
                                      userId:
                                          widget.comment.user.id.toString()),
                                ));
                          },
                          value: 1,

                          //by OK delete comment
                          child: GestureDetector(
                            onTap: () {
                              Navigator.pop(ctx);
                              Navigator.push(
                                  ctx,
                                  MaterialPageRoute(
                                    builder: (ctx) => BlockedUser(
                                        userId:
                                            widget.comment.user.id.toString()),
                                  ));
                            },
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: Text(TKeys.report_User.translate(ctx)),
                            ),
                          ),
                        )
                      : PopupMenuItem(
                          enabled: false,
                          height: 0,
                          padding: EdgeInsets.zero,
                          onTap: widget.deleteCommentCallBack,
                          child: null,
                          value: 5,
                        ),
                  // if (storyUserId == _userProvider.userInfo!.id.toString())
                  //   PopupMenuItem(
                  //     onTap: deleteCommentCallBack,
                  //     child: Text(
                  //       TKeys.delete_comment.translate(context),
                  //     ),
                  //     value: 1,
                  //   ),
                  // if (comment.user.id != _userProvider.userInfo!.id)
                  //   PopupMenuItem(
                  //     onTap: () {
                  //       _userProvider.reportUser(
                  //         context: context,
                  //         userId: comment.user.id,
                  //       );
                  //     },
                  //     child: Text(
                  //       TKeys.report_User.translate(context),
                  //     ),
                  //     value: 1,
                  //   ),
                ];
              },
              child: Container(
                height: 36,
                width: 48,
                alignment: AlignmentDirectional.centerEnd,
                child: Icon(
                  Icons.more_vert,
                  color: Constants.vertIconColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget replyWidget(ReplyProvider replyProvider) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10, left: 4, right: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 50,
              width: 60,
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                children: [
                  // CircleAvatar(
                  //   backgroundImage:
                  //       _userProvider.userInfo!.gender == 'Male'
                  //           ? const AssetImage('assets/images/man.png')
                  //           : const AssetImage(
                  //               'assets/icons/female.png',
                  //             ),
                  //   radius: 15,
                  // ),
                  CustomUserAvatar(
                    imageUrl: widget.comment.user.gender == 1
                        ? 'assets/icons/male.png'
                        : 'assets/icons/female.png',
                    userColor: widget.comment.itemColor.colorHex,
                    size: 18,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextFormField(
                      autofocus: true,
                      // onFieldSubmitted: (value) {
                      //   controller.clear();
                      // },
                      controller: replyController,
                      decoration: const InputDecoration(
                          isDense: true,
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none)),
                      style: const TextStyle(
                          color: Color(0xff121556), fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () {
                      if (replyController.text.isNotEmpty) {
                        // final MakeCommentModel makeCommentModel =
                        // MakeCommentModel(
                        //     storyId: postId, body: replyController.text);
                        // ref
                        //     .read(makeCommentProvider.notifier)
                        //     .makeComment(makeCommentModel);
                        String lang = box.read('lang');
                        replyProvider.postReplyOnComment(
                          context: context,
                          authTOKEN: box.read('userTokenForAuth'),
                          publishDate: DateFormat('yyyy-MM-ddTHH:mm:ss','en-US').format(DateTime.now()),
                          userId: box.read('userID'),
                          body: replyController.text,
                          commentId: widget.comment.comment.id,
                          storyId: widget.comment.comment.storyId,
                          language: 'en',
                          isPendingApproval: true,
                          isDeniedApproval: false,
                        )
                            .catchError((err) {
                              throw err;
                        })
                        .then((value) {
                          print('returnValue: $value');
                        });
                        replyController.clear();
                        setState(() {
                          checkReply = false;
                        });
                      } else {
                        BotToast.showText(
                          text: "No text to send!",
                          contentColor: Constants.blueColor,
                          textStyle: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        );
                      }
                    },
                    child: const Icon(
                      Icons.send,
                      color: Color(0xff121556),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> getPreviousReplies(ReplyProvider replyProvider) {
    return replyProvider.repliesOnComment!.map((e) {
      return Row(
        children: [
          Text(
            e.reply.body,
            style: TextStyle(fontSize: 13, color: Colors.black45),
          )
        ],
      );
    }).toList();
  }
}
