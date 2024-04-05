import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/controllers/WorkoutController.dart';
import 'package:video_player/video_player.dart';

import '../icons/my_flutter_app_icons.dart';
import '../model/Workout.dart';
import 'ui/Background.dart';

class WorkoutModPage extends StatefulWidget {
  final String url;
  final Workout workout;

  const WorkoutModPage({Key? key, required this.url, required this.workout})
      : super(key: key);

  @override
  State<WorkoutModPage> createState() => _WorkoutModPageState();
}

class _WorkoutModPageState extends State<WorkoutModPage> {
  late VideoPlayerController controller;

  _WorkoutModPageState();

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

  WorkoutController workoutController = Get.put(WorkoutController());

  late double _height;
  late double _width;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    workoutController.workout.value = widget.workout;
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Background(),
          Container(
            padding: EdgeInsets.fromLTRB(0, _height * 0.06, 0, 0),
            width: _width * 0.88,
            child: Column(
              children: [
                Container(
                  width: _width,
                  height: _height * 0.10,
                  decoration: BoxDecoration(
                      color: Colors.black54,
                      borderRadius: BorderRadius.circular(20.0)),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: _width * 0.03,
                            ),
                            InkWell(
                              onTap: () => Navigator.pop(context),
                              child: const Icon(
                                Icons.arrow_back_rounded,
                                color: Colors.red,
                              ),
                            ),
                            SizedBox(
                              width: _width * 0.3,
                            ),
                            Text(
                              '${widget.workout.name}',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(child: _areaWidget()),
                _topDownWidget()
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _topDownWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(_height * 0.01),
            child: Container(
              width: _width * 0.2,
              height: _height * 0.08,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20.0)),
              child: InkWell(

                onTap: () {  controller.value.isLooping ? controller.setLooping(false) : controller.setLooping(true);
                            controller.value.isLooping ? workoutController.setLooping(true) : workoutController.setLooping(false);
                  },
                child: Obx(() => Icon(Icons.loop, color:  workoutController.isLooping.value ? Colors.red : Colors.white, fill: 0.2)),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(_height * 0.01),
            child: Container(
              width: _width * 0.2,
              height: _height * 0.08,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20.0)),
              child: InkWell(
                // onTap: () => homeController.shuffle(),
                child: Icon(Icons.favorite, color: workoutController.workout.value.fav !=null && workoutController.workout.value.fav! ? Colors.red : Colors.white, fill: 0.2),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(_height * 0.01),
            child: Container(
              width: _width * 0.2,
              height: _height * 0.08,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20.0)),
              child: InkWell(
                // onTap: () => homeController.shuffle(),
                child: Icon(Icons.edit, color: Colors.red, fill: 0.2),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(_height * 0.01),
            child: Container(
              width: _width * 0.2,
              height: _height * 0.08,
              decoration: BoxDecoration(
                  color: Colors.black26,
                  borderRadius: BorderRadius.circular(20.0)),
              child: InkWell(
                // onTap: () => homeController.shuffle(),
                child: Icon(Icons.delete, color: Colors.red, fill: 0.2),
              ),
            ),
          ),
        ),


      ],
    );
  }


  Widget _areaWidget() {
    return Container(
      height: _height * 0.83,
      padding: EdgeInsets.symmetric(vertical: _height * 0.01),
      child: Obx(
        () => workoutController.isLoading.value
            ? Center(
                child: LoadingAnimationWidget.flickr(
                  rightDotColor: Colors.black,
                  leftDotColor: const Color(0xfffd0079),
                  size: 30,
                ),
              )
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        _width! * 0.02, _height! * 0.02, 0, 0),
                    child: Text(
                      "${widget.workout!.category!.toUpperCase()} | R: ${widget.workout!.level!} ",
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Text(
                    '${widget.workout.description}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 13,
                        // fontWeight: FontWeight.w600,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: Get.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // ...widget.workout!.targets!
                      //     .map((e) => Text('$e ',
                      //         style: const TextStyle(
                      //             fontSize: 13,
                      //             // fontWeight: FontWeight.w600,
                      //             color: Colors.white)))
                      //     .toList(),
                      Text(
                        widget.workout.targets!.isNotEmpty
                            ? '${widget.workout.targets}'
                            : '',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            fontSize: 13,
                            // fontWeight: FontWeight.w600,
                            color: Colors.white),
                      ),
                      SizedBox(
                        width: Get.width * 0.02,
                      ),
                      widget.workout!.weight!
                          ? Icon(
                              MyFlutterApp.dumbbell,
                              color: Colors.red,
                            )
                          : Container(),


                    ],
                  ),
                  SizedBox(
                    height: Get.height * 0.1,
                  ),
                  Center(
                    child: InkWell(
                      onTap: () {
                        if (controller.value.isPlaying) {
                          controller.pause();
                        } else {
                          controller.play();
                        }
                      },
                      child: Container(
                        height: 300,
                        width: 300,
                        color: Colors.red,
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            double aspectRatio =
                                controller.value.aspectRatio;
                            double containerWidth = constraints.maxWidth;
                            double containerHeight =
                                containerWidth / aspectRatio;

                            return SizedBox(
                              width: 100,
                              height: 100,
                              child: AspectRatio(
                                aspectRatio: aspectRatio,
                                child: VideoPlayer(controller),
                              ),
                            );
                          },

                        ),
                      ),
                    ),
                  )

                ],
              ),
      ),
    );
  }
}
