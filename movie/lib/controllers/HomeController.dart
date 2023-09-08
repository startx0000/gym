import 'package:get/get.dart';

import '../model/Workout.dart';
import '../services/DioService.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;
  var errorMsg  = "".obs;
  var title  = "Workout".obs;
  var workouts  = List<Workout>.empty().obs;
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
    title.value=title.value + title.value;
  }

  @override
  void onInit() {
    workouts.add(Workout(name: "s", category: "s", video: "s", weight: false, level: "s", description: "s"));
    super.onInit();
  }

  getWorkouts() async {

      changeLoading();
      var response = await DioService().get('http://localhost:8080/workout/all');
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
