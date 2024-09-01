import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/controllers/PlanController.dart';
import 'package:movie/widget/ui/Background.dart';
import 'package:movie/widget/ui/Header.dart';

import '../controllers/HomeController.dart';
import '../icons/my_flutter_app_icons.dart';
import '../model/Exercise.dart';
import 'PlanWorkoutTile.dart';
import 'UploadPage.dart';
import 'UserPage.dart';

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
            Background(backgroundName: "background1.jpg"),
            Container(
              padding: EdgeInsets.fromLTRB(0, _height * 0.06, 0, 0),
              width: _width * 0.88,
              child: Column(
                children: [
                  Header(
                    title: "Workout plan",
                  ),
                  Expanded(child: _mainWidget()),
                  _topDownWidget()
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
                      if (direction == DismissDirection.endToStart) {
                        homeController.addWorkoutToList(
                            planController.exercices[index].name,
                            operation: "delete",
                            id: planController.idPlan.value,
                            exercise: planController.exercices[index]);
                        planController.exercices.removeAt(index);

                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('Removed')));
                      } else {
                        planController.exercices[index].status = "complete";
                        homeController.addWorkoutToList(
                            planController.exercices[index].name,
                            operation: "mod",
                            id: planController.idPlan.value,
                            exercise: planController.exercices[index]);

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
              )));
  }

  void onReorder(int oldIndex, int newIndex) {
    print("onReorder");
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
  }

  _topDownWidget() {
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
                onTap: () => Get.to(UploadPage()),
                child: Icon(Icons.upload, color: Colors.red, fill: 0.2),
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
                onTap: () async  {

                  planController.saveWorkoutName.value="";

                  Get.dialog(Column(
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
                                        child: Column(children: [
                                      const SizedBox(height: 10),
                                      Text(
                                          "Workout plan ${planController.idPlan.value}",
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 20)),
                                      const SizedBox(height: 15),
                                      TextField(
                                          keyboardType: TextInputType.text,
                                          onChanged: (value) => planController
                                              .saveWorkoutName.value = value,
                                          controller: TextEditingController(
                                              text: planController
                                                  .saveWorkoutName.value),
                                          decoration: InputDecoration(
                                            hintText: 'Enter workout plane name ',
                                            border: OutlineInputBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                          )),
                                        Center(
                                          child: IconButton(
                                          icon: Icon(Icons.save),
                                          onPressed: () async {
                                            planController.saveWorkoutPlan();
                                            Get.back();
                                          },
                                      ),
                                        )
                                    ])))))
                      ])

                      );
                },
                child: const Icon(
                  Icons.save_alt,
                  color: Colors.red,
                  fill: 0.2,
                ),
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
                onTap: () => Get.to(UserPage()),
                child: Icon(
                  Icons.login_rounded,
                  color: Colors.red,
                ),
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
                  child: Obx(
                    () => PopupMenuButton<String>(
                      initialValue: homeController.targetSelected.value,
                      onSelected: (value) =>
                          homeController.changeTargets(value),
                      itemBuilder: (BuildContext context) {
                        return <PopupMenuEntry<String>>[
                          ...homeController.targets
                              .map((element) => PopupMenuItem(
                                    value: element,
                                    child: Text(
                                      element,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ))
                              .toList()
                        ];
                      },
                      icon: Icon(
                        MyFlutterApp.yoga_standing_forward_fold_pose,
                        color: Colors.red,
                      ),
                      color: Colors.black38,
                      constraints: BoxConstraints(
                        maxHeight: _height * 0.5,
                        maxWidth: _width * 0.2,
                      ),
                    ),
                  ))),
        ),
      ],
    );
  }
}
