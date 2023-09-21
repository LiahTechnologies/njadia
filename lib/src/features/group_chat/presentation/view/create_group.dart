import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/utils/themes/style/appAsset.dart';
import 'package:njadia/src/utils/themes/style/appfont.dart';
import 'package:njadia/src/utils/themes/style/color.dart';
import 'package:njadia/src/features/group_chat/presentation/view/add_contact.dart';

class createGroup extends StatefulWidget {
  const createGroup({super.key});

  @override
  State<createGroup> createState() => _createGroupState();
}

class _createGroupState extends State<createGroup> {
  final TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          padding: EdgeInsets.only(left: 4.w, right: 4.w, top: 10.h),
          child: Row(
            children: [
              Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      Image.asset(AppImages.CREATE_GROUP_ICON),
                      IconButton(
                          onPressed: () =>
                              Get.toNamed(AppRoutes.createGroupTemplate),
                          icon: const Icon(
                            Icons.add,
                            color: AppColor.greenColor,
                            size: 35,
                          )),
                      Image.asset(AppImages.JOIN_GROUP_ICON)
                    ],
                  )),
              Expanded(
                flex: 4,
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Direct Messages",
                        style: AppFonts.heading2,
                      ),
                      Container(
                        margin: EdgeInsets.only(bottom: 10.h),
                        child: TextField(
                          controller: searchController,
                          decoration: const InputDecoration(
                              hintText: "Find or Start a conversation",
                              border: InputBorder.none,
                              suffixIcon: Icon(Icons.search)),
                        ),
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
                      CustomButton(
                        onPress: () {
                          // Get.toNamed(AppRoutes.addContacts);
                          Get.bottomSheet(AddContacts(),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(15),
                                topRight: Radius.circular(15),
                              )),
                              enableDrag: true,
                              isScrollControlled: true);
                        },
                        text: "Get Start",
                        width: 250.w,
                        icon: null,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
          color: AppColor.greenColor,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset(AppImages.DASHBOARD_GROUp_ICON),
              Image.asset(AppImages.TWO_PEOPLE_ICON),
              Image.asset(AppImages.NOTIFICATION_ICON),
              Image.asset(AppImages.FACE_ICON),
            ],
          ),
        )),
      ),
    );
  }
}
