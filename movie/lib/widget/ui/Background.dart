import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
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
      ),
      child: CachedNetworkImage(
        imageUrl: _background1,
        placeholder: (context, url) => Container(
          width: 200,
          height: 300,
          color: Colors.grey[200], // Placeholder color while image is loading
        ),
        errorWidget: (context, url, error) => Container(
          width: 200,
          height: 300,
          color: Colors.grey[200], // Widget to display when image fails to load
        ),
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
            child: Container(
              decoration: BoxDecoration(color: Colors.black.withOpacity(0.2)),
            ),
          ),
        ),
      ),
    );  }
}
