import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/features/group_chat/presentation/widgets/custom_card_items.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/utils/themes/style/appAsset.dart';
import 'package:njadia/src/utils/themes/style/appfont.dart';
import 'package:njadia/src/utils/themes/style/color.dart';

class GroupCategory extends StatelessWidget {
  const GroupCategory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: Column(
          children: [
            Row(
              children: [
                TextButton.icon(
                    onPressed: () => Get.back(),
                    icon: const Icon(
                      Icons.arrow_back_ios,
                      color: AppColor.greenColor,
                    ),
                    label: Text(
                      "Back",
                      style: AppFonts.defaultFonts,
                    )),
              ],
            ),
            Text(
              "Tell us more about your Njangi Group",
              style: AppFonts.heading3,
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              "In order to help you with the setup, is your new ngangi group",
              style: AppFonts.defaultFonts3,
            ),
            Text(
              "just for a few friends or a large community",
              style: AppFonts.defaultFonts3,
            ),
            SizedBox(
              height: 25.h,
            ),
            CustomCardItems(
                image: AppImages.TWO_PEOPLE_ICON,
                text: "For me and my Friends",
                onTap: () {
                  Get.toNamed(AppRoutes.CREATE_GROUP);
                }),
            CustomCardItems(
                image: AppImages.TWO_PEOPLE_ICON,
                text: "For a club or a community",
                onTap: () {}),
            SizedBox(
              height: 25.h,
            ),
            Text.rich(TextSpan(children: [
              TextSpan(text: "Not sure? ", style: AppFonts.defaultFonts),
              TextSpan(text: "You can ", style: AppFonts.defaultFonts),
              TextSpan(text: "skip this question ", style: AppFonts.heading3),
              TextSpan(text: "Not sure? ", style: AppFonts.defaultFonts)
            ]))
          ],
        ),
      ),
    ));
  }
}
