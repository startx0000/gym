import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/Workout.dart';

class CardWorkout extends StatelessWidget {
  final Workout workout;
  final Size size;
  const CardWorkout({super.key,required this.workout,required this.size});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(blurRadius: 7,offset: const Offset(0, 7) ,color: Colors.grey[300]!)

            ]
        ),
        margin: EdgeInsets.all(3.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 1.0,),
            Text(' ${workout.description}',
              style:   const TextStyle(
                  fontWeight: FontWeight.bold,
                  // fontSize: 12.0.sp,
                  color: Colors.grey
              ),
            ),
          ],
        ),

      ),
    );
  }
}
