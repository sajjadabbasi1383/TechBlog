import 'package:get/get.dart';
import 'package:tech_blog/controller/list_article_controller.dart';
import 'package:tech_blog/controller/manage_article_controller.dart';
import 'package:tech_blog/controller/register_controller.dart';
import 'package:tech_blog/controller/single_article_controller.dart';

class ArticleBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ListArticleController());
    Get.lazyPut(() => SingleArticleController());
  }
}
class ArticleManagerBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ManageArticleController());
  }
}

class RegisterBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(RegisterController());
  }
}

