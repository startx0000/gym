import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/HomeController.dart';

class Background extends StatelessWidget {
   Background({super.key,this.backgroundName});
  HomeController homeController = Get.find<HomeController>();
  String ? backgroundName;
  late double _width;
  late double _height;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    var _background1 = '${homeController.connection}/video/background1.jpg';

    if(backgroundName!= null)
      _background1 = '${homeController.connection}/video/$backgroundName';
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
    );  }
}
