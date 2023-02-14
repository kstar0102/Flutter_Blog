import 'package:another_flushbar/flushbar.dart';
import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:provider/provider.dart' as provider;
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/application/story/make_comment/make_comment_provider.dart';
import 'package:blabloglucy/application/story/make_comment/make_comment_state.dart';
import 'package:blabloglucy/domain/story/comments/comment_model.dart';
import 'package:blabloglucy/domain/story/comments/make_comment.dart';
import 'package:blabloglucy/domain/story/story_model.dart';
import 'package:blabloglucy/providers/story_provider.dart';
import 'package:blabloglucy/providers/user_provider.dart';
import 'package:blabloglucy/widgets/custom_user_avatar.dart';
import 'package:blabloglucy/widgets/user_comment.dart';

// ignore: must_be_immutable
class CommentScreen extends HookConsumerWidget {
  final int postId;
  final List<CommentModel>? comments;
  StoryModel? storyModel;
  final String route;
  String? male;
  String? color;
  CommentScreen(
      {Key? key,
      this.storyModel,
      required this.comments,
      required this.postId,
      required this.route,
      this.male,
      this.color})
      : super(key: key);

  var box1 = GetStorage();

  List<bool> replies = [];

  @override
  Widget build(BuildContext context, ref) {
    Logger.w(box1.read('userID'));
    StoryProvider storyProvider = provider.Provider.of<StoryProvider>(context);
    final controller = useTextEditingController();
    // TODO
    // final replyController = useTextEditingController();
    int pageNumber = 0;
    ScrollController scrollController = useMemoized(() => ScrollController());
    useEffect(() {
      var box = GetStorage();
      Logger.e(box.read('userTokenForAuth'));
      storyProvider
          .getSingleStoryComments(
              context: context,
              pageNumber: pageNumber,
              storyId: postId,
              authTOKEN: box.read('userTokenForAuth'))
          .then((value) {
        Logger.w(value!.length);
      });

      scrollController.addListener(() {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          pageNumber++;

          storyProvider.getSingleStoryComments(
              context: context,
              pageNumber: pageNumber,
              storyId: postId,
              authTOKEN: box.read('userTokenForAuth'));
        }
      });
      return () {
        scrollController.dispose();
      };
    }, []);
    ref.listen<MakeCommentState>(makeCommentProvider, ((previous, next) {
      if (!next.loading && next.failure == CleanFailure.none()) {
        showFlushBar(context, TKeys.comment_pending.translate(context));
        // ref.read(storyProvider.notifier).getStories();
      }
    }));

    UserProvider userProvider = provider.Provider.of<UserProvider>(context);

    var box = GetStorage();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: SvgPicture.asset('assets/images/reply_back.svg'),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          FutureBuilder(
            future: storyProvider.getSingleStoryComments(
              context: context,
            ),
            builder: (c, AsyncSnapshot<List<CommentModel>?> snapshot) {
              if (snapshot.hasData) {
                Logger.w(snapshot.data);
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  return Expanded(
                    child: StatefulBuilder(builder: (context, setState) {
                      return Column(
                        children: [
                          Expanded(
                            child: ListView.builder(
                              controller: scrollController,
                              itemCount:
                                  storyProvider.singleStoryComments!.length + 1,
                              itemBuilder: (context, index) {
                                if (index <
                                    storyProvider.singleStoryComments!.length) {
                                  return Padding(
                                    padding: EdgeInsets.only(
                                        left: 10,
                                        right: 10,
                                        bottom: 15,
                                        top: index == 0 ? 30 : 0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        UserCommentCard(
                                          comment: storyProvider
                                              .singleStoryComments![index],
                                          storyUserId:
                                              storyModel!.story.id.toString(),
                                          myID: box.read('userID'),
                                          deleteCommentCallBack: () {
                                            userProvider.deleteComment(
                                              context: context,
                                              commentId: storyProvider
                                                  .singleStoryComments![index]
                                                  .comment
                                                  .id,
                                            );

                                            storyProvider.singleStoryComments!
                                                .removeAt(index);
                                            storyProvider
                                                .changeSingleStoryComments(
                                              singleStoryComments: storyProvider
                                                  .singleStoryComments!,
                                            );
                                          },
                                          route: '/comment',
                                        ),
                                        /*  Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 10),
                                            child: GestureDetector(
                                              onTap: () {
                                               for(int i = 0; i < _storyProvider.singleStoryComments!.length; i++){
                                                 _storyProvider.singleStoryComments![i].showInput = false;
                                               }
                                                _storyProvider.singleStoryComments![index].showInput = true;
                                                setState((){

                                                });

                                              },
                                              child: _storyProvider.singleStoryComments![index].showInput! ? Row(
                                                crossAxisAlignment: CrossAxisAlignment.end,
                                                children: [
                                                  Expanded(
                                                    child: Container(
                                                      padding: const EdgeInsets.symmetric(horizontal: 0),
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
                                                            imageUrl: male == 'Male'
                                                                ? "assets/icons/male.png"
                                                                : 'assets/icons/female.png',
                                                            userColor: color!,
                                                          ),
                                                          const SizedBox(
                                                            width: 0,
                                                          ),
                                                          box.read('lang') == 'he' ? Expanded(
                                                            child: TextFormField(
                                                              autofocus: true,
                                                              // onFieldSubmitted: (value) {
                                                              //   controller.clear();
                                                              // },
                                                              controller: replyController,
                                                              decoration: const InputDecoration(
                                                                  isDense: true,
                                                                  hintText: 'השב לתגובה',
                                                                  border: OutlineInputBorder(
                                                                      borderSide: BorderSide.none)),
                                                              style: const TextStyle(
                                                                  color: Color(0xff121556), fontSize: 14),
                                                            ),
                                                          ) :  Expanded(
                                                            child: TextFormField(
                                                              autofocus: true,
                                                              // onFieldSubmitted: (value) {
                                                              //   controller.clear();
                                                              // },
                                                              controller: replyController,
                                                              decoration: const InputDecoration(
                                                                  isDense: true,
                                                                  hintText: 'Reply the Comment',
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
                                                                final MakeCommentModel makeCommentModel =
                                                                MakeCommentModel(
                                                                    storyId: postId, body: replyController.text);
                                                                ref
                                                                    .read(makeCommentProvider.notifier)
                                                                    .makeComment(makeCommentModel);
                                                                replyController.clear();
                                                                setState((){
                                                                  _storyProvider.singleStoryComments![index].showInput = false;
                                                                });
                                                              }

                                                            },
                                                            child: Padding(
                                                              padding: const EdgeInsets.symmetric(horizontal: 10),
                                                              child: const Icon(
                                                                Icons.send,
                                                                color: Color(0xff121556),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ) :
                                              Text(
                                                TKeys.replyText.translate(context),
                                                style: TextStyle(
                                                  fontSize: 13,
                                                  color: const Color(0xff132952),
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: Constants.fontFamilyName,
                                                ),
                                              ),
                                            ),
                                          ),*/
                                      ],
                                    ),
                                  );
                                } else {
                                  Logger.w(
                                      'is all comment loaded ${storyProvider.isAllCommentsLoaded}');
                                  return storyProvider.isAllCommentsLoaded
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
                      );
                    }),
                  );
                } else {
                  return const Expanded(
                    child: Center(
                      child: Text(
                        'Be the first to comment',
                      ),
                    ),
                  );
                }
              } else {
                return Expanded(
                  child: Transform.scale(
                    scale: 1.5,
                    child: const Center(
                      child: SpinKitFadingFour(
                        size: 40,
                        color: Color(0xff52527a),
                      ),
                    ),
                  ),
                );
              }
            },
          ),
          // const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 4, left: 4, right: 4),
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
                          imageUrl: male == 'Male'
                              ? 'assets/icons/male.png'
                              : 'assets/icons/female.png',
                          userColor: color!,
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
                            controller: controller,
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
                            if (controller.text.isNotEmpty) {
                              final MakeCommentModel makeCommentModel =
                                  MakeCommentModel(
                                      storyId: postId, body: controller.text);
                              ref
                                  .read(makeCommentProvider.notifier)
                                  .makeComment(makeCommentModel);
                              controller.clear();
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
          ),
        ],
      ),
    );
  }

//FlushBar widget
  void showFlushBar(BuildContext context, String title) {
    Flushbar(
      isDismissible: true,
      messageSize: 16,
      messageText: Text(
        title,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      backgroundColor: const Color(0xff121556),
      flushbarPosition: FlushbarPosition.TOP,
      duration: const Duration(milliseconds: 1500),
    ).show(context);
  }


}
