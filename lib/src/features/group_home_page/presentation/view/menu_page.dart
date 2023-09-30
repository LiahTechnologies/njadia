import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/features/group_chat/presentation/widgets/custom_card_items.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/utils/themes/style/appAsset.dart';
import 'package:njadia/src/utils/themes/style/appfont.dart';
import 'package:njadia/src/utils/themes/style/color.dart';

class GroupMenuPage extends StatelessWidget {
  const GroupMenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: SafeArea(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10.w),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.menu_outlined,
                            color: AppColor.greenColor,
                          )),
                      Text(
                        "# General",
                        style: AppFonts.defaultFonts,
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.search_outlined,
                            color: AppColor.greenColor,
                          )),
                      IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.person_outline,
                            color: AppColor.greenColor,
                          ))
                    ],
                  )
                ],
              ),
              Container(
                height: 360.h,
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 70.h,
                  width: 70.w,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(35),
                      color: AppColor.blackColor.withOpacity(0.1)),
                  child: Center(
                      child: Text(
                    "#",
                    style: AppFonts.defaultWhite.copyWith(fontSize: 35),
                  )),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0.h),
                  child: Text(
                    "Welcome to Ekondo Njangi",
                    style: AppFonts.heading3,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: 8.0.h),
                  child: Text(
                    "This is your brand new, shiny Njangi group.",
                    style: AppFonts.defaultFonts,
                  ),
                ),
              ),
              CustomCardItems(
                  image: AppImages.TWO_PEOPLE_ICON,
                  text: "set up your njangi group",
                  onTap: () {
                    Get.toNamed(AppRoutes.SELECT_GROUP_MEMBER_PAGE);
                  }),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                        onPressed: () {}, icon: const Icon(Icons.add_outlined)),
                    SizedBox(
                      width: 230.w,
                      child: TextField(
                        decoration: InputDecoration(
                            hintText: "Message@Miles Nguimisong",
                            border: InputBorder.none),
                      ),
                    ),
                    Image.asset(AppImages.FACE_ICON),
                    Image.asset(AppImages.VOICE_RECORD),
                    // Icon(Icons.record)
                  ],
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
