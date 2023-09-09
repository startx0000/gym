import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/controllers/HomeController.dart';
import 'package:movie/widget/bar.dart';

import '../model/Workout.dart';
import 'cardWorkout.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  HomeController homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.red,
        body: Container(
          child: Column(
            children: [
              Padding(
                  padding: EdgeInsets.only(
                      bottom: 0, left: 0, right: 0, top: size.height * 0.05)),
              Center(
                child: Obx(
                  ()=> Text(
                    ' ${homeController.title}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: 0, left: 0, right: 0, top: size.height * 0.05)),
              Container(height: size.height * 0.05,width: size.width*0.98,child: Bar(size: size)),
              Padding(
                  padding: EdgeInsets.only(
                      bottom: 0, left: 0, right: 0, top: size.height * 0.05)),
              Container(height: size.height * 0.65,width: size.width*0.98,
                  child: Obx(
                        () => homeController.isLoading.value
                        ? Center(
                      child: LoadingAnimationWidget.flickr(
                        rightDotColor: Colors.black,
                        leftDotColor: const Color(0xfffd0079),
                        size: 30,
                      ),
                    )
                        :
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const ClampingScrollPhysics(),
                              children: [
                                ...homeController.workouts.map((element) => CardWorkout(workout: element, size: size)),
                                CardWorkout(size:size,workout: Workout(name: "tedi", category: "s", video: "s", weight: false, level: "s", description: "asdsadsas",img: "https://images.unsplash.com/photo-1682685796852-aa311b46f50d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTczNDd8MXwxfGFsbHwxfHx8fHx8MXx8MTY5NDE5Mzc2Nnw&ixlib=rb-4.0.3&q=80&w=400")),
                                CardWorkout(size:size,workout: Workout(name: "tedi", category: "s", video: "s", weight: false, level: "s", description: "sadasd",img: "https://images.unsplash.com/photo-1682685796852-aa311b46f50d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTczNDd8MXwxfGFsbHwxfHx8fHx8MXx8MTY5NDE5Mzc2Nnw&ixlib=rb-4.0.3&q=80&w=400")),
                                CardWorkout(size:size,workout: Workout(name: "tedi", category: "s", video: "s", weight: false, level: "s", description: "s",img: "https://images.unsplash.com/photo-1682685796852-aa311b46f50d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTczNDd8MXwxfGFsbHwxfHx8fHx8MXx8MTY5NDE5Mzc2Nnw&ixlib=rb-4.0.3&q=80&w=400")),
                                CardWorkout(size:size,workout: Workout(name: "tedi", category: "s", video: "s", weight: false, level: "s", description: "ssad",img: "https://images.unsplash.com/photo-1682685796852-aa311b46f50d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTczNDd8MXwxfGFsbHwxfHx8fHx8MXx8MTY5NDE5Mzc2Nnw&ixlib=rb-4.0.3&q=80&w=400")),
                                CardWorkout(size:size,workout: Workout(name: "tedi", category: "s", video: "s", weight: false, level: "s", description: "s",img: "https://images.unsplash.com/photo-1682685796852-aa311b46f50d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTczNDd8MXwxfGFsbHwxfHx8fHx8MXx8MTY5NDE5Mzc2Nnw&ixlib=rb-4.0.3&q=80&w=400")),
                                CardWorkout(size:size,workout: Workout(name: "tedi", category: "s", video: "s", weight: false, level: "s", description: "sasdsa",img: "https://images.unsplash.com/photo-1682685796852-aa311b46f50d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTczNDd8MXwxfGFsbHwxfHx8fHx8MXx8MTY5NDE5Mzc2Nnw&ixlib=rb-4.0.3&q=80&w=400")),
                                CardWorkout(size:size,workout: Workout(name: "tedi", category: "s", video: "s", weight: false, level: "s", description: "s",img: "https://images.unsplash.com/photo-1682685796852-aa311b46f50d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTczNDd8MXwxfGFsbHwxfHx8fHx8MXx8MTY5NDE5Mzc2Nnw&ixlib=rb-4.0.3&q=80&w=400")),
                              ],

                            )
                        // Container(height:size.height*0.03,width:size.width*0.03,child: Text("data"))
                        // Padding(
                      // padding:
                      // const EdgeInsets.symmetric(horizontal: 10),
                      // child: CardWorkout(size:size,workout: Workout(name: "tedi", category: "s", video: "s", weight: false, level: "s", description: "s",img: "https://images.unsplash.com/photo-1682685796852-aa311b46f50d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTczNDd8MXwxfGFsbHwxfHx8fHx8MXx8MTY5NDE5Mzc2Nnw&ixlib=rb-4.0.3&q=80&w=400")),
                      // child: GridView.custom(
                      //   shrinkWrap: true,
                      //   physics: const BouncingScrollPhysics(),
                      //   gridDelegate: SliverQuiltedGridDelegate(
                      //     crossAxisCount: 4,
                      //     mainAxisSpacing: 4,
                      //     crossAxisSpacing: 4,
                      //     repeatPattern:
                      //     QuiltedGridRepeatPattern.inverted,
                      //     pattern: const [
                      //       QuiltedGridTile(2, 2),
                      //       QuiltedGridTile(1, 1),
                      //       QuiltedGridTile(1, 1),
                      //       QuiltedGridTile(1, 2),
                      //     ],
                      //   ),
                      //   childrenDelegate: SliverChildBuilderDelegate(
                      //       childCount: homeController.workouts.length,
                      //           (context, index) {
                      //         return GestureDetector(
                      //           onTap: () {
                      //             // Navigator.of(context).push(
                      //             //   MaterialPageRoute(
                      //             //     builder: (ctx) =>
                      //             //         DetailView(index: index),
                      //             //   ),
                      //             // );
                      //           },
                      //           child: Hero(
                      //             tag: homeController.workouts[index].name!,
                      //             child: Container(
                      //               margin: const EdgeInsets.all(2),
                      //               child: CachedNetworkImage(
                      //                 imageUrl: homeController
                      //                     .workouts[index].img!,
                      //                 imageBuilder:
                      //                     (context, imageProvider) =>
                      //                     Container(
                      //                       decoration: BoxDecoration(
                      //                         borderRadius:
                      //                         BorderRadius.circular(10),
                      //                         image: DecorationImage(
                      //                           image: imageProvider,
                      //                           fit: BoxFit.cover,
                      //                         ),
                      //                       ),
                      //                     ),
                      //                 placeholder: (context, url) =>
                      //                     Center(
                      //                       child:
                      //                       LoadingAnimationWidget.flickr(
                      //                         rightDotColor: Colors.black,
                      //                         leftDotColor:
                      //                         const Color(0xfffd0079),
                      //                         size: 25,
                      //                       ),
                      //                     ),
                      //                 errorWidget:
                      //                     (context, url, error) =>
                      //                 const Icon(
                      //                   Icons.image_not_supported_rounded,
                      //                   color: Colors.grey,
                      //                 ),
                      //               ),
                      //             ),
                      //           ),
                      //         );
                      //       }),
                      // ),
                    ),
                  )


              // ),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabBar(size) {
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemCount: homeController.orders.length,
        itemBuilder: (ctx, i) {
          return Obx(
            () => GestureDetector(
              onTap: () {
                homeController.selectedIndex.value = i;
                // homeController.ordersFunc(homeController.orders[i]);
              },
              child: AnimatedContainer(
                  margin: EdgeInsets.fromLTRB(i == 0 ? 15 : 5, 0, 5, 0),
                  width: size.width*0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(
                        i == homeController.selectedIndex.value ? 18 : 15)),
                    color: i == homeController.selectedIndex.value
                        ? Colors.grey[700]
                        : Colors.grey[200],
                  ),
                  duration: const Duration(milliseconds: 300),
                  child: Center(
                    child: Text(
                      homeController.orders[i],
                      style: TextStyle(
                        fontSize: 13.0,
                        fontWeight: FontWeight.w500,
                        color: i == homeController.selectedIndex.value
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                  )),
            ),
          );
        });
  }
}
