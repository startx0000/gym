import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

import '../model/Workout.dart';

class VideoPlayerExampleParameter extends StatefulWidget {
  final String url;
  final Workout workout;
  const VideoPlayerExampleParameter({Key? key,required this.url,required this.workout}) : super(key: key);

  @override
  State<VideoPlayerExampleParameter> createState() => _VideoPlayerExampleParameterState();
}

class _VideoPlayerExampleParameterState extends State<VideoPlayerExampleParameter> {
  late VideoPlayerController controller;
  _VideoPlayerExampleParameterState();

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.network(widget.url);

    controller.addListener(() {
      setState(() {});
    });
    controller.setLooping(false);
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
      appBar: AppBar(),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: Get.height*0.05,),
          Text(
            '${widget.workout.name}',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
          SizedBox(height: Get.height*0.05,),
          Text(
            '${widget.workout.description}',
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white38),
          ),
          SizedBox(height: Get.height*0.1,),

          Center(
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
        ],
      ),
    );
  }
}
