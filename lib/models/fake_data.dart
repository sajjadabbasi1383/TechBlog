import 'package:tech_blog/gen/assets.gen.dart';

import 'data_models.dart';

Map homePagePosterMap = {
  "image": Assets.images.posterTest.provider(),
  "writer": "سجاد عباسی",
  "date": "یک روز پیش",
  "title": "دوازده قدم تا تبدیل شدن به برنامه نویس...",
  "view": "253"
};

List<HashTagModel> taglist = [
  HashTagModel(title: "جاوا",),
  HashTagModel(title: "کاتلین",),
  HashTagModel(title: "فلاتر",),
  HashTagModel(title: "سی شارپ"),
  HashTagModel(title: "هوش مصنوعی"),
  HashTagModel(title: "پایتون",),
  HashTagModel(title: "برنامه نویسی وب"),
  HashTagModel(title: "وردپرس", ),
];

List<HashTagModel> selectedTags=[];