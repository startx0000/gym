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
    super.onInit();
  }

  getWorkouts() async {
      log("calling service");

      changeLoading();
      var response = await DioService().get('https://c33b-93-35-221-109.ngrok-free.app/workout/all');
      if (response.statusCode == 200) {
        workouts.clear();
        response.data.forEach((element) {
          workouts.add(Workout.fromJson(element));
        });
      }else {

        errorMsg.value="Errors";
      }

      changeLoading();

  }
}
