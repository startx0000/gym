import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:movie/icons/my_flutter_app_icons.dart';
import 'package:movie/widget/workoutTile.dart';

import '../controllers/HomeController.dart';
import 'filePicker.dart';

class Workouts extends StatelessWidget {
  HomeController homeController = Get.find<HomeController>();

  Workouts({super.key});

  late double _width;
  late double _height;

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
            _backgroundWidget(),
            _foreGroundWidget(),
          ],
        ),
      ),
    );
  }

  Widget _backgroundWidget() {
    var _backGroundData =
        'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg';
    var _background1 = '${homeController.connection}/video/background1.jpg';
    return Container(
      height: _height,
      width: _width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
              fit: BoxFit.cover,
              image: ResizeImage(
                NetworkImage(_background1),
                width: 200,
                height: 300,
              ))),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
        ),
      ),
    );
  }

  Widget _foreGroundWidget() {
    return Container(
      padding: EdgeInsets.fromLTRB(0, _height * 0.06, 0, 0),
      width: _width * 0.88,
      // color: Colors.blue,
      child: Column(
          children: [
            _topBarWidget(),
            Expanded(child: _movieWidget()),
            _topDownWidget()
          ],
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max),
    );
  }

  Widget _movieWidget() {
    return Container(
        // height: _height * 0.83,
        padding: EdgeInsets.symmetric(vertical: _height * 0.01),
        child: Obx(() => homeController.isLoading.value
            ? Center(
                child: LoadingAnimationWidget.flickr(
                  rightDotColor: Colors.black,
                  leftDotColor: const Color(0xfffd0079),
                  size: 30,
                ),
              )
            : ListView.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: _height * 0.01, horizontal: 0),
                    child: GestureDetector(
                      onTap: () {
                        // _backGroundData.state = movies[index].posterURL();
                      },
                      child: WorkoutTile(
                        workout: homeController.workouts[index],
                        height: _height * 0.2,
                        width: _width * 0.85,
                      ),
                    ),
                  );
                },
                itemCount: homeController.workouts.length,
              )));
  }

  Widget _topDownWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: EdgeInsets.all(_height * 0.01),
          child: Container(
            width: _width * 0.2,
            height: _height * 0.08,
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20.0)),
            child: InkWell(
              onTap: () => Get.to(FilePickerDemo(title: 'myTitle')),
              child: Icon(Icons.upload, color: Colors.red, fill: 0.2),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(_height * 0.01),
          child: Container(
            width: _width * 0.2,
            height: _height * 0.08,
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20.0)),
            child: InkWell(
              onTap: () => homeController.shuffle(),
              child: Icon(Icons.shuffle, color: Colors.red, fill: 0.2),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.all(_height * 0.01),
          child: Container(
            width: _width * 0.2,
            height: _height * 0.08,
            decoration: BoxDecoration(
                color: Colors.black26,
                borderRadius: BorderRadius.circular(20.0)),
            child: InkWell(
              onTap: () => log("tapped"),
              child: Icon(MyFlutterApp.muscle_up,color: Colors.red,),
            ),
          ),
        ),
        // Padding(
        //   padding: EdgeInsets.all(_height * 0.01),
        //   child: Container(
        //     width: _width * 0.2,
        //     height: _height * 0.08,
        //     decoration: BoxDecoration(
        //         color: Colors.black26,
        //         borderRadius: BorderRadius.circular(20.0)),
        //     child: InkWell(
        //       onTap: () => homeController.shuffle(),
        //       child: Obx(
        //         () => DropdownButton(
        //
        //           // onTap: () => homeController.targetSelected.value = " ",
        //           items: homeController.categories
        //               .map((e) => DropdownMenuItem(
        //                     value: e,
        //                     child: Text(
        //                       e,
        //                       style: const TextStyle(color: Colors.white),
        //                     ),
        //                   ))
        //               .toList(),
        //           dropdownColor: Colors.black38,
        //           underline: SizedBox(),
        //           icon: const Icon(
        //             MyFlutterApp.muscle_up,
        //             color: Colors.red,
        //           ),
        //           onChanged: (String? value) {
        //             value.toString().isNotEmpty
        //                 ? homeController.changeSelectedCategoryTargets(value)
        //                 : null;
        //           },
        //         ),
        //       ),
        //     ),
        //   ),
        // ),
      ],
    );
  }

  Widget _topBarWidget() {
    return Container(
      width: _width,
      height: _height * 0.10,
      decoration: BoxDecoration(
          color: Colors.black54, borderRadius: BorderRadius.circular(20.0)),
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
                  width: _width * 0.01,
                ),
                Icon(
                  Icons.search_rounded,
                  color: Colors.red,
                ),
                SizedBox(
                  width: _width * 0.03,
                ),
                InkWell(
                    onTap: () => homeController.getCategories(),
                    child: Icon(
                      Icons.refresh,
                      color: Colors.red,
                    )),
              ],
            ),
          ),
          // Expanded(child: _searchWidget()),
          Expanded(
            child: _selectionWidget(),
          ),
        ],
      ),
    );
  }

  Widget _selectionWidget() {
    return Obx(
      () => DropdownButton(
        onTap: () => homeController.categorySelected.value = " ",
        isExpanded: true,
        items: homeController.categories
            .map((e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: const TextStyle(color: Colors.white),
                  ),
                ))
            .toList(),
        dropdownColor: Colors.black38,
        icon: const Icon(
          Icons.menu,
          color: Colors.white24,
        ),
        underline: SizedBox(),
        // underline: Container(
        //   height: 1,
        //   color: Colors.white24,
        // ),
        value: homeController.categorySelected.value,
        onChanged: (String? value) {
          value.toString().isNotEmpty
              ? homeController.changeSelectedCategory(value)
              : null;
        },
      ),
    );
  }
}
