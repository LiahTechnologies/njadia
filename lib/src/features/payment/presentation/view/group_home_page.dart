import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/constants/style/appAsset.dart';
import 'package:njadia/src/constants/style/appfont.dart';
import 'package:njadia/src/constants/style/color.dart';
import 'package:njadia/src/features/group_chat/presentation/view/add_group_contact.dart';

import '../../../../common/helper_function.dart';
import '../../../authentication/data/databaseService.dart';
import '../../../group_chat/presentation/widgets/groupTile.dart';

class GroupHomePage extends StatefulWidget {
  const GroupHomePage({super.key});

  @override
  State<GroupHomePage> createState() => _GroupHomePageState();
}

class _GroupHomePageState extends State<GroupHomePage> {
  final TextEditingController searchController = TextEditingController();






  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        body: Container(
          padding: EdgeInsets.only(top: 5.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 1,
                  child: Container(
                    child: Card(
                      elevation: 3,
                      shape: const RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.only(topRight: Radius.circular(25))),
                      child: Container(
                        padding: EdgeInsets.only(top: 10.h),
                        width: double.infinity,
                        child: Column(
                          children: [
                            Image.asset(AppImages.DM_ICON),
                           
                            IconButton(
                                onPressed: () => Get.toNamed(
                                    AppRoutes.CREATE_GROUP_TEMPLATE),
                                icon: const Icon(
                                  Icons.add,
                                  color: AppColor.greenColor,
                                  size: 35,
                                )),
                            Image.asset(AppImages.JOIN_GROUP_ICON)
                          ],
                        ),
                      ),
                    ),
                  )),
              Expanded(
                flex: 5,
                child: Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Ekondo Titi",
                                style: AppFonts.heading2,
                              ),
                            ),
                            IconButton(
                                onPressed: () {}, icon: Icon(Icons.more_horiz))
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 10.h),
                        ),
                        Image.asset(AppImages.GROUP_DEFAULT_ICON),
                        Text(
                          "Find your friends",
                          style: AppFonts.heading1,
                        ),
                        Text(
                          "sync your contacts and start chatting",
                          style: AppFonts.defaultFonts3,
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        CustomButton(
                          onPress: () {
                            // Get.toNamed(AppRoutes.addContacts);
                            Get.bottomSheet(AddContacts(),
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15),
                                  topRight: Radius.circular(15),
                                )),
                                enableDrag: true,
                                isScrollControlled: true);
                          },
                          text: "Get Start",
                          width: 180.w,
                          icon: null,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                  flex: 1,
                  child: Card(
                    elevation: 3,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.only(topLeft: Radius.circular(25))),
                    child: SizedBox(
                      height: double.infinity,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: IconButton(
                          icon: Icon(Icons.menu_outlined),
                          onPressed: () {
                            Get.toNamed(AppRoutes.GROUP_MENU_PAGE);
                          },
                        ),
                      ),
                    ),
                  ))
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
          height: 50.h,
          color: AppColor.greenColor.withOpacity(0.1),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(
                AppImages.DASHBOARD_GROUp_ICON,
                color: AppColor.greenColor,
              ),
              InkWell(
                  onTap: () {
                    Get.toNamed(AppRoutes.ADD_USERS_LINK);
                  },
                  child: Image.asset(AppImages.TWO_PEOPLE_ICON)),
              Stack(
                children: [
                  Image.asset(AppImages.NOTIFICATION_ICON),
                  Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                          width: 15.w,
                          height: 15.h,
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(25),
                          ),
                          child: Center(
                            child: Text(
                              "250",
                              style:
                                  AppFonts.defaultWhite.copyWith(fontSize: 8),
                            ),
                          )))
                ],
              ),
              Image.asset(AppImages.FACE_ICON),
            ],
          ),
        )),
      ),
    );
  }

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
}
