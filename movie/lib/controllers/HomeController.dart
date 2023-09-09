import 'dart:developer';

import 'package:get/get.dart';

import '../model/Workout.dart';
import '../services/DioService.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var errorMsg  = "".obs;
  var title  = "Workout".obs;
  var workouts  = List<Workout>.empty().obs;
  var connection = "https://c33b-93-35-221-109.ngrok-free.app".obs;
  // var plans= <Workout>[].obs;

  var selectedIndex = 0.obs;
  List<String> orders = [
    "latest",
    "popular",
    "oldest",
    "views",
  ];

  changeLoading() {
    isLoading.value = !isLoading.value;
  }

  changeTitle(){
    getWorkouts();
  }

  @override
  void onInit() async {
    await getWorkouts();
    workouts.add(Workout(name: "tedi", category: "s", video: "s", weight: false, level: "s", description: "s",img: "https://images.unsplash.com/photo-1682685796852-aa311b46f50d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTczNDd8MXwxfGFsbHwxfHx8fHx8MXx8MTY5NDE5Mzc2Nnw&ixlib=rb-4.0.3&q=80&w=400"));
    workouts.add(Workout(name: "tedi", category: "s", video: "s", weight: false, level: "s", description: "s",img: "https://images.unsplash.com/photo-1682685796852-aa311b46f50d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTczNDd8MXwxfGFsbHwxfHx8fHx8MXx8MTY5NDE5Mzc2Nnw&ixlib=rb-4.0.3&q=80&w=400"));
    workouts.add(Workout(name: "tedi", category: "s", video: "s", weight: false, level: "s", description: "s",img: "https://images.unsplash.com/photo-1682685796852-aa311b46f50d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTczNDd8MXwxfGFsbHwxfHx8fHx8MXx8MTY5NDE5Mzc2Nnw&ixlib=rb-4.0.3&q=80&w=400"));
    workouts.add(Workout(name: "tedi", category: "s", video: "s", weight: false, level: "s", description: "s",img: "https://images.unsplash.com/photo-1682685796852-aa311b46f50d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0OTczNDd8MXwxfGFsbHwxfHx8fHx8MXx8MTY5NDE5Mzc2Nnw&ixlib=rb-4.0.3&q=80&w=400"));
    super.onInit();
  }

  getWorkouts() async {
      log("calling service");

      changeLoading();
      var response = await DioService().get('https://c33b-93-35-221-109.ngrok-free.app/workout/all');
      if (response.statusCode == 200) {
        response.data.forEach((element) {
          workouts.add(Workout.fromJson(element));
        });
      }else {

        errorMsg.value="Errors";
      }

      changeLoading();

  }
}
