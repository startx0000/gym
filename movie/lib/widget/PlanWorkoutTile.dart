import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/model/Exercise.dart';
import 'package:movie/widget/UploadPage.dart';
import 'package:movie/widget/WorkoutModPage.dart';
import 'package:movie/widget/old/video_test_parameter.dart';

import '../controllers/HomeController.dart';
import '../controllers/PlanController.dart';
import '../model/Workout.dart';

class PlanWorkoutTile extends StatelessWidget {
  PlanController planController = Get.find<PlanController>();
  HomeController homeController = Get.find<HomeController>();

  PlanWorkoutTile({super.key, this.height, this.width, required this.workout});

  final double? height;
  final double? width;
  final Exercise workout;

  @override
  Widget build(BuildContext context) {
    return Container(
        //   color: Colors.deepOrange,
        child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: moviePoster(
                '${homeController.connection.value}/video/benchpress.jpg')),
        Expanded(
          child: rightWidget(),
          flex: 2,
        )
      ],
    ));
  }

  Widget moviePoster(String posterURL) {
    {
      return InkWell(
        onTap: () => Get.to(WorkoutModPage(
            workout: workout.workout,
            url:
                '${homeController.connection}/video/${workout.workout.video}')),
        // onTap: () => Get.to(VideoPlayerExampleParameter(workout: workout,url: '${homeController.connection}/video/${workout.video}' )),

        child: Container(
          height: height,
          //width: width!*0.35,

          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              //   color: Colors.black,
              image: DecorationImage(
                  image: ResizeImage(
                      NetworkImage(workout.workout.img != null &&
                              workout.workout.img!.isNotEmpty
                          ? '${homeController.connection}/video/${workout.workout!.img!}'
                          : posterURL),
                      width: 200,
                      height: 300))),
        ),
      );
    }
  }

  Widget rightWidget() {
    return Padding(
      padding: EdgeInsets.fromLTRB(width! * 0.01, 0, 0, 0),
      child: Container(
        height: height,
        //color: Colors.red,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(width! * 0.02, height! * 0.01, 0, 0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                      child: Text(
                        workout!.name!,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                  ),
                  Expanded(
                      child: workout.status == "complete"
                          ? Icon(Icons.done_all, color: Colors.red)
                          : Icon(Icons.incomplete_circle_rounded,
                              color: Colors.white))
                ],
              ),
            ),
            // Container(
            //   padding: EdgeInsets.fromLTRB(width! * 0.02, height! * 0.07, 0, 0),
            //   child: Column(
            //       children: workout.sets.map((e) => Container(
            //         child: Row(
            //           children: [
            //             Text(
            //               e.rest!=null ? "Rest ${e.rest}" :"",
            //               style: TextStyle(color: Colors.white70, fontSize: 10),
            //               maxLines: 6,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //             Text(
            //               e.weight!=null ? "Weight ${e.weight}" :"",
            //               style: TextStyle(color: Colors.white70, fontSize: 10),
            //               maxLines: 6,
            //               overflow: TextOverflow.ellipsis,
            //             ),                        Text(
            //               e.rep!=null ? "Rep ${e.rep}" :"",
            //               style: TextStyle(color: Colors.white70, fontSize: 10),
            //               maxLines: 6,
            //               overflow: TextOverflow.ellipsis,
            //             ),
            //
            //
            //           ],
            //         ),
            //
            //
            //       )).toList()
            //   ),
            //
            // ),
            Container(
              padding: EdgeInsets.fromLTRB(width! * 0.02, height! * 0.07, 0, 0),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: workout.sets.length,
                itemBuilder: (BuildContext context, int index) {
                  final e = workout.sets[index];
                  return Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Set ${index + 1}',
                          style: TextStyle(color: Colors.white70, fontSize: 10),
                          maxLines: 6,
                          overflow: TextOverflow.ellipsis,
                        ),
                        if (e.rest != null && e.rest != 0)
                          Text(
                            e.rest != null && e.rest != 0
                                ? "Rest ${e.rest} s"
                                : "",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 10),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (e.weight != null && e.weight != 0)
                          Text(
                            e.weight != null && e.weight != 0
                                ? "Weight ${e.weight} kg"
                                : "",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 10),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (e.rep != null && e.rep != 0)
                          Text(
                            e.rep != null && e.rep != 0 ? "Rep ${e.rep}" : "",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 10),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        if (e.time != null && e.time != 0)
                          Text(
                            e.time != null && e.time != 0
                                ? "Time ${e.time} s"
                                : "",
                            style:
                                TextStyle(color: Colors.white70, fontSize: 10),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Container(
                padding:
                    EdgeInsets.fromLTRB(width! * 0.02, height! * 0.07, 0, 0),
                child: workout.rest != null && workout.rest != 0
                    ? Text(
                        "Rest after complete ${workout.rest.toString()} s",
                        style: TextStyle(color: Colors.white70, fontSize: 10),
                        maxLines: 6,
                        overflow: TextOverflow.ellipsis,
                      )
                    : Container()),
            Expanded(
              child: Container(
                padding:
                    EdgeInsets.fromLTRB(width! * 0.02, height! * 0.07, 0, 0),
                child: InkWell(
                  // onTap: () => Get.to(PlanPage()),
                  onTap: () async {
                    Get.dialog(
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 40),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(20),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Material(
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 10),
                                       Text(
                                        workout.name,
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 15),
                                      const Text(
                                        "Message Text",
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 20),
                                      //Buttons
                                      Row(
                                        children: [
                                          Expanded(
                                            child: ElevatedButton(
                                              child: const Text(
                                                'NO',
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: const Size(0, 45),
                                                primary: Colors.amber,
                                                onPrimary: const Color(0xFFFFFFFF),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: ElevatedButton(
                                              child: const Text(
                                                'YES',
                                              ),
                                              style: ElevatedButton.styleFrom(
                                                minimumSize: const Size(0, 45),
                                                primary: Colors.amber,
                                                onPrimary: const Color(0xFFFFFFFF),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(8),
                                                ),
                                              ),
                                              onPressed: () {},
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );

                  },

                  child: Icon(Icons.edit, color: Colors.red, fill: 0.2),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
