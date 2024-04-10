import 'dart:convert';

import 'package:get/get.dart';
import 'package:movie/controllers/HomeController.dart';
import 'package:movie/model/WorkoutPlan.dart';

import '../conf/global.dart';
import '../model/Exercise.dart';
import '../services/DioService.dart';

class PlanController extends GetxController {

  var isLoading = false.obs;
  var exercices = List<Exercise>.empty().obs;
  var idPlan = "".obs;
  String token = Get.find<HomeController>().token.value;
  bool loggedIn = Get.find<HomeController>().loggedIn.value;

  @override
  void onInit() async {
    print("On Init of Plan Controller");
    await getWorkoutPlan();

    super.onInit();
  }

  getWorkoutPlan() async {
    if(!loggedIn)
      return;
    print("Calling for workoutplan");
    isLoading.value = true;
    try {
      var response = await DioService()
          .getWithBearer("$connectionUrlAuth/api/workout/workoutplan", token);

      if (response.statusCode == 200) {
        print("Response workoutplan:  " + response.data);
        if (response.data != null && response.data
            .toString()
            .isNotEmpty) {
          WorkoutPlan workoutPlan = WorkoutPlan.fromJson(
              json.decode(response.data));
          print("Workout plan ${workoutPlan.nameWorkout}");
          exercices.clear;
          exercices.addAll(workoutPlan.plan);
          idPlan.value=workoutPlan.nameWorkout;
        }
      }
      else {
        print(response);
      }
    }catch(e,stacktrace) {
      print(e);
      print(stacktrace);

    }
    isLoading.value = false;

  }

  void onReorder(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final item =exercices.removeAt(oldIndex);
    exercices.insert(newIndex, item);
    print("here");
  
  }


}