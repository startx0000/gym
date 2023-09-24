import 'dart:developer' as dev;
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:get/get.dart';

import '../conf/global.dart';
import '../model/Workout.dart';
import '../services/DioService.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:dio/src/form_data.dart' as frm;
import 'package:dio/src/multipart_file.dart' as pippo;

class HomeController extends GetxController {
  var isLoading = false.obs;
  var errorMsg = "".obs;
  var title = "Workout".obs;
  var workouts = List<Workout>.empty().obs;
  var connection = "${connectionUrl}".obs;

  var fav = false.obs;

  changeFav(bool val) {
    fav.value = val;
    getWorkoutsGeneric();
  }


  // var plans= <Workout>[].obs;
  List<String> categories = List<String>.empty().obs;


  var targets = [
    "All",
    "Chest",
    "Legs",
    "Back",
    "Arms",
    "Abs",
    "Shoulder"
  ].obs;

  var categorySelected = 'All'.obs;
  var targetSelected = 'All'.obs;

  var selectedIndex = 0.obs;
  List<String> orders = [
    "latest",
    "popular",
    "oldest",
    "views",
  ];

  changeLoading(bool val) {
    isLoading.value = val;
  }

  changeTitle() {
    getWorkouts();
  }

  uploadFile({ required String name, required String path}) async {
    String? mimeType = mime(name);
    String mimee = mimeType!.split('/')[0];
    String type = mimeType.split('/')[1];
    Dio dio = Dio();
    dio.options.headers["Content-Type"] = "multipart/form-data";
    var s = new frm.FormData.fromMap({
      'name': '${name}',
      'file':await pippo.MultipartFile.fromFile(path,
          filename: name, contentType: MediaType(mimee, type))
    });
    var response = await dio
        .post('${connection}/video', data: s)
        .catchError((e) => print(e.response.toString()));
    // FormData formData = new FormData.from({
    //   "name": "${name}",
    //   "file1": new UploadFileInfo(new File("./upload.jpg"), "upload1.jpg")
    // });
    // response = await dio.post("/info", data: formData);


  }

  upload() async {
    dev.log('upload clicked!');
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      print(file.name);
      print(file.bytes);
      print(file.size);
      print(file.extension);
      print(file.path);
    } else {
      // User canceled the picker
    }
  }

  @override
  void onInit() async {
    await getWorkouts();
    await getCategories();
    super.onInit();
  }

  getCategories() async {
    dev.log("calling service category");

    changeLoading(true);
    var response = await DioService().get('${connection.value}/workout/categories');
    if (response.statusCode == 200) {
      categories.clear();
      response.data.forEach((element) {
        dev.log(element);
        categories.add(element);
      });
    } else {
      errorMsg.value = "Errors";
    }

    changeLoading(false);
  }


  getWorkoutsGeneric()async{
    String query ='';
    if(categorySelected.value !=null && categorySelected.value.isNotEmpty ) {
      query='?category=${categorySelected.value}';
    }else{
      query='?category=ALL';
    }
    if(fav.value !=null && fav.value==true ) {
      query=query+'&favorite=${fav.value}';
    }

    if(targetSelected.value !=null && targetSelected.value.isNotEmpty ) {
      query=query+'&target=${targetSelected.value}';
    }
    dev.log(query);

    changeLoading(true);
    var response = await DioService().get('${connection.value}/workout/all${query}');
    if (response.statusCode == 200) {
      workouts.clear();
      response.data.forEach((element) {
        workouts.add(Workout.fromJson(element));
      });
    } else {
      dev.log(response);

      errorMsg.value = "Errors";
    }

    changeLoading(false);

  }

  getWorkouts({String ? category}) async {
    dev.log("calling service");

    String query ='';
    if(category !=null && category.isNotEmpty ) {
      query='?category=${category}';
    }

    changeLoading(true);
    var response = await DioService().get('${connection.value}/workout/all${query}');
    if (response.statusCode == 200) {
      workouts.clear();
      response.data.forEach((element) {
        workouts.add(Workout.fromJson(element));
      });
    } else {
      errorMsg.value = "Errors";
    }

    changeLoading(false);
  }

  changeSelectedCategory(String? value) {
      categorySelected.value=value!;
      getWorkouts(category: value);


  }
  changeTargets(String value) {
    targetSelected.value=value;
    getWorkoutsGeneric();
    //getWorkouts(category: value);


  }



  void shuffle() {
    var random = Random();

    for (var i = workouts.length - 1; i > 0; i--) {

      var n = random.nextInt(i + 1);
      var temp = workouts[i];
      workouts[i] = workouts[n];
      workouts[n] = temp;
    }

  }
}
