import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:blabloglucy/models/change_model.dart';
import 'package:video_player/video_player.dart';

import 'custom_video_player_controls.dart';

class CustomVideoPlayer extends StatefulWidget {
  final ChangeModel model;
  final bool play;

  const CustomVideoPlayer({Key? key, required this.model, required this.play})
      : super(key: key);

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    // _controller = VideoPlayerController.network(widget.url);
    _controller = VideoPlayerController.asset(widget.model.videoPath);
    _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });
  }

  @override
  void dispose() {
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ControlsOverlay(
              controller: _controller,
              model: widget.model,
              play: widget.play,
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: SizedBox(
          height: 120,
          child: Row(
            children: [
              FutureBuilder(
                future: _initializeVideoPlayerFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.done) {
                    return SizedBox(
                      width: 180,
                      height: 120,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          VideoPlayer(_controller!),
                          const Icon(
                            Icons.play_circle_fill_rounded,
                            color: Colors.white,
                            size: 45,
                          ),
                          // ControlsOverlay(
                          //   controller: _controller,
                          //   model: widget.model,
                          // ),
                        ],
                      ),
                    );
                  } else {
                    return const SizedBox(
                      width: 180,
                      height: 120,
                      child: Center(
                        child: SpinKitFadingFour(
                          size: 60,
                          color: Color(0xff52527a),
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                        '${widget.model.author} ${formatTime(_controller?.value.duration.inSeconds ?? 0)}'),
                    const Spacer(flex: 1),
                    Text(
                      widget.model.description,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const Spacer(flex: 2),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _likedItems('assets/images/Unliked.svg', '152'),
                        _likedItems('assets/images/comment_outlined.svg', '23'),
                        _likedItems(
                            'assets/images/StoryViewsCounter.svg', '23'),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  _likedItems(String iconPath, String count) {
    return Row(
      children: [
        SvgPicture.asset(iconPath, width: 16, height: 16),
        const SizedBox(width: 3),
        Text(count,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold))
      ],
    );
  }

  formatTime(int time) {
    int sec = time % 60;
    int min = (time / 60).floor();
    String minute = min.toString().length <= 1 ? '0$min' : '$min';
    String second = sec.toString().length <= 1 ? '0$sec' : '$sec';
    return '$minute:$second';
  }
}
