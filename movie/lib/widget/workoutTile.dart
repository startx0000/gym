import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/widget/video_test_parameter.dart';

import '../controllers/HomeController.dart';
import '../model/Workout.dart';

class WorkoutTile extends StatelessWidget {
  HomeController homeController = Get.find<HomeController>();

  WorkoutTile({super.key, this.height, this.width, required this.workout});
  final double? height;
  final double? width;
  final Workout workout;
  @override
  Widget build(BuildContext context) {
    return Container(
      //   color: Colors.deepOrange,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(child: moviePoster('${homeController.connection.value}/video/benchpress.jpg')),

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
         onTap: () => Get.to(VideoPlayerExampleParameter(workout: workout,url: '${homeController.connection}/video/${workout.video}' )),

         child: Container(
           height: height,
           //width: width!*0.35,

           decoration: BoxDecoration(

             borderRadius: BorderRadius.circular(16),
             //   color: Colors.black,
               image: DecorationImage(
                   image: ResizeImage(

                       NetworkImage(
                         workout.img!=null && workout.img!.isNotEmpty ? '${homeController.connection}/video/${workout!.img!}' : posterURL

                       ),

                       width: 200,
                       height: 300))),
         ),
       );
     }
   }
   Widget rightWidget() {
     return Padding(
       padding:  EdgeInsets.fromLTRB(width!*0.01, 0, 0, 0),
       child: Container(
         height: height,
         //color: Colors.red,
         child: Column(
           mainAxisSize: MainAxisSize.max,
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.start,
           children: [
             Row(
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
                     child: Icon(Icons.add,color: Colors.red,)

                 )
               ],
             ),
             Container(
               padding: EdgeInsets.fromLTRB(width! * 0.02, height! * 0.02, 0, 0),
               child: Text(
                 "${workout!.category!.toUpperCase()} | R: ${workout!.level!} ",
                 style: TextStyle(color: Colors.white, fontSize: 12),
               ),
             ),
             Container(
               padding: EdgeInsets.fromLTRB(width! * 0.02, height! * 0.07, 0, 0),
               child: Text(
                 workout!.description!,
                 style: TextStyle(color: Colors.white70, fontSize: 10),
                 maxLines: 6,
                 overflow: TextOverflow.ellipsis,
               ),
             ),

             // Container(
             //   padding: EdgeInsets.fromLTRB(width! * 0.02, height! * 0.07, 0, 0),
             //   child: Text(
             //     workout!.targets!.toString(),
             //     style: TextStyle(color: Colors.white70, fontSize: 10),
             //     maxLines: 6,
             //     overflow: TextOverflow.ellipsis,
             //   ),
             // )
           ],
         ),
       ),
     );
   }
}
