import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/widget/video_test_parameter.dart';

import '../controllers/HomeController.dart';
import '../model/Workout.dart';

class CardWorkout extends StatelessWidget {
  final Workout workout;
  final Size size;
  CardWorkout({super.key,required this.workout,required this.size});
  HomeController homeController = Get.find<HomeController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.all( Get.height*0.01),
      child: InkWell(
        onTap: () => Get.to(VideoPlayerExampleParameter(workout: workout,url: '${homeController.connection}/video/${workout.video}' )),

        child: Container(
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [
                BoxShadow(blurRadius: 7,offset: const Offset(0, 7) ,color: Colors.grey[300]!)

              ]
          ),
          margin: EdgeInsets.all(Get.height*0.01),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: Get.height*0.01,),
              Center(
                child: Text(' ${workout.name}',
                  style:   const TextStyle(
                      fontWeight: FontWeight.bold,
                      // fontSize: 12.0.sp,
                      color: Colors.grey
                  ),
                ),
              ),
              SizedBox(height: size.height*0.04,),
              // InkWell(
              //   onTap: () => Get.to(VideoPlayerExampleParameter(workout: workout,url: '${homeController.connection}/video/${workout.video}' )),
              //   child: Text(' see video',
              //     style:   const TextStyle(
              //         fontWeight: FontWeight.bold,
              //         // fontSize: 12.0.sp,
              //         color: Colors.grey
              //     ),
              //   ),
              // ),
            ],
          ),

        ),
      ),
    );
  }
}
