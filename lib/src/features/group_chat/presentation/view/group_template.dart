import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/utils/themes/style/appfont.dart';

import '../../../../utils/themes/style/appAsset.dart';

class GroupTemplate extends StatelessWidget {
  const GroupTemplate({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Create Your Njadia Group",
              style: AppFonts.heading1,
            ),
            Text(
              "Begin your collective saving journey. Experience the power",
              style: AppFonts.defaultFonts3,
            ),
            Text(
              "of communal finance",
              style: AppFonts.defaultFonts3,
            ),

            SizedBox(height: 10.h),
            cardListTileWidget(
                image: AppImages.WORLD_ICON, text: "create my own "),
            SizedBox(height: 10.h),
            Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 4.0),
                  child: Text("START FROM A TEMPLATE",
                      style: AppFonts.defaultFontsBold3),
                )),
            SizedBox(height: 10.h),

            cardListTileWidget(
                image: AppImages.WORLD1_ICON, text: "Famers Njangi "),
            cardListTileWidget(
                image: AppImages.WORLD2_ICON, text: "Smaill Businesses "),
            cardListTileWidget(image: AppImages.WORLD_ICON, text: "Friends"),
            cardListTileWidget(image: AppImages.WORLD3_ICON, text: "Friends "),

            // cardListTileWidget(
            // image: AppImages.WORLD4_ICON, text: "Local Community "),

            cardListTileWidget(
                image: AppImages.WORLD5_ICON, text: "Local Community "),
            SizedBox(height: 30.h),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
              child: Text("Have an invitation?", style: AppFonts.heading3),
            ),

          
          
          
          
          
          
          
          
          ],
        ),
      ),
    ));
  }

  cardListTileWidget({image, text}) {
    return Card(
        child: SizedBox(
      height: 60.h,
      child: ListTile(
        leading: Image.asset(
          image,
          width: 30,
        ),
        title: Text(text),
        trailing: Icon(Icons.arrow_forward_ios_outlined),
      ),
    ));
  }
}
