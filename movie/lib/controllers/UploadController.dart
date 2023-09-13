import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
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
          await dio.post('${connection}/video', data: s);

      if (response.statusCode == 200)
        uploaded.value = "OK";
      else
        uploaded.value = "ERROR";
    } on Exception catch (e) {
      uploaded.value = "ERROR";

    }

    changeLoading(false);

  }
}
