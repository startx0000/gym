import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/widget/old/video_test_parameter.dart';

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
        child:         Container(
          decoration: BoxDecoration(
              boxShadow: [
                  BoxShadow(blurRadius: 7,offset: const Offset(0, 7) ,color: Colors.grey[300]!)

                ],
            image: DecorationImage(
              image: NetworkImage('${homeController.connection}/video/${workout.img}'), fit: BoxFit.cover,
            ),
          ),
        ),
        // child: Container(
        //   decoration: BoxDecoration(
        //       color: Colors.white,
        //       boxShadow: [
        //         BoxShadow(blurRadius: 7,offset: const Offset(0, 7) ,color: Colors.grey[300]!)
        //
        //       ]
        //   ),
        //   margin: EdgeInsets.all(Get.height*0.01),
        //   child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.start,
        //     children: [
        //
        //       SizedBox(height: Get.height*0.01,),
        //       Center(
        //         child: Text(' ${workout.name}',
        //           style:   const TextStyle(
        //               fontWeight: FontWeight.bold,
        //               // fontSize: 12.0.sp,
        //               color: Colors.grey
        //           ),
        //         ),
        //       ),
        //       SizedBox(height: size.height*0.03,),
        //       Container(
        //         decoration: BoxDecoration(
        //           image: DecorationImage(
        //             image: NetworkImage('https://images.unsplash.com/photo-1682687220067-dced9a881b56?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTczNDd8MXwxfGFsbHwxfHx8fHx8MXx8MTY5NDI4MTA4M3w&ixlib=rb-4.0.3&q=80&w=400'), fit: BoxFit.cover,
        //           ),
        //         ),
        //       ),
        //    // Container(
        //    //  margin: const EdgeInsets.all(2),
        //    //  child: CachedNetworkImage(
        //    //    // imageUrl: '${homeController.connection}/video/${workout.img}',
        //    //    imageUrl: 'https://images.unsplash.com/photo-1682687220067-dced9a881b56?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTczNDd8MXwxfGFsbHwxfHx8fHx8MXx8MTY5NDI4MTA4M3w&ixlib=rb-4.0.3&q=80&w=400',
        //    //    imageBuilder:
        //    //        (context, imageProvider) =>
        //    //        Container(
        //    //          decoration: BoxDecoration(
        //    //            borderRadius:
        //    //            BorderRadius.circular(10),
        //    //            image: DecorationImage(
        //    //              image: imageProvider,
        //    //              fit: BoxFit.cover,
        //    //            ),
        //    //          ),
        //    //        ),
        //    //    placeholder: (context, url) =>
        //    //        Center(
        //    //          child:
        //    //          LoadingAnimationWidget.flickr(
        //    //            rightDotColor: Colors.black,
        //    //            leftDotColor:
        //    //            const Color(0xfffd0079),
        //    //            size: 25,
        //    //          ),
        //    //        ),
        //    //    errorWidget:
        //    //        (context, url, error) =>
        //    //    const Icon(
        //    //      Icons.image_not_supported_rounded,
        //    //      color: Colors.grey,
        //    //    ),
        //    //  ),              // InkWell(
        //    //    //   onTap: () => Get.to(VideoPlayerExampleParameter(workout: workout,url: '${homeController.connection}/video/${workout.video}' )),
        //    //    //   child: Text(' see video',
        //    //    //     style:   const TextStyle(
        //    //    //         fontWeight: FontWeight.bold,
        //    //    //         // fontSize: 12.0.sp,
        //    //    //         color: Colors.grey
        //    //    //     ),
        //    //    //   ),
        //    //    // ),
        //    // )
        //     ],
        //   ),
        //
        // ),
      ),
    );
  }
}
