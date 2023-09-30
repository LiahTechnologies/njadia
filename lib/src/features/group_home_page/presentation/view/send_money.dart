import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/utils/themes/style/appAsset.dart';
import 'package:njadia/src/utils/themes/style/appfont.dart';
import 'package:njadia/src/utils/themes/style/color.dart';

class SendMoney extends StatelessWidget {
  const SendMoney(
      {super.key, this.amount = 25000, this.name = "Erling Haland"});

  final int amount;
  final String name;
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
                  text: "$amount",
                  style: AppFonts.heading3.copyWith(fontSize: 14))
            ])),
            Text.rich(TextSpan(children: [
              TextSpan(text: "To ", style: AppFonts.defaultFonts),
              TextSpan(
                  text: "$name",
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
            SizedBox(
              height: 3.h,
            ),
            InkWell(
                onTap: () {
                  Get.toNamed(AppRoutes.SEND_MONEY_DETAIL_PAGE);

                 
                 
                 
                },
                child: Image.asset(AppImages.MTP)),
            SizedBox(
              height: 3.h,
            ),
            Image.asset(AppImages.ORANGE),
          ],
        )),
      ),
    );
  }









}
