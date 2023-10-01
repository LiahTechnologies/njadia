import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/constants/style/appfont.dart';
import 'package:njadia/src/constants/style/color.dart';

class SelectGroupMember extends StatelessWidget {
  const SelectGroupMember({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.back();
                      },
                      child: Text(
                        "Close",
                        style: AppFonts.defaultFonts3,
                      ),
                    ),
                    SizedBox(
                      width: 70.w,
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
                Container(
                  child: TextField(
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: "Chukwi Obi",
                        hintStyle: TextStyle(color: AppColor.greenColor),
                        suffixIcon: Icon(
                          Icons.cancel_outlined,
                          color: AppColor.greenColor,
                        )),
                  ),
                ),
                Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.only(left: 10.w),
                  height: 50.h,
                  width: double.infinity,
                  color: AppColor.greenColor,
                  child: Text(
                    "Members",
                    style: AppFonts.defaultWhite,
                  ),
                ),
                Expanded(
                    child: ListView.builder(
                        itemCount: 5,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Get.toNamed(AppRoutes.SEND_MONEY_PAGE);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [Text("Gael Indira"), Divider()],
                              ),
                            ),
                          );
                        }))
              ],
            )),
      ),
    );
  }
}
