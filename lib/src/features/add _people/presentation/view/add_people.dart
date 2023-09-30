import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/utils/themes/style/appAsset.dart';
import 'package:njadia/src/utils/themes/style/color.dart';

import '../../../../utils/themes/style/appfont.dart';

class AddUserLink extends StatelessWidget {
  final TextEditingController linkController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      child: Text(
                        "Skip",
                        style: AppFonts.defaultFonts,
                      )),
                ),
                Text(
                  "Add some people",
                  style: AppFonts.heading3,
                ),
                Text(
                  "You will need members to get the most out of your ",
                  style: AppFonts.defaultFonts,
                ),
                Text(
                  "Njangi group",
                  style: AppFonts.defaultFonts,
                ),
                Container(
                  margin: EdgeInsets.only(top: 10.h),
                  child: Image.asset(AppImages.PERSON),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10.h, top: 10.h),
                  child: TextField(
                    controller: linkController,
                    decoration: const InputDecoration(
                        suffixIcon: Icon(
                          Icons.link_outlined,
                          color: AppColor.greenColor,
                        ),
                        hintText: "https://njadi.liah",
                        border: InputBorder.none),
                  ),
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "Your invitation link should expire in 7 days.",
                      style: AppFonts.defaultFonts),
                  TextSpan(text: "Edit invite link.", style: AppFonts.heading3),
                ])),
                SizedBox(
                  height: 20.h,
                ),
                CustomButton(
                  onPress: () {},
                  text: "Share Link",
                  icon: null,
                  width: 300,
                )
              ],
            )),
      ),
    );
  }
}
