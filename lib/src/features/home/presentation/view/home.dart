import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/features/group_home_page/presentation/view/group_home_page.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/constants/style/appAsset.dart';
import 'package:njadia/src/constants/style/appfont.dart';
import 'package:njadia/src/constants/style/color.dart';
import 'package:njadia/src/features/group_chat/presentation/view/add_group_contact.dart';

import '../../../../common/helper_function.dart';
import '../../../authentication/data/databaseService.dart';
import '../../../group_chat/presentation/widgets/groupTile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  String userName = '';
  String userEmail = '';
  Stream? group;

  getUserData() async {
    await HelperFunction.getUserName().then((value) {
      setState(() {
        userName = value;
      });
    });
    await HelperFunction.getUserEmail().then((value) {
      setState(() {
        userEmail = value;
      });
    });
    await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroup()
        .then((snapshot) {
      setState(() {
        group = snapshot;
      });
    });

    print(
        "THIS IS THE LIST OF GROUPS  ${FirebaseAuth.instance.currentUser!.uid}");
    print(" THE NUMBE OF GROUPS IS  ${await group!.length}");
  }

  String getId(String res) {
    return res.substring(9, res.indexOf('_'));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                        height: 590.h,
                        width: double.infinity,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              Image.asset(AppImages.DM_ICON),
                              SizedBox(
                                height: 10.h,
                              ),
                              Container(
                                width: 350.w,
                                child: grouplist(),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
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
                    ),
                  )),
              Expanded(
                flex: 5,
                child: Card(
                  elevation: 3,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 5.w),
                    child: Column(
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Text(
                            "Direct Messages",
                            style: AppFonts.heading2,
                          ),
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
              // Expanded(
              // flex: 1,
              // child: Card(
              // elevation: 3,
              // shape: RoundedRectangleBorder(
              // borderRadius:
              // BorderRadius.only(topLeft: Radius.circular(25))),
              // child: SizedBox(
              // height: double.infinity,
              // child: Align(
              // alignment: Alignment.topCenter,
              // child: IconButton(
              // icon: Icon(Icons.menu_outlined),
              // onPressed: () {},
              // ),
              // ),
              // ),
              // ))
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

  grouplist() {
    return StreamBuilder(
        stream: group,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['groups'] != null) {
              if (snapshot.data['groups'].length != 0) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data['groups'].length,
                    itemBuilder: (context, index) {
                      var reverseIndex =
                          snapshot.data['groups'].length - index - 1;
                      return GroupTile(
                          groupName:
                              getName(snapshot.data['groups'][reverseIndex]),
                          userName: snapshot.data['firstName'],
                          groupid:
                              getId(snapshot.data['groups'][reverseIndex]));
                    });
              } else {
                return Text("");
                // return noGroupWidget();
              }
            } else {
              return Text("");
              // return noGroupWidget();
            }
          } else {
            return const Center(child: Text("hello"));
          }
        });
  }
/*
  noGroupWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add_circle,
                  size: 22,
                )),
            SizedBox(
              height: 25,
            ),
            Text(
                "You have not joined any group, tap on the addicon to create a new group or also search groups")
          ]),
    );
  }*/
}
