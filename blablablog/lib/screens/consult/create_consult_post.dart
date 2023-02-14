import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/providers/story_provider.dart';
import 'package:blabloglucy/screens/consult/components/create_consult_post_textfield.dart';
import 'package:blabloglucy/utills/constant.dart';
import 'package:blabloglucy/widgets/custom_flushbar.dart';

class CreateConsultScreen extends StatefulWidget {
  const CreateConsultScreen({
    Key? key,
    required this.consultGroupName,
    required this.image,
  }) : super(key: key);

  final String consultGroupName;
  final String image;

  @override
  State<CreateConsultScreen> createState() => _CreateConsultScreenState();
}

class _CreateConsultScreenState extends State<CreateConsultScreen> {
  TextEditingController postController = TextEditingController();

  Future<void> _showDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(TKeys.do_you_want.translate(context),
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                Navigator.of(context).pop();
              },
              child: Text(TKeys.discard_post.translate(context),
                  style: const TextStyle(color: Colors.redAccent)),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(ctx).pop();
              },
              child: Text(TKeys.continue_to_write.translate(context),
                  style: const TextStyle(color: Colors.black)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    StoryProvider storyProvider = Provider.of<StoryProvider>(context);
    return WillPopScope(
      onWillPop: () async {
        if (postController.text.isNotEmpty) {
          await _showDialog(context);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            SafeArea(
                child: Container(
              height: 70,
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  InkWell(
                    onTap: () async {
                      if (postController.text.isNotEmpty) {
                        await _showDialog(context);
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                    child: const Icon(
                      Icons.arrow_back_ios,
                      color: Color(0xff19334D),
                      size: 27,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      if (postController.text.length < 25) {
                        showFlushBar(
                          context,
                          TKeys.minimum_for_post.translate(context),
                        );
                      } else if (postController.text.length > 3000) {
                        showFlushBar(
                            context, TKeys.ConsultPostLimit.translate(context));
                      } else {
                        storyProvider.createStory(
                            context: context,
                            image: widget.image,
                            storyBody: postController.text,
                            consultGroup: widget.consultGroupName,
                            isEditMode: false,
                            storyStatus: 0,
                            whichPage: 'jkdjk');
                      }
                    },
                    child: Text(
                      TKeys.Publish_text.translate(context),
                      style: TextStyle(
                        color: const Color(0xff19334D),
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
                  padding: const EdgeInsets.only(bottom: 8, left: 8, right: 8),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Constants.editTextBackgroundColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: CreateConsultPostTextField(
                            textEditingController: postController,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
