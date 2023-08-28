import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/component/api_constant.dart';
import 'package:tech_blog/services/dio_service.dart';
import 'package:tech_blog/view/my_cats.dart';
import 'package:tech_blog/view/register_intro.dart';

class RegisterController extends GetxController {
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController activeCodeTextEditingController =
      TextEditingController();
  var email = '';
  var userId = '';

  register() async {
    Map<String, dynamic> map = {
      'email': emailTextEditingController.text,
      'command': 'register'
    };
    var response = await DioService().postMethod(map, ApiConstant.postRegister);
    email = emailTextEditingController.text;
    userId = response.data['user_id'];
    debugPrint(response.toString());
  }

  verify() async {
    Map<String, dynamic> map = {
      'email': email,
      'user_id': userId,
      'code': activeCodeTextEditingController.text,
      'command': 'verify'
    };
    debugPrint(map.toString());
    var response = await DioService().postMethod(map, ApiConstant.postRegister);
    debugPrint(response.data.toString());

    var status = response.data['response'];

    switch (status) {
      case 'verified':
        var box = GetStorage();
        box.write('token', response.data['token']);
        box.write('email', email);
        box.write('user_id', response.data['user_id']);

        debugPrint("read::::"+box.read('token').toString());
        debugPrint("read::::"+box.read('email').toString());
        debugPrint("read::::"+box.read('user_id').toString());
        Get.offAll(const MyCats());
        break;
      case 'incorrect_code':
        Get.snackbar('خطا', "کد فعالسازی غلط است");
        break;
      case 'expired':
        Get.snackbar('خطا', "کد فعالسازی منقضی شده است");
        break;
    }
  }

  toggleLogin() {
    if (GetStorage().read('token') == null) {
      Get.to(RegisterIntro());
    } else {
      debugPrint('postScreen');
    }
  }
}
