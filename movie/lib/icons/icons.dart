import 'package:flutter/material.dart';

import 'my_flutter_app_icons.dart';

List<Icon> getIconsCategory(){
  return const [
    Icon(MyFlutterApp.muscle_up,color: Colors.black54,),
    Icon(MyFlutterApp.yoga_bridge,color: Colors.black54,),
    Icon(MyFlutterApp.sport_gym_cycling,color: Colors.black54,),
    Icon(MyFlutterApp.yoga_standing_forward_fold_pose,color: Colors.black54,),
  ];
}


List<Icon> getIconsLevel(){
  return const [

    Icon(MyFlutterApp.wpbeginner,color: Colors.black54,),
    Icon(MyFlutterApp.medium_m,color: Colors.black54,),
    Icon(Icons.local_fire_department,color: Colors.black54,),
  ];
}