import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayerControls extends StatelessWidget {
  final VideoPlayerController? controller;

  const FullScreenVideoPlayerControls({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 50),
          reverseDuration: const Duration(milliseconds: 200),
          child: controller!.value.isPlaying
              ? const SizedBox.shrink()
              : Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Icon(
                      Icons.play_circle_fill_rounded,
                      color: Colors.white,
                      size: 100.0,
                      semanticLabel: 'Play',
                    ),
                  ),
                ),
        ),
        GestureDetector(
          onTap: () {
            controller!.value.isPlaying ? controller!.pause() : controller!.play();
          },
        ),
        Visibility(
          visible: controller!.value.isPlaying,
          child: controller!.value.isPlaying
              ? Positioned(
                  bottom: 0,
                  right: 4,
                  left: 0,
                  child: SizedBox(
                    height: 35,
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            child: controller?.value != null
                                ? SliderTheme(
                                    data: const SliderThemeData(
                                      thumbColor: Colors.blue,
                                      activeTrackColor: Colors.white,
                                    ),
                                    child: Slider(
                                      inactiveColor: Colors.white,
                                      onChanged: (v) {
                                        final position = v * controller!.value.duration.inMilliseconds;
                                        controller!.seekTo(Duration(milliseconds: position.round()));
                                      },
                                      value: (controller?.value.duration != null) ? controller!.value.position.inMilliseconds / controller!.value.duration.inMilliseconds : 0.0,
                                    ),
                                  )
                                : Container(),
                          ),
                        ),
                        InkWell(
                            onTap: () async {
                              // controller.setVolume(0);
                              // print("volume: ${await VolumeControl.volume}");
                              // VolumeControl.setVolume(0);

                              controller!.setVolume(controller!.value.volume == 0 ? 1 : 0);
                            },
                            child: Icon(
                              controller!.value.volume == 0 ? Icons.volume_off_outlined : Icons.volume_up_outlined,
                              color: Colors.white,
                            )),
                        /*Expanded(
                    child: Slider(
                        value: _val,
                        min: 0,
                        max: 1,
                        divisions: 100,
                        onChanged: (val) {
                          _val = val;
                          // setState(() {});
                          if (timer != null) {
                            timer?.cancel();
                          }

                          //use timer for the smoother sliding
                          timer = Timer(Duration(milliseconds: 200), () {
                            VolumeControl.setVolume(val);
                          });

                          print("val:$val");
                        }),
                  )*/
                      ],
                    ),
                  ),
                )
              : Container(),
        ),
      ],
    );
  }
}
