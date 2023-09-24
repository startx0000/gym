import 'package:get/get.dart';

import '../model/Workout.dart';

class WorkoutController extends GetxController {
  var workout = Workout(
          name: "name",
          category: "category",
          video: "video",
          weight: false,
          level: "level",
          description: "description")
      .obs;

  var isLooping = false.obs;
  var isLoading = false.obs;

  setLooping(bool val) {
    isLooping.value = val;
  }

  changeWorkout(Workout wk) {
    workout.value = wk;
  }
}
