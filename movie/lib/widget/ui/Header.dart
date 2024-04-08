import 'package:flutter/material.dart';

class Header extends StatelessWidget {


   Header({super.key,this.title});
   final String? title;
   late double _width;
   late double _height;
  @override
  Widget build(BuildContext context) {
    _height = MediaQuery.of(context).size.height;
    _width = MediaQuery.of(context).size.width;
    return Container(
      width: _width,
      height: _height * 0.10,
      decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(20.0)),
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
                  width: _width * 0.03,
                ),
                InkWell(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.arrow_back_rounded,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: _width * 0.3,
                ),
                 Text(
                  "$title",
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
