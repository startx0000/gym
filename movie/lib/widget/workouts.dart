import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/HomeController.dart';

class Workouts extends StatelessWidget {
  HomeController homeController = Get.find<HomeController>();

  Workouts({super.key});

  late double _width;
  late double _height;

  @override
  Widget build(BuildContext context) {
    _height = MediaQuery
        .of(context)
        .size
        .height;
    _width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      appBar: AppBar(),
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
      padding: EdgeInsets.fromLTRB(0, _height * 0.02, 0, 0),
      width: _width * 0.88,
      // color: Colors.blue,
      child: Column(
          children: [_topBarWidget(), Expanded(child: _movieWidget())],
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max),
    );
  }

  Widget _movieWidget() {
    return Container(
      height: _height * 0.83,
      padding: EdgeInsets.symmetric(vertical: _height * 0.01),
      // color: Colors.red,
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
          Expanded(child: Icon(Icons.search_rounded, color: Colors.red,)),
          Expanded(
            // flex: 5,
            child: InkWell(
                onTap: () => homeController.getCategories(),
                child: Icon(Icons.refresh, color: Colors.red,)),
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
        ()=> DropdownButton(
           onTap: () => homeController.categorySelected.value=" ",
          isExpanded: true,
        items: homeController.categories
            .map((e) =>
            DropdownMenuItem(
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
        underline: Container(
          height: 1,
          color: Colors.white24,
        ),
        value: homeController.categorySelected.value,
        onChanged: (String? value) {
          value
              .toString()
              .isNotEmpty
              ? homeController.changeSelectedCategory(value)
              : null;
        },
      ),
    );
  }
}
