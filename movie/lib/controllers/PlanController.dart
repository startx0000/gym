import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'package:movie/controllers/HomeController.dart';
import 'package:movie/model/WorkoutPlan.dart';

import '../conf/global.dart';
import '../model/Exercise.dart';
import '../model/ExerciseSet.dart';
import '../services/DioService.dart';

class PlanController extends GetxController {

  var isLoading = false.obs;
  var exercices = List<Exercise>.empty().obs;
  var idPlan = "".obs;
  String token = Get.find<HomeController>().token.value;
  bool loggedIn = Get.find<HomeController>().loggedIn.value;

  RxBool completed = false.obs;
  RxInt rest = 0.obs;
  RxList<ExerciseSet> exerciseSets = <ExerciseSet>[].obs;
  var selectedSet = 0.obs;



  void addExerciseSet(ExerciseSet set) {
    exerciseSets.add(set);
  }

  void removeExerciseSet(int index) {
    exerciseSets.removeAt(index);
  }

  void updateExerciseSet(int index, ExerciseSet set) {
    exerciseSets[index] = set;
  }



  void updateRest(int value) {
    rest.value = value;
  }
  void toggle() {
    completed.toggle();
    print("Complete value: ${completed.value}");
  }

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

  void modify(Exercise exercise, {String? operation, String? status}) async {
    var name = exercise.name;
    completed.value ? exercise.status="complete" : exercise.status="YET";
    exercise.rest=rest.value;

    exercise.sets.clear();
    for(ExerciseSet a in exerciseSets){
      exercise.sets.add(a);

    }

    print('Adding workout $name to the list');
    isLoading.value=true;

    try {
      Dio dio = Dio();
      String url  = "$connectionUrlAuth/api/workout/addWorkoutToPlan";


      Map<String, dynamic> data = {
        "name": name
      };
      var response = await dio.post(
        url,
        data: exercise!=null ? exercise.toJson() : data,
        options: Options(
          headers: {
            "Authorization": "Bearer ${token}",
            "content-Type": "application/json",
            "operation" : (operation==null || operation.isEmpty) ? "add" : operation,
            "idKey": idPlan.value
          },
        ),
      );
      print(response.data);
    } on Exception catch (e) {

    }
    isLoading.value=false;
    print("end");
    exercices.value.map((e) => print(e.name));
  }

  void modifyAndReload(Exercise exercise, {required String operation}) async {
    var name = exercise.name;
    completed.value ? exercise.status="complete" : exercise.status="YET";
    exercise.rest=rest.value;
    exercise.sets.clear();
    for(ExerciseSet a in exerciseSets){
      exercise.sets.add(a);

    }

    print('Adding workout $name to the list');
    isLoading.value=true;

    try {
      Dio dio = Dio();
      String url  = "$connectionUrlAuth/api/workout/addWorkoutToPlan";


      Map<String, dynamic> data = {
        "name": name
      };
      var response = await dio.post(
        url,
        data: exercise!=null ? exercise.toJson() : data,
        options: Options(
          headers: {
            "Authorization": "Bearer ${token}",
            "content-Type": "application/json",
            "operation" : (operation==null || operation.isEmpty) ? "add" : operation,
            "idKey": idPlan.value
          },
        ),
      );
      print(response.data);
    } on Exception catch (e) {

    }
    isLoading.value=false;
    print("end");
    exercices.value.map((e) => print(e.name));
    await getWorkoutPlan();


  }



}