import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerExample extends StatefulWidget {
  const VideoPlayerExample({Key? key}) : super(key: key);

  @override
  State<VideoPlayerExample> createState() => _VideoPlayerExampleState();
}

class _VideoPlayerExampleState extends State<VideoPlayerExample> {
  late VideoPlayerController controller;
  String videoUrl = 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
  String videoUrl2 = 'https://e8c4-93-35-221-109.ngrok-free.app/video/earth.mp4';

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(videoUrl2);

    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(true);
    controller.initialize().then((_) => setState(() {}));
    controller.play();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            if (controller.value.isPlaying) {
              controller.pause();
            } else {
              controller.play();
            }
          },
          child: AspectRatio(
            aspectRatio: controller.value.aspectRatio,
            child: VideoPlayer(controller),
          ),
        ),
      ),
    );
  }
}
