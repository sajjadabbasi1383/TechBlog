import 'package:get/get.dart';
import 'package:tech_blog/routeManager/names.dart';
import 'package:tech_blog/view/article/article_single_manage_screen.dart';
import 'package:tech_blog/view/article/article_single_screen.dart';
import 'package:tech_blog/view/article/manage_article_screen.dart';
import 'package:tech_blog/view/podcast/podcast_single_screen.dart';
import 'package:tech_blog/view/main/splash_screen.dart';

import '../view/main/main_screen.dart';
import 'binding.dart';

class Pages{

  Pages._();

  static List<GetPage<dynamic>> pages=[
  GetPage(name: NamedRoute.routeMainScreen, page: ()=>MainScreen(),binding: RegisterBinding()),
  GetPage(name: NamedRoute.initialRoute, page: ()=>const SplashScreen()),
  GetPage(name: NamedRoute.routeSingleArticle, page: ()=>const ArticleSingleScreen(),binding: ArticleBinding()),
  GetPage(name: NamedRoute.routeManageArticle, page: ()=> ManageArticle(),binding: ArticleManagerBinding()),
  GetPage(name: NamedRoute.routeArticleSingleManage, page: ()=>  ArticleSingleManageScreen(),binding: ArticleManagerBinding()),
  GetPage(name: NamedRoute.routeSinglePodcast, page: ()=>  SinglePodcast()),
  ];
}