import 'package:video_player/video_player.dart';
import 'package:flutter/material.dart';
import 'package:chewie/chewie.dart';

class VideoPlayerCustom extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;
  final double aspectRatio;
  VideoPlayerCustom({
    @required this.videoPlayerController,
    this.looping,
    this.aspectRatio,
    Key key,
  }) : super(key: key);

  @override
  VideoPlayerCustomState createState() => VideoPlayerCustomState();

  pauseVideo() {
    if (this.videoPlayerController != null) {
      if (this.videoPlayerController.value.isPlaying) {
        this.videoPlayerController.pause();
      }
    }
  }

  void dispose() {
    // IMPORTANT to dispose of all the used resources
    this.videoPlayerController.dispose();
  }
}

class VideoPlayerCustomState extends State<VideoPlayerCustom> {
  ChewieController _chewieController;
  @override
  void initState() {
    super.initState();
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: this.widget.aspectRatio,
      autoInitialize: true,
      looping: widget.looping,
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
//    widget.videoPlayerController.dispose();
//    _chewieController.dispose();
  }
}
