import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/component/api_constant.dart';
import 'package:tech_blog/component/my_string.dart';
import 'package:tech_blog/gen/assets.gen.dart';
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
      routeToWriteBottomShit();
    }
  }


  routeToWriteBottomShit(){
    Get.bottomSheet(
      Container(
        height: Get.height/3,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Colors.white
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SvgPicture.asset(Assets.images.tcbot,height: 50,),
                  const SizedBox(width: 14,),
                  Text(MyStrings.shareKnowledge,style: const TextStyle(fontSize: 16),)
                ],
              ),
              const SizedBox(height: 25,),
              Text(MyStrings.gigTech,style: const TextStyle(fontSize: 13),),
              const SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: ()=>debugPrint("manage article"),
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Image.asset(Assets.icons.writeArticle.path,height: 32,),
                          const SizedBox(width: 15,),
                          Text(MyStrings.titleAppBarManageArticle,style: const TextStyle(fontSize: 15))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: ()=>debugPrint("manage podcast"),
                    child: Container(
                      color: Colors.white,
                      child: Row(
                        children: [
                          Image.asset(Assets.icons.writePodcastIcon.path,height: 35,),
                          const SizedBox(width: 15,),
                          Text(MyStrings.managePodcast,style: const TextStyle(fontSize: 15))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
