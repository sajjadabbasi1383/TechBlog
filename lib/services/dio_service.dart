import 'dart:developer';

import 'package:dio/dio.dart';

class DioService {
  Future<dynamic> getMethod(String url) async {
    Dio dio = Dio();
    dio.options.headers['content-Type'] = "application/json";
    return await dio
        .get(url,
            options: Options(method: 'GET', responseType: ResponseType.json))
        .then((response) {
      log(response.toString());
      return response;
    });
  }
}
