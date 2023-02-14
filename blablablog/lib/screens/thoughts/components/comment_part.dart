import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/application/story/get/story_provider.dart';
import 'package:blabloglucy/domain/story/comments/comment_model.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/widgets/custom_user_avatar.dart';

class CommentPart extends HookConsumerWidget {
  final int userInfo;
  final int postUserId;
  final CommentModel comments;
  const CommentPart({
    Key? key,
    required this.comments,
    required this.userInfo,
    required this.postUserId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ref) {
    return Container(
      margin: const EdgeInsets.only(top: 0, left: 5, right: 5),
      decoration: BoxDecoration(
          color: Constants.commentBackgroundColor,
          borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomUserAvatar(
              imageUrl: comments.user.gender == 1
                  ? 'assets/icons/male.png'
                  : 'assets/icons/female.png',
              userColor: comments.itemColor.colorHex,
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
                          comments.user.nickName,
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
                          comments.comment.publishDate,
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
                    Text(comments.comment.body,
                        textAlign: TextAlign.justify,
                        style: TextStyle(
                          fontSize: 14,
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
                padding: const EdgeInsets.only(right: 0, left: 2),
                height: 36,
                width: 48,
                child: Icon(
                  Icons.more_vert,
                  color: Constants.vertIconColor,
                ),
              ),
              itemBuilder: (context) {
                return <PopupMenuEntry<int>>[
                  if (userInfo != comments.user.id)
                    PopupMenuItem(
                        value: 2,
                        child: GestureDetector(
                          onTap: () {
                            Navigator.popAndPushNamed(context, 'blockuser');
                          },
                          child: Text(
                            TKeys.report_block.translate(context),
                          ),
                        )),
                  if (userInfo == comments.user.id || postUserId == userInfo)
                    PopupMenuItem(
                      onTap: () {
                        ref
                            .read(storyProvider.notifier)
                            .deleteComment(comments.comment.id);
                      },
                      value: 0,
                      child: Text(
                        TKeys.delete_comment.translate(context),
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
