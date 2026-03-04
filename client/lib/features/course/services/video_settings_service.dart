import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:mbschool/core/common/widgets/loader.dart';
import 'package:mbschool/core/constants/colors.dart';
import 'package:video_player/video_player.dart';

class VideoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool isLoop;
  const VideoPlayer(
      {super.key, required this.videoPlayerController, required this.isLoop});

  @override
  State<VideoPlayer> createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayer> {
  ChewieController? chewieController;
  @override
  void initState() {
    chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      looping: widget.isLoop,
      aspectRatio: 16 / 9,
      autoInitialize: true,
    );
    super.initState();
  }

  @override
  void dispose() {
    chewieController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Chewie(
        controller: chewieController!,
      ),
    );
  }
}

class VideoDisplay extends StatefulWidget {
  final String videoUrl;
  const VideoDisplay({super.key, required this.videoUrl});

  @override
  State<VideoDisplay> createState() => _VideoDisplayState();
}

class _VideoDisplayState extends State<VideoDisplay> {
  late VideoPlayerController controller;
  ChewieController? chewieController;
  Future<void> loadVideoPlayer() async {
    controller = VideoPlayerController.networkUrl(Uri.parse(widget.videoUrl));
    await Future.wait([controller.initialize()]);

    chewieController = ChewieController(
      videoPlayerController: controller,
      autoPlay: true,
      looping: true,
    );

    setState(() {});
  }

  @override
  void initState() {
    loadVideoPlayer();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
    chewieController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: textBlack,
      appBar: AppBar(
        backgroundColor: textBlack,
      ),
      body: chewieController != null &&
              chewieController!.videoPlayerController.value.isInitialized
          ? Chewie(controller: chewieController!)
          : const Loader(),
    );
  }
}