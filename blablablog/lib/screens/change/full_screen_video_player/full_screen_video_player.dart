import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:blabloglucy/screens/change/full_screen_video_player/full_screen_video_player_controls.dart';
import 'package:video_player/video_player.dart';

class FullScreenVideoPlayer extends StatefulWidget {
  final String videoPath;
  final bool play;

  const FullScreenVideoPlayer(
      {Key? key, required this.videoPath, required this.play})
      : super(key: key);

  @override
  State<FullScreenVideoPlayer> createState() => _FullScreenVideoPlayerState();
}

class _FullScreenVideoPlayerState extends State<FullScreenVideoPlayer> {
  VideoPlayerController? _controller;
  Future<void>? _initializeVideoPlayerFuture;

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.manual,
      overlays: [SystemUiOverlay.bottom],
    );
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    super.initState();
    // _controller = VideoPlayerController.network(widget.url);
    _controller = VideoPlayerController.asset(widget.videoPath);
    _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
      // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
      setState(() {});
    });

    _controller!.addListener(() {
      setState(() {});
    });

    if (widget.play) {
      _controller!.play();
      _controller!.setLooping(true);
    }
  }

  @override
  void didUpdateWidget(FullScreenVideoPlayer oldWidget) {
    if (oldWidget.play != widget.play) {
      if (widget.play) {
        _controller!.play();
        _controller!.setLooping(true);
      } else {
        _controller!.pause();
      }
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    _controller!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = _controller!.value.size;
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: FutureBuilder(
          future: _initializeVideoPlayerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              return Stack(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.width,
                    child: FittedBox(
                        alignment: Alignment.center,
                        fit: BoxFit.fitHeight,
                        child: SizedBox(
                            width: size.width,
                            height: size.height,
                            child: VideoPlayer(_controller!))),
                  ),
                  FullScreenVideoPlayerControls(
                    controller: _controller,
                    // model: widget.model,
                  ),
                  InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      ),
    );
  }
}
