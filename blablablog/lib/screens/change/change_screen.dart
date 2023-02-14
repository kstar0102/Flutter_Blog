import 'package:flutter/material.dart';
import 'package:blabloglucy/Localization/t_keys.dart';
import 'package:blabloglucy/models/change_model.dart';
import 'package:blabloglucy/screens/change/components/custom_video_player.dart';

class ChangeScreen extends StatefulWidget {
  const ChangeScreen({Key? key}) : super(key: key);

  @override
  State<ChangeScreen> createState() => _ChangeScreenState();
}

class _ChangeScreenState extends State<ChangeScreen> {
  @override
  Widget build(BuildContext context) {
    List<ChangeModel> videos = [
      ChangeModel(
        TKeys.aChange_VideoA_Presentor.translate(context),
        TKeys.aChange_VideoA.translate(context),
        'assets/videos/VideoA.mp4',
      ),

      ChangeModel(
        TKeys.aChange_VideoB_Presentor.translate(context),
        TKeys.aChange_VideoB.translate(context),
        'assets/videos/VideoB.mp4',
      ),
      ChangeModel(
        TKeys.aChange_VideoC_Presentor.translate(context),
        TKeys.aChange_VideoC.translate(context),
        'assets/videos/VideoC.mp4',
      ),
      ChangeModel(
        TKeys.aChange_VideoD_Presentor.translate(context),
        TKeys.aChange_VideoD.translate(context),
        'assets/videos/VideoD.mp4',
      ),

      // ChangeModel("Alive Johan 01:02", "Find Peace", Constant.videoPath),
    ];

    Column(
      children: [
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                    color: Colors.white,
                    child: Card(
                      color: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      semanticContainer: true,
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          CustomVideoPlayer(
                            play: false,
                            model: videos[0],
                          ),
                        ],
                      ),
                    )),
              ),
              Expanded(
                child: Container(
                    color: Colors.white,
                    child: Card(
                      color: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      semanticContainer: true,
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          CustomVideoPlayer(
                            play: false,
                            model: videos[1],
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: Container(
                    color: Colors.white,
                    child: Card(
                      color: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      semanticContainer: true,
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          CustomVideoPlayer(
                            play: false,
                            model: videos[2],
                          ),
                        ],
                      ),
                    )),
              ),
              Expanded(
                child: Container(
                    color: Colors.white,
                    child: Card(
                      color: Colors.black,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(15),
                        ),
                      ),
                      semanticContainer: true,
                      clipBehavior: Clip.antiAlias,
                      child: Stack(
                        children: [
                          CustomVideoPlayer(
                            play: false,
                            model: videos[3],
                          ),
                        ],
                      ),
                    )),
              ),
            ],
          ),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          ...videos.asMap().entries.map(
            (e) {
              return CustomVideoPlayer(
                play: false,
                model: videos[e.key],
              );
            },
          )
        ],
      ),
    );
  }
}
