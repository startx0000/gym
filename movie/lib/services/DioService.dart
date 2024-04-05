import 'dart:developer';

import 'package:dio/dio.dart';

class DioService {
  Future<dynamic> get(String url) async {
    Dio dio = Dio();
    dio.options.headers['content-Type'] = 'application/json';
    return await dio
        .get(url,
            options: Options(responseType: ResponseType.json, method: 'GET'))
        .then((response) {
      log(response.toString());
      return response;
    });
  }

  Future<dynamic> getExchangeToken(String url,String token) async {
    Dio dio = Dio();
    dio.options.headers['tok'] = '${token}';
    dio.options.headers['content-Type'] = 'application/json';

    return await dio
        .get(url,
        options: Options(responseType: ResponseType.json, method: 'GET'))
        .then((response) {
      log(response.toString());
      return response;
    });
  }

  Future<dynamic> getWithBearer(String url,String token) async {
    Dio dio = Dio();
    dio.options.headers['Authorization'] = 'Bearer ${token}';
    dio.options.headers['content-Type'] = 'application/json';

    return await dio
        .get(url,
        options: Options(responseType: ResponseType.json, method: 'GET'))
        .then((response) {
      log(response.toString());
      return response;
    });
  }


}
