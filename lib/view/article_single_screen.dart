import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tech_blog/gen/assets.gen.dart';

import '../component/my_color.dart';

class ArticleSingleScreen extends StatelessWidget {
  const ArticleSingleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
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
                            image: imageProvider, fit: BoxFit.cover)),
                  );
                },
                placeholder: (context, url) => const SpinKitFadingCube(
                  color: SolidColors.primaryColor,
                  size: 50,
                ),
                errorWidget: (context, url, error) =>
                    Image.asset(Assets.images.singlePlaceHolder.path),
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
                        SizedBox(width: 18,),
                        Icon(Icons.arrow_back,size: 26,color: Colors.white,),
                        Expanded(child: SizedBox()),
                        Icon(Icons.bookmark_outline,size: 24,color: Colors.white,),
                        SizedBox(width: 10,),
                        Icon(Icons.share,size: 21,color: Colors.white,),
                        SizedBox(width: 15,),
                      ],
                    ),
                  )),
            ],
          ),
        ],
      ),
    ));
  }
}
