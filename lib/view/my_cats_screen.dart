import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tech_blog/component/my_component.dart';
import 'package:get/get.dart';
import 'package:tech_blog/constant/my_string.dart';
import 'package:tech_blog/controller/register_controller.dart';
import 'package:tech_blog/models/tags_model.dart';

import '../constant/dimens.dart';
import '../controller/home_screen_controller.dart';
import '../gen/assets.gen.dart';
import '../constant/my_color.dart';

class MyCats extends StatefulWidget {
  const MyCats({super.key});

  @override
  State<MyCats> createState() => _MyCatsState();
}

class _MyCatsState extends State<MyCats> {
  final HomeScreenController homeScreenController = Get.put(HomeScreenController());
  final TextEditingController nameFamilyTextEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;

    RxBool myLoading = false.obs;

    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(left: Dimens.bodyMargin, right: Dimens.bodyMargin),
            child: Column(
              children: [
                const SizedBox(
                  height: 25,
                ),
                SvgPicture.asset(
                  Assets.images.tcbot,
                  height: 120,
                ),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  MyStrings.successfulRegistration,
                  style: textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),
                TextField(
                  controller: nameFamilyTextEditingController,
                  textAlign: TextAlign.center,
                  style: textTheme.headlineSmall,
                  decoration: InputDecoration(
                      hintText: "نام و نام خانوادگی",
                      hintStyle: textTheme.headlineSmall),
                ),
                const SizedBox(
                  height: 25,
                ),
                Text(
                  MyStrings.chooseCats,
                  style: textTheme.titleSmall,
                  textAlign: TextAlign.center,
                ),

                //tag list
                Obx(
                  () => myLoading.value==false
                      ? Padding(
                          padding: const EdgeInsets.only(top: 25),
                          child: SizedBox(
                            width: double.infinity,
                            height: 86,
                            child: GridView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const BouncingScrollPhysics(),
                              itemCount: homeScreenController.tagList.length,
                              shrinkWrap: true,
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 6,
                                      mainAxisSpacing: 6,
                                      childAspectRatio: 0.22
                                      //childAspectRatio: 0.5
                                      ),
                              itemBuilder: (context, index) {
                                return InkWell(
                                    onTap: () {
                                      setState(() {
                                        if (!selectedTags.contains(
                                            homeScreenController
                                                .tagList[index])) {
                                          selectedTags.add(homeScreenController
                                              .tagList[index]);
                                        }
                                      });
                                    },
                                    child: MainTags(
                                        textTheme: textTheme, index: index));
                              },
                            ),
                          ),
                        )
                      : const Padding(
                        padding: EdgeInsets.all(10.0),
                        child: SpinKitFadingCube(
                            color: SolidColors.primaryColor,
                            size: 30,
                          ),
                      ),
                ),

                const SizedBox(
                  height: 14,
                ),
                Image.asset(
                  Assets.icons.downCatArrow.path,
                  scale: 2.2,
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 25),
                  child: SizedBox(
                    width: double.infinity,
                    height: 86,
                    child: GridView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: const BouncingScrollPhysics(),
                      itemCount: selectedTags.length,
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 6,
                              mainAxisSpacing: 6,
                              childAspectRatio: 0.22
                              //childAspectRatio: 0.5
                              ),
                      itemBuilder: (context, index) {
                        return Container(
                            height: 60,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(18),
                                color: SolidColors.surface),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 8, 10, 8),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    selectedTags[index].title!,
                                    style: textTheme.headlineMedium,
                                  ),
                                  InkWell(
                                      onTap: () {
                                        setState(() {
                                          selectedTags.removeAt(index);
                                        });
                                      },
                                      child: const Icon(
                                        CupertinoIcons.delete,
                                        size: 20,
                                        color: Colors.grey,
                                      )),
                                ],
                              ),
                            ));
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 13,
                ),

                ElevatedButton(
                    onPressed: () {
                      if (nameFamilyTextEditingController.text == "") {
                        showAlertNameDialog(context);
                      } else {
                        var box=GetStorage();
                        nameFamilyTextEditingController.text==''?box.write('nameFamily','سجاد عباسی'):box.write('nameFamily',nameFamilyTextEditingController.text);
                        Get.find<RegisterController>().completeRegistration();
                      }
                    },
                    child: const Text("ثبت")),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  showAlertNameDialog(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    // set up the button
    Widget okButton = TextButton(
      child: Text(
        "باشه",
        style: textTheme.titleSmall,
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "لطفا نام و نام خانوادگی را وارد کنید.",
        style: textTheme.titleSmall,
      ),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
