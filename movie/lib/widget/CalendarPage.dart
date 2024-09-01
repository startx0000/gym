import 'package:flutter/material.dart';
import 'package:movie/widget/ui/Background.dart';
import 'package:movie/widget/ui/Header.dart';

class CalendarPage extends StatelessWidget {
  CalendarPage({super.key});
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
            Background(backgroundName: "background1.jpg"),
            Container(
              padding: EdgeInsets.fromLTRB(0, _height * 0.06, 0, 0),
              width: _width * 0.88,
              child: Column(
                children: [
                  Header(
                    title: "Calendar Page",
                  ),
                  // Expanded(child: _mainWidget()),
                  // _topDownWidget()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
