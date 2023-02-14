import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/application/story/get/story_provider.dart';
import 'package:blabloglucy/domain/story/comments/comment_model.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/widgets/custom_user_avatar.dart';

import '../../../domain/auth/models/user_info.dart';

class CommentWidget extends HookConsumerWidget {
  final int index;
  final List<CommentModel> comments;
  final String? image;
  const CommentWidget({
    Key? key,
    required this.index,
    required this.comments,
    this.image,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    // TODO
    // final state = ref.read(storyProvider);
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
              color: Constants.commentBackgroundColor,
              borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // AvatarView(
                //   radius: 16,
                //   avatarType: AvatarType.CIRCLE,
                //   imagePath: image!,
                // ),
                CustomUserAvatar(
                  imageUrl: image!,
                  userColor: '',
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
                              comments[index].user.nickName,
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
                              comments[index].comment.publishDate,
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
                        Text(comments[index].comment.body,
                            style: TextStyle(
                              fontSize: 13,
                              color: Constants.userCommentColor,
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
                    padding: const EdgeInsets.only(right: 25, left: 25),
                    height: 36,
                    width: 48,
                    child: Icon(
                      Icons.more_vert,
                      color: Constants.vertIconColor,
                    ),
                  ),
                  itemBuilder: (context) {
                    int userId = box.read('userID');
                    log(userId.toString());
                    return <PopupMenuEntry<int>>[
                      // if (userId == comments[index].comment.userId || userId == )
                      PopupMenuItem(
                          value: 0,
                          child: InkWell(
                              onTap: () {
                                ref
                                    .read(storyProvider.notifier)
                                    .deleteComment(comments[index].comment.id);
                              },
                              child: Text(
                                  TKeys.delete_comment.translate(context)))),
                      PopupMenuItem(
                          value: 2,
                          child: GestureDetector(
                              onTap: () {
                                Navigator.popAndPushNamed(context, 'blockuser');
                              },
                              child:
                                  Text(TKeys.report_block.translate(context)))),
                    ];
                  },
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 15, top: 2),
          child: Row(
            children: [
              Image.asset(
                'assets/images/Unliked.svg',
                color: const Color(0xff19334D),
                height: 18,
              ),
              const SizedBox(
                width: 8,
              ),
              Text(
                '114',
                style: GoogleFonts.montserrat(
                  fontWeight: FontWeight.w800,
                  fontSize: 14,
                  color: const Color(0xff19334D),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                TKeys.reply_text.translate(context),
                style: GoogleFonts.montserrat(
                    fontWeight: FontWeight.w700, fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
