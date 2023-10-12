import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/features/authentication/controllers/authentication_service.dart';
import 'package:njadia/src/features/group_chat/presentation/controller/create_group_service.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/utils/customInput.dart';
import 'package:njadia/src/constants/style/appAsset.dart';

import '../../../../common/helper_function.dart';
import '../../../../utils/CustomButton.dart';
import '../../../../constants/style/appfont.dart';
import '../../../../constants/style/color.dart';
import '../../../authentication/data/databaseService.dart';
import '../widgets/groupTile.dart';

class CreateGroup extends StatefulWidget {
  const CreateGroup({super.key});

  @override
  State<CreateGroup> createState() => _CreateGroupState();
}

class _CreateGroupState extends State<CreateGroup> {
  final contorller = CreateGroupService();
  String groupName = '';
  String groupLimit = '';
  String groupAmount = '';

  
  

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
                  alignment: Alignment.topLeft,
                  child: TextButton.icon(
                      onPressed: () {
                        Get.back();
                      },
                      icon: Icon(
                        Icons.arrow_back_ios,
                        color: AppColor.greenColor,
                      ),
                      label: Text(
                        "Back",
                        style: AppFonts.defaultFonts,
                      )),
                ),
                Text("Create your Njangi group", style: AppFonts.heading2),
                Text(
                  "Begin your collective saving journey, hangout and and",
                  style: AppFonts.defaultFonts,
                ),
                Text(
                  "experience the power of communal finance",
                  style: AppFonts.defaultFonts,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Container(
                  width: 140.w,
                  margin: EdgeInsets.symmetric(horizontal: 30.w),
                  child: Stack(children: [
                    DottedBorder(
                        strokeWidth: 2,
                        borderType: BorderType.Circle,
                        radius: Radius.circular(70),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: CircleAvatar(
                              radius: 50.w,
                              backgroundImage: AssetImage(AppImages.PERSON),
                            ))),
                    Positioned(
                        right: 25.w,
                        top: 3.h,
                        child: Container(
                          width: 35.w,
                          height: 35.h,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.black),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 25.w,
                          ),
                        ))
                  ]),
                ),
                SizedBox(
                  height: 20.h,
                ),
                CustomInput(
                  text: "NJANGI NAME",
                  controller: (value) {
                    groupName = value;
                  },
                  hint: "Ekondo Titi Njangi",
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomInput(
                      text: "MEMBERS LIMIT",
                      controller: (value) {
                        groupLimit = value;
                      },
                      hint: "50",
                      width: 140,
                    ),
                    CustomInput(
                      text: "CONTRIBUTION AMOUNT",
                      controller: (value) {
                        setState(() {
                          groupAmount = value;
                        });
                      },
                      hint: "25,000XAF",
                      width: 200,
                    ),
                  ],
                ),
                SizedBox(
                  height: 150.h,
                ),
                Text.rich(TextSpan(children: [
                  TextSpan(
                      text: "By creating a server, you agree to Njadia's",
                      style: AppFonts.defaultFonts3.copyWith(fontSize: 11)),
                  TextSpan(
                      text: " community guidelines",
                      style: AppFonts.defaultFontsBold3),
                ])),
                SizedBox(
                  height: 10.h,
                ),
                CustomButton(
                  onPress: () {
                    print("CREATE BUTTON WAS CLICKED");
                    contorller
                        .createNewNjangiGroup(
                            groupName: groupName,
                            groupLevi: groupAmount,
                            groupLimit: groupLimit)
                        .then((Value) => Get.toNamed(AppRoutes.HOMEpAGE));
                  },
                  text: "CreatE Njangi",
                  icon: null,
                  borderRadius: 12,
                  width: 290.w,
                )
              ],
            ),
          ),
        ));
  }
}
