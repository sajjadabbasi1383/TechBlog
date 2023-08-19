import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:tech_blog/gen/assets.gen.dart';

import '../component/my_color.dart';
import '../component/my_component.dart';

class ArticleSingleScreen extends StatelessWidget {
  const ArticleSingleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;
    double bodyMargin = size.width / 21;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                CachedNetworkImage(
                  imageUrl: "",
                  imageBuilder: (context, imageProvider) {
                    return Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(17),
                          image: DecorationImage(
                            image: imageProvider,
                            fit: BoxFit.cover,
                          )),
                    );
                  },
                  placeholder: (context, url) => const SpinKitFadingCube(
                    color: SolidColors.primaryColor,
                    size: 30,
                  ),
                  errorWidget: (context, url, error) => Image.asset(
                    Assets.images.singlePlaceHolder.path,
                  ),
                ),
                Positioned(
                    top: 0,
                    right: 0,
                    left: 0,
                    child: Container(
                      height: 70,
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: GradientColors.singleAppbarGradiant)),
                      child: const Row(
                        children: [
                          SizedBox(
                            width: 18,
                          ),
                          Icon(
                            Icons.arrow_back,
                            size: 26,
                            color: Colors.white,
                          ),
                          Expanded(child: SizedBox()),
                          Icon(
                            Icons.bookmark_outline,
                            size: 24,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Icon(
                            Icons.share,
                            size: 21,
                            color: Colors.white,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                        ],
                      ),
                    )),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(9.0),
              child: Text(
                "۵ بازی مشابه Assassin’s Creed Valhalla که باید بازی کنید",
                style: textTheme.labelLarge,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image(
                      image: Assets.images.profileAvatar.provider(),
                      height: 44),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "سجاد عباسی",
                    style: textTheme.headlineMedium,
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  Text(
                    "2 روز پیش",
                    style: textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, right: 15, top: 3),
              child: HtmlWidget(
                '''
                آخرین بازی از فرنچایز اساسینز کرید یعنی بازی اساسینز کرید والهالا، یکی از آن بازی‌های گسترده و جهان بازی است که داستان وایکینگ‌ها را روایت می‌کند و جنبه‌های اکشن ادونچر (ماجراجویی) آن با تکیه بر المان‌های نقش‌آفرینی گیمرهای زیادی را به تحسین وا داشته است. در این بین باید اشاره کنیم که بسته الحاقی Dawn of Ragnarok هم مدتی است که عرضه شده و اگر طرفدار این بازی باشید به احتمال زیاد تا به الآن باید آن را تجربه کرده و چشم‌انتظار قسمت بعدی نشسته‌اید. پس با ویجیاتو و معرفی ۵ بازی مشابه Assassin’s Creed Valhalla همراه باشید.\r\n\r\nاز داستان‌سرایی مثال‌زدنی تا شخصیت پردازی‌ و طراحی و موسیقی‌های به کار رفته در Assassin’s Creed Valhalla همگی باعث می‌شوند تا این قسمت از مجموعه حرف‌های زیادی برای گفتن داشته باشد و هویت شکل گرفته تازه در میان این فرنچایز را به درجه بالایی برساند. یوبی‌سافت مونترال به واسطه طراحی و چینش درست مکانیزم‌های گیم‌پلی و سیستم کلی بازی سعی داشته تا این بار حس غوطه‌وری بیشتری را برای گیمر به ارمغان بیاورد و خوشبختانه اساسینز کرید والهالا حسابی به منبع ژانر خود وفادار است؛ مساله‌‎ای که بسیاری را ناخشنود و در عوض رضایت عده‌ای را به دست آورده است.
                ''',
                enableCaching: true,
                onLoadingBuilder: (context, element, loadingProgress) =>
                    const SpinKitFadingCube(
                  color: SolidColors.primaryColor,
                  size: 27,
                ),
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            SizedBox(
              height: 60,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: 4,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.fromLTRB(
                        5, 8, index == 0 ? bodyMargin : 5, 8),
                    child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: SolidColors.greyColor2),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(16, 8, 10, 8),
                          child: Center(
                            child: Text(
                              "sajjad abbasi",
                              style: textTheme.headlineMedium,
                            ),
                          ),
                        )),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
