import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:tech_blog/component/api_constant.dart';
import 'package:tech_blog/services/dio_service.dart';

class RegisterController extends GetxController{
  TextEditingController emailTextEditingController=TextEditingController();
  TextEditingController activeCodeTextEditingController=TextEditingController();
  var email='';
  var userId='';

  register()async{
    Map<String,dynamic> map={
      'email':emailTextEditingController.text,
      'command':'register'
    };
    var response=await DioService().postMethod(map, ApiConstant.postRegister);
    email=emailTextEditingController.text;
    userId=response.data['user_id'];
    debugPrint(response.toString());
  }

  verify()async{
    Map<String,dynamic> map={
      'email':email,
      'user_id':userId,
      'code':activeCodeTextEditingController.text,
      'command':'verify'
    };
    print(map);
    var response=await DioService().postMethod(map, ApiConstant.postRegister);
    print(response.data);
  }

}