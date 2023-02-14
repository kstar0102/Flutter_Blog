import 'package:clean_api/clean_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get/get.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/application/story/get/create/create_story_provider.dart';
import 'package:blabloglucy/application/story/get/create/create_story_state.dart';
import 'package:blabloglucy/application/story/get/create/topic_provider.dart';
import 'package:blabloglucy/application/story/get/story_provider.dart';
import 'package:blabloglucy/domain/story/story_model.dart';
import 'package:blabloglucy/providers/story_provider.dart';
import 'package:blabloglucy/screens/thoughts/components/thought_detail_text_field.dart';
import 'package:blabloglucy/screens/thoughts/components/thought_title_textfield.dart';
import 'package:blabloglucy/screens/thoughts/controller.dart/autogenerated_background.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/widgets/custom_flushbar.dart';

// ignore: must_be_immutable
class EditThoughtPage extends HookConsumerWidget {
  StoryModel modal;
  String showDraft;
  EditThoughtPage({Key? key, required this.modal, required this.showDraft})
      : super(key: key);

  final generate = Get.find<AutoGenBackground>();

  @override
  Widget build(BuildContext context, ref) {
    StoryProvider localStoryProvider = StoryProvider();
    List<String> routes = ['myPublishedStories'];
    bool notShowDraftButton = routes.contains(showDraft);
    // TODO
    // final topics = ref.watch(topicProvider);
    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        ref.read(topicProvider.notifier).getTopics();

        debugPrint('Circle ok');
        return const Center(
          child: CircularProgressIndicator(),
        );
      });
      return null;
    }, []);
    final TextEditingController titleController = useTextEditingController();
    final TextEditingController thoughtsController = useTextEditingController();
    // TODO
    // final commentStatus = useState(1);

    useEffect(() {
      Future.delayed(const Duration(milliseconds: 100), () {
        titleController.text = modal.story.title;
        thoughtsController.text =
            modal.story.body.replaceAll('<p>', '').replaceAll('</p>', '');
      });
      return null;
    }, []);
    final isLoading = useState(false);
    // TODO
    // bool isLoad = false;
    // final ValueNotifier topic = useState(null);

    ref.listen<CreateStoryState>(createStoryProvider, (previous, next) {
      debugPrint('Kuch Bhi');
      if (previous?.loading != true && next.loading) {
        debugPrint('Fist if');
        isLoading.value = true;
      } else if (previous?.loading == true && !next.loading) {
        isLoading.value = false;
        debugPrint('Fist else if');
      }
      if (next.failure != CleanFailure.none()) {
        debugPrint('Second if');
        // Navigator.pop(context);
      }
      if (!next.loading && next.failure == CleanFailure.none()) {
        ref.read(storyProvider.notifier).getStories();
        Navigator.pop(context);
        isLoading.value = false;
        debugPrint('Last if');
      }
    });

    return Scaffold(
      body: Column(
        children: [
          isLoading.value == true
              ? const SafeArea(
                  child: Center(
                    child: LinearProgressIndicator(
                      color: Color(0xff19334D),
                      minHeight: 2,
                      backgroundColor: Colors.white,
                    ),
                  ),
                )
              : SafeArea(
                  child: Container(
                  height: 70,
                  color: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          generate.generate(0);
                          Navigator.pop(context);
                        },
                        child: const Icon(
                          Icons.arrow_back_ios,
                          size: 27,
                          color: Color(0xff19334D),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: () {
                            if (titleController.text.isEmpty) {
                              showFlushBar(context,
                                  TKeys.title_should.translate(context));
                            } else if (thoughtsController.text.length > 3000) {
                              showFlushBar(context,
                                  TKeys.ToughtsPostLimit.translate(context));
                            } else if (titleController.text.length < 5) {
                              showFlushBar(context,
                                  TKeys.title_should.translate(context));
                            } else if (titleController.text.length > 25) {
                              showFlushBar(context,
                                  TKeys.title_should.translate(context));
                            } else if (thoughtsController.text.isEmpty) {
                              showFlushBar(
                                  context,
                                  TKeys.minimum_for_personal
                                      .translate(context));
                            } else if (thoughtsController.text.length < 300) {
                              showFlushBar(
                                  context,
                                  TKeys.minimum_for_personal
                                      .translate(context));
                            } else {
                              isLoading.value = true;
                              localStoryProvider
                                  .createStory(
                                context: context,
                                consultGroup: titleController.value.text,
                                storyBody: thoughtsController.text,
                                image: localStoryProvider.consultImage.first,
                                storyStatus: 2,
                                isEditMode: true,
                              )
                                  .whenComplete(() {
                                debugPrint('controller data ');
                                debugPrint(titleController.value.text);
                                debugPrint(thoughtsController.value.text);
                                isLoading.value = false;
                              });
                            }
                          },
                          child: Text(
                            TKeys.Save_as.translate(context),
                            style: TextStyle(
                                color: notShowDraftButton
                                    ? Colors.transparent
                                    : Constants.editTextColor,
                                fontSize: 14,
                                fontFamily: Constants.fontFamilyName),
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          debugPrint('object');
                          if (titleController.text.isEmpty) {
                            showFlushBar(
                                context, TKeys.title_should.translate(context));
                          } else if (titleController.text.length < 5) {
                            showFlushBar(
                                context, TKeys.title_should.translate(context));
                          } else if (titleController.text.length > 25) {
                            showFlushBar(
                                context, TKeys.title_should.translate(context));
                          } else if (thoughtsController.text.isEmpty) {
                            showFlushBar(context,
                                TKeys.minimum_for_personal.translate(context));
                          } else if (thoughtsController.text.length < 300) {
                            showFlushBar(context,
                                TKeys.minimum_for_personal.translate(context));
                          } else {
                            isLoading.value = true;
                            localStoryProvider
                                .createStory(
                                    context: context,
                                    consultGroup: titleController.value.text,
                                    storyBody: thoughtsController.text,
                                    image:
                                        localStoryProvider.consultImage.first,
                                    storyStatus: 0,
                                    isEditMode: true)
                                .whenComplete(() {
                              debugPrint('controller data ');
                              debugPrint(titleController.value.text);
                              debugPrint(thoughtsController.value.text);
                              isLoading.value = false;
                            });
                          }
                        },
                        child: Text(
                          TKeys.Publish_text.translate(context),
                          style: TextStyle(
                            color: Constants.blueColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: Constants.fontFamilyName,
                          ),
                        ),
                      ),
                    ],
                  ),
                )),
          Expanded(
            flex: 1,
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 5),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Constants.editTextBackgroundColor,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: const EdgeInsets.only(top: 10, left: 10),
                        height: 50,
                        width: 200,
                        child: ThoughtTitleTextField(
                          textEditingController: titleController,
                          isEnabled: false,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 15.0, left: 5, right: 5),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Constants.editTextBackgroundColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ThoughtDetailTextField(
                                  textEditingController: thoughtsController,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
