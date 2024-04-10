import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/controllers/PlanController.dart';
import 'package:movie/widget/ui/Background.dart';
import 'package:movie/widget/ui/Header.dart';

import '../controllers/HomeController.dart';
import '../model/Exercise.dart';
import 'PlanWorkoutTile.dart';

class PlanPage extends StatelessWidget {
  PlanPage({super.key});

  late double _width;
  late double _height;
  HomeController homeController = Get.find<HomeController>();
  PlanController planController = Get.put(PlanController());


  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: Container(
        child: Stack(
          alignment: Alignment.center,
          children: [
            Background(backgroundName: "bb1.png"),
            Container(
              padding: EdgeInsets.fromLTRB(0, _height * 0.06, 0, 0),
              width: _width * 0.88,
              child: Column(
                children: [
                  Header(title: "Workout plan",),
                  Expanded(child: _mainWidget()),
                ],
              ),
            )






          ],
        ),
      ),
    );

}

  Widget _mainWidget() {
    return Container(
      // height: _height * 0.83,
        padding: EdgeInsets.symmetric(vertical: _height * 0.01),
        child: Obx(() => planController.isLoading.value
            ? Center(
          child: LoadingAnimationWidget.flickr(
            rightDotColor: Colors.black,
            leftDotColor: const Color(0xfffd0079),
            size: 30,
          ),
        )
            :

        // ListView.builder(
        //   itemBuilder: (context, index) {
        //     return Padding(
        //       padding: EdgeInsets.symmetric(
        //           vertical: _height * 0.01, horizontal: 0),
        //       child: GestureDetector(
        //         onTap: () {
        //           // _backGroundData.state = movies[index].posterURL();
        //         },
        //         child: PlanWorkoutTile(
        //           workout: planController.exercices[index],
        //           height: _height * 0.2,
        //           width: _width * 0.85,
        //         ),
        //       ),
        //     );
        //   },
        //   itemCount: planController.exercices.length,
        // )
        // Obx(
        //     ()=> ReorderableListView(
        //       onReorder: (oldIndex, newIndex) {
        //           planController.onReorder(oldIndex,newIndex);
        //       },
        //       children: planController.exercices.map((element) =>
        //
        //       Container(
        //         key: ValueKey(element),
        //         child: Padding(
        //           padding: EdgeInsets.symmetric(
        //               vertical: _height * 0.01, horizontal: 0),
        //           child: GestureDetector(
        //             onTap: () {
        //               // _backGroundData.state = movies[index].posterURL();
        //             },
        //             child: PlanWorkoutTile(
        //               workout: element,
        //               height: _height * 0.2,
        //               width: _width * 0.85,
        //             ),
        //           ),
        //         ),
        //       )
        //
        //
        //       ).toList(),
        //
        //      ),
        // )
        ListView.builder(
          itemBuilder: (context, index) {
            return Dismissible(
              // direction: DismissDirection.startToEnd,
              key: Key(planController.exercices[index].name),
              onDismissed: (direction) {
                if(direction == DismissDirection.endToStart) {
                  homeController.addWorkoutToList(planController.exercices[index].name,operation: "delete",id:planController.idPlan.value,exercise: planController.exercices[index]);
                  planController.exercices.removeAt(index);

                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Removed')));
                }
                else {
                  planController.exercices[index].status="complete";
                  homeController.addWorkoutToList(planController.exercices[index].name,operation: "mod",id:planController.idPlan.value,exercise: planController.exercices[index]);


                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text('Completed')));
                }


              },
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: _height * 0.01, horizontal: 0),
                child: GestureDetector(
                  onTap: () {
                    // _backGroundData.state = movies[index].posterURL();
                  },
                  child: PlanWorkoutTile(
                    workout: planController.exercices[index],
                    height: _height * 0.2,
                    width: _width * 0.85,
                  ),
                ),
              ),
            );
          },
          itemCount: planController.exercices.length,
        )

        ));
  }

  void onReorder(int oldIndex, int newIndex) {
    print("onReorder");
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }


  }
}
