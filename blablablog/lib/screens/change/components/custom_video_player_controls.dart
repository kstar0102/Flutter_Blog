import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blabloglucy/models/change_model.dart';
import 'package:blabloglucy/screens/change/full_screen_video_player/full_screen_video_player.dart';
import 'package:video_player/video_player.dart';

class ControlsOverlay extends StatefulWidget {
  const ControlsOverlay(
      {Key? key,
      required this.controller,
      required this.model,
      required this.play})
      : super(key: key);

  final ChangeModel model;
  final VideoPlayerController? controller;
  final bool play;

  @override
  State<ControlsOverlay> createState() => _ControlsOverlayState();
}

class _ControlsOverlayState extends State<ControlsOverlay> {
  @override
  void initState() {
    super.initState();

    widget.controller!.addListener(() {
      setState(() {});
    });

    if (widget.play) {
      widget.controller!.play();
      widget.controller!.setLooping(true);
    }
  }

  @override
  void didUpdateWidget(ControlsOverlay oldWidget) {
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        widget.controller!.play();
        widget.controller!.setLooping(true);
      } else {
        widget.controller!.pause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: AspectRatio(
          aspectRatio: widget.controller!.value.aspectRatio,
          child: Stack(
            children: <Widget>[
              VideoPlayer(widget.controller!),
              AnimatedSwitcher(
                duration: const Duration(milliseconds: 50),
                reverseDuration: const Duration(milliseconds: 200),
                child: widget.controller!.value.isPlaying
                    ? const SizedBox.shrink()
                    : const Align(
                        alignment: Alignment.center,
                        child: Icon(
                          Icons.play_circle_fill_rounded,
                          color: Colors.white,
                          size: 45,
                        ),
                      ),
              ),
              GestureDetector(
                onTap: () {
                  widget.controller!.value.isPlaying
                      ? widget.controller!.pause()
                      : widget.controller!.play();
                },
              ),
              Visibility(
                // visible: widget.controller!.value.isPlaying,
                child: Positioned(
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: SizedBox(
                    height: 35,
                    child: Row(
                      children: [
                        Icon(
                            widget.controller!.value.isPlaying
                                ? Icons.pause
                                : Icons.play_arrow,
                            color: Colors.white),
                        Expanded(
                          child: SliderTheme(
                            data: const SliderThemeData(
                              thumbColor: Colors.deepOrange,
                              activeTrackColor: Colors.deepOrange,
                            ),
                            child: Slider(
                              inactiveColor: Colors.black54,
                              onChanged: (v) {
                                final position = v *
                                    widget.controller!.value.duration
                                        .inMilliseconds;
                                widget.controller!.seekTo(
                                    Duration(milliseconds: position.round()));
                              },
                              value: (widget.controller?.value.duration != null)
                                  ? widget.controller!.value.position
                                          .inMilliseconds /
                                      widget.controller!.value.duration
                                          .inMilliseconds
                                  : 0.0,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            if (widget.controller!.value.volume <= 0.0) {
                              widget.controller!.setVolume(0.75);
                            } else {
                              widget.controller!.setVolume(0.0);
                            }
                          },
                          child: Icon(
                            widget.controller!.value.volume == 0.0
                                ? Icons.volume_off
                                : Icons.volume_up,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Visibility(
                // visible: widget.controller!.value.isPlaying,
                visible: false,
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    color: Colors.deepOrangeAccent,
                    child: InkWell(
                      onTap: () {
                        widget.controller!.pause();
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (builder) => FullScreenVideoPlayer(
                                  videoPath: widget.model.videoPath,
                                  play: true,
                                ),
                              ),
                            )
                            .then(
                              (value) => SystemChrome.setEnabledSystemUIMode(
                                SystemUiMode.manual,
                                overlays: SystemUiOverlay.values,
                              ),
                            );
                      },
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.fullscreen_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
