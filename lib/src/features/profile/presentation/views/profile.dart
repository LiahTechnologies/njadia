import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/constants/style/appAsset.dart';
import 'package:njadia/src/constants/style/color.dart';
import 'package:njadia/src/utils/opneCamera.dart';
import 'package:njadia/src/warnings/customDialog.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';

import '../../../../warnings/customeNotification.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  late File newProfileImage;
  bool isDarkness = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const CustomBackArrow(),
        centerTitle: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: isDarkness
                  ? IconButton(
                      icon: Icon(Icons.sunny),
                      onPressed: () {
                        setState(() {
                          isDarkness = !isDarkness;
                        });
                      },
                    )
                  : IconButton(
                      onPressed: () {
                        setState(() {
                          isDarkness = !isDarkness;
                        });
                      },
                      icon: Icon(Icons.dark_mode)),
            ),
            Center(
              child: Stack(
                children: [
                  ClipOval(
                      child: Image.asset(
                    AppImages.PERSON,
                    width: 130,
                  )),
                  Positioned(
                    top: 20.h,
                    left: 90.w,
                    child: InkWell(
                      onTap: () => openCamera("gallery").then((value) {
                        // setState(() {
                        //   newProfileImage = value;
                        // });
                      }),
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                        height: 35,
                        width: 35,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.whiteColor),
                        child: Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: AppColor.greenColor),
                            child: Icon(
                              Icons.edit,
                              color: AppColor.whiteColor,
                              size: 15,
                            )),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5.h,
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 4.0),
              child: Text(
                "Tekstedia lexi",
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontWeight: FontWeight.w900),
              ),
            ),

            // Stack(
            //   children: [

            //       Positioned(
            //         top: 22.h,
            //         left: 75.w,
            //         child: InkWell(
            //           onTap: () {},

            //           child: Container(
            //             padding:
            //                 EdgeInsets.symmetric(horizontal: 3, vertical: 3),
            //             height: 19,
            //             width: 19,
            //             decoration: BoxDecoration(
            //                 borderRadius: BorderRadius.circular(20),
            //                 color: AppColor.whiteColor),
            //             child: Container(
            //                 height: 19,
            //                 width: 19,
            //                 decoration: BoxDecoration(
            //                     borderRadius: BorderRadius.circular(20),
            //                     color: AppColor.purpleColor),
            //                 child: Icon(
            //                   Icons.edit,
            //                   color: AppColor.whiteColor,
            //                   size: 10,
            //                 )),
            //           ),
            //         ),
            //       )
            //   ],
            // ),
            Text("lexi@gmail.com",
                style: Theme.of(context).textTheme.displayMedium),
            SizedBox(
              height: 10.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                profileText(number: 23, text: "Njangi groups"),
                Container(
                  height: 40,
                  width: 2,
                  color: AppColor.greenColor,
                ),
                profileText(number: 23, text: "Age"),
                Container(
                  height: 40,
                  width: 2,
                  color: AppColor.greenColor,
                ),
                Stack(
                  children: [
                    profileText(number: 672973390, text: "Telephone"),
                    Positioned(
                      top: 22.h,
                      left: 75.w,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => const CustomDailog());
                        },
                        child: Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 3, vertical: 3),
                          height: 19,
                          width: 19,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.whiteColor),
                          child: Container(
                              height: 19,
                              width: 19,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.greenColor),
                              child: Icon(
                                Icons.edit,
                                color: AppColor.whiteColor,
                                size: 10,
                              )),
                        ),
                      ),
                    )
                  ],
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: Column(
                    children: [Text("")],
                  ),
                )
              ],
            ),
            customKeyValue(text: "Current MTN Account Balance:", value: 23),
            customKeyValue(text: "Current Orange Account Balance:", value: 33),
          ]),
    );
  }

  profileText({number, text}) {
    return Column(
      children: [
        Text(
          "$number",
          style: Theme.of(context)
              .textTheme
              .displayLarge!
              .copyWith(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        Text(
          "$text",
          style: Theme.of(context).textTheme.displayMedium,
        )
      ],
    );
  }

  customKeyValue({text, value}) {
    return Container(
      width: 380.w,
      height: 50.h,
      margin: EdgeInsets.symmetric(horizontal: 15.w, vertical: 3.h),
      child: Card(
        color: Theme.of(context).cardTheme.color,
        elevation: 3.0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(
              text,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            Text(
              "$value",
              style: Theme.of(context).textTheme.displayMedium,
            )
          ]),
        ),
      ),
    );
  }
}
