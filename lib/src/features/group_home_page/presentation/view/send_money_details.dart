import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/constants/style/appAsset.dart';
import 'package:njadia/src/constants/style/appfont.dart';
import 'package:njadia/src/constants/style/color.dart';

class SendMoneyDetail extends StatelessWidget {
  SendMoneyDetail(
      {super.key, this.amount = 25000, this.name = "Erling Haland"});

  final int amount;
  final String name;
  bool isLoading = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            child: Column(
          children: [
            SizedBox(
              // width: 250.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  TextButton.icon(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: AppColor.greenColor,
                      ),
                      label: Text(
                        "Back",
                        style: AppFonts.defaultFonts,
                      )),
                  SizedBox(
                    width: 50.w,
                  ),
                  Column(
                    children: [
                      Text(
                        "Send  Money",
                        style: AppFonts.heading3,
                      ),
                      Text(
                        "Ekondo Njangi",
                        style: AppFonts.defaultFonts,
                      ),
                    ],
                  )
                ],
              ),
            ),
            Divider(),
            Text.rich(TextSpan(children: [
              TextSpan(text: "Send the sum of", style: AppFonts.defaultFonts),
              TextSpan(
                  text: " ${this.amount}",
                  style: AppFonts.heading3.copyWith(fontSize: 14))
            ])),
            Text.rich(TextSpan(children: [
              TextSpan(text: "To ", style: AppFonts.defaultFonts),
              TextSpan(
                  text: "${this.name}",
                  style: AppFonts.heading3.copyWith(fontSize: 14))
            ])),
            SizedBox(
              height: 5.h,
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.only(left: 20.w),
              height: 50.h,
              width: double.infinity,
              color: AppColor.greenColor,
              child: Text(
                "PAYMENT METHOD",
                style: AppFonts.defaultWhite,
              ),
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 18.0),
                child: Text(
                  "MoMo User",
                  style: AppFonts.defaultBlack.copyWith(fontSize: 20),
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Recipient Number",
                    style: AppFonts.defaultFonts,
                  ),
                  Text(
                    "670034409",
                    style: AppFonts.defaultFonts,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColor.greenColor)),
                    child: Row(
                      children: [Text("Change"), Icon(Icons.arrow_drop_down)],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 15.h, horizontal: 10.w),
              child: TextField(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Amount (XAF)",
                    style: AppFonts.defaultFonts,
                  ),
                  Text(
                    "25,000",
                    style: AppFonts.defaultFonts,
                  ),
                  Container(
                    padding: EdgeInsets.all(5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColor.greenColor)),
                    child: Row(
                      children: [Text("Change"), Icon(Icons.arrow_drop_down)],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              child: TextField(),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.only(left: 15.0.w, top: 10.h),
                child: Text(
                  "My Reference",
                  style: AppFonts.defaultFonts,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 5.h, horizontal: 10.w),
              child: TextField(
                decoration: InputDecoration(
                    hintText:
                        "My njangi payment to Erling Haland in Ekondo Njangi",
                    hintStyle: TextStyle(fontSize: 14)),
              ),
            ),
            SizedBox(
              height: 50.h,
            ),
            CustomButton(
              onPress: () {
                !isLoading
                    ? Get.bottomSheet(
                        showCustomeButtonSheet(
                            image: AppImages.PROCESSING_ICON),
                        enableDrag: true)
                    : Get.bottomSheet(
                        showCustomeButtonSheet(
                            image: AppImages.DONE__ICON,
                            text: "Done",
                            subtitle: "Continue",
                            fonts: 19),
                        enableDrag: true);
              },
              text: "PLAY YOUR NJANGI",
              width: 250.w,
              icon: null,
            )
          ],
        )),
      ),
    );
  }

  showCustomeButtonSheet({image, text, String? subtitle, double? fonts}) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(image),
          SizedBox(
            height: 20.h,
          ),
          Center(
            child: Text(
              "$text",
              style: AppFonts.defaultFonts.copyWith(fontSize: fonts!),
            ),
          ),
          Center(
            child: Text(
              "$subtitle",
              style: AppFonts.defaultFonts,
            ),
          )
        ],
      ),
    );
  }
}
