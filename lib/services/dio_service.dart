import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:dio/dio.dart' as dio_service;
import 'package:get_storage/get_storage.dart';

class DioService {
  Dio dio = Dio();
  Future<dynamic> getMethod(String url) async {
    return await dio
        .get(url,
            options: Options(method: 'GET', responseType: ResponseType.json))
        .then((response) {
      log(response.toString());
      return response;
    }).catchError((err){
      if(err is DioException)
        {
          return err.response!;
        }
    });
  }

  Future<dynamic> postMethod(Map<String,dynamic> map,String url)async{

    var token=GetStorage().read('token');
    if(token!=null)
    {
    dio.options.headers['authorization'] = '$token';
    }

    return await dio.post(url,data: dio_service.FormData.fromMap(map),options: Options(
      responseType: ResponseType.json,
      method: 'POST'
    )).then((value) {
      log(value.headers.toString());
      log(value.data.toString());
      log(value.statusCode.toString());
      return value;
    }).catchError((err){
      if(err is DioException)
        {
          return err.response!;
        }
    });
  }
}
