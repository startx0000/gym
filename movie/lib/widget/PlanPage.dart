import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:movie/widget/ui/Background.dart';
import 'package:movie/widget/ui/Header.dart';

import '../controllers/HomeController.dart';

class PlanPage extends StatelessWidget {
  PlanPage({super.key});

  late double _width;
  late double _height;
  HomeController homeController = Get.find<HomeController>();

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
                  Header(title: "Workout plan",)

                ],
              ),
            )






          ],
        ),
      ),
    );

}}
