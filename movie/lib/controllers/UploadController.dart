import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../model/Workout.dart';
import '../services/DioService.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime_type/mime_type.dart';
import 'package:dio/src/form_data.dart' as frm;
import 'package:dio/src/multipart_file.dart' as pippo;

import '../conf/global.dart';

class UploadController extends GetxController {
  var isLoading = false.obs;
  var videoSelected = false.obs;

  var uploaded = "YET".obs;
  Rx<FilePickerResult>? result;

  final editController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final chipIndexCategory = 0.obs;
  final chipIndexLevel = 0.obs;
  final videoName ="".obs;

  var weight = false.obs;


  @override
  void onClose() {
    editController.dispose();

    super.onClose();
  }


  changeLoading(bool val) {
    isLoading.value = val;
  }

  changeVideoSelected(bool val) {
    videoSelected.value = val;
  }

  uploadFile({required String name, required String path}) async {
    String? mimeType = mime(name);
    String mimee = mimeType!.split('/')[0];
    String type = mimeType.split('/')[1];
    Dio dio = Dio();
    dio.options.headers["Content-Type"] = "multipart/form-data";
    var s = new frm.FormData.fromMap({
      'name': '${name}',
      'file': await pippo.MultipartFile.fromFile(path,
          filename: name, contentType: MediaType(mimee, type))
    });

    changeLoading(true);

    try {
      var response =
          await dio.post('${connectionUrl}/video', data: s);

      if (response.statusCode == 200) {
        uploaded.value = "OK";
        videoName.value=name;
      }
      else
        uploaded.value = "ERROR";
    } on Exception catch (e) {
      uploaded.value = "ERROR";

    }

    changeLoading(false);

  }

  Future<bool> uploadWorkout() async {
    var description = "Workout for building muscle";

    var category="muscle";
    if(chipIndexCategory==1) {
      category = "mobility";
      description ="Workout for mobility";
    }
    if(chipIndexCategory==2){
      category="cardio";
      description="Cardio workout";
    }
    if(chipIndexCategory==3){
      category="Stretch";
      description="Streching exercise";
    }

    var level = "beginner";
    if(chipIndexLevel==1)
      level="medium";
    if(chipIndexLevel==2) {
      level="hard";
    }

    var workout = Workout(name: editController.text, category: category, video: this.videoName.value, weight: this.weight.value, level: level, description: description);

    Dio dio = Dio();
    dio.options.headers["Content-Type"] = "application/json";
    try {
      var response =
          await dio.post('${connectionUrl}/workout', data: workoutToJson(workout));

      if (response.statusCode == 200) {
        return true;
      }
      else
        return false;
    } on Exception catch (e) {
      return false;
    }


  }
}
