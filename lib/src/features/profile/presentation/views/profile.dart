import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/constants/style/appAsset.dart';
import 'package:njadia/src/constants/style/color.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/utils/opneCamera.dart';
import 'package:njadia/src/utils/theme/themeController.dart';
import 'package:njadia/src/utils/theme/themes.dart';
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


  final Controller = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        centerTitle: true,
        title: Text(
          "Profile",
          style: Theme.of(context).textTheme.titleMedium,
        ),
        actions: [
          !Get.isDarkMode
              ? IconButton(
                  icon: Icon(
                    Icons.sunny,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  onPressed: () {
                    Get.isDarkMode
                        ? Get.changeTheme(AppTheme.darkTheme)
                        : Get.changeTheme(AppTheme.lightTheme);
                    Controller.changeTheme(true);
                    // Get.changeThemeMode(
                    //     Get.isDarkMode ? AppTheme.darkTheme : ThemeMode.light);
                  },
                )
              : IconButton(
                  onPressed: () {
                    Get.isDarkMode
                        ? Get.changeTheme(AppTheme.darkTheme)
                        : Get.changeTheme(AppTheme.lightTheme);
                    Controller.changeTheme(false);
                  },
                  icon: Icon(
                    Icons.dark_mode,
                    color: Theme.of(context).iconTheme.color,
                  )),
          IconButton(
              onPressed: () {
                Get.toNamed(AppRoutes.LOGIN);
              },
              icon: Icon(
                Icons.logout,
                color: Theme.of(context).iconTheme.color,
              )),
        ],
      ),
      body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
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
                    left: 96.w,
                    child: InkWell(
                      onTap: () => openCamera(method:"gallery").then((value) {
                        // setState(() {
                        //   newProfileImage = value;
                        // });
                      }),
                      child: Container(
                        padding:
                            EdgeInsets.all(2),
                        
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: AppColor.whiteColor),
                        child: Container(
                            height: 22.h,
                            width: 22.w,
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
                      top: 20.h,
                      left: 79.w,
                      child: InkWell(
                        onTap: () {
                          showDialog(
                              context: context,
                              builder: (context) => const CustomDailog());
                        },
                        child: 
                              Icon(
                                Icons.edit,
                                color: AppColor.greenColor,
                                size: 15,
                              )
                        
                        /* Container(
                          padding:
                              EdgeInsets.all(1),
                          // height: 16,
                          // width: 16,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: AppColor.whiteColor),
                          child: Container(
                              height: 15,
                              width: 15,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: AppColor.greenColor),
                              child: 
                              Icon(
                                Icons.edit,
                                color: AppColor.whiteColor,
                                size: 10,
                              )
                              ),
                        ),*/
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
        color: Theme.of(context).colorScheme.primary,
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
