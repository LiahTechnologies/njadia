import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/features/authentication/controllers/authentication_service.dart';
import 'package:njadia/src/features/authentication/screens/authentication.dart';
import 'package:njadia/src/routing/approutes.dart';

import '../../../../../constants/style/appfont.dart';
import '../../../../../utils/CustomButton.dart';
import '../../../../../utils/CustomDots.dart';
import '../../../../../utils/customInputWidget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  String email = '';
  String password = '';
  final controller = AuthenticationServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(
                  top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login to Account",
                    style: Theme.of(context).textTheme.titleMedium
                  ),

                  // Container(
                  // margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                  // child: const Row(
                  // children: [
                  // CustomDots(index: 1, position: 1),
                  // CustomDots(index: 2, position: 1),
                  // CustomDots(index: 3, position: 1),
                  // CustomDots(index: 3, position: 1),
                  // ],
                  // ),
                  // ),
                  SizedBox(
                    height: 10.h,
                  ),

                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Enter your ", style: Theme.of(context).textTheme.displayMedium),
                      TextSpan(
                          text: "Email & Password", style:Theme.of(context).textTheme.displayMedium),
                      TextSpan(text: " Below.", style: Theme.of(context).textTheme.displayMedium),
                    ])),
                  ),

                  Text(
                      "We will send  a 6 digit code to verify your phone  number",
                      style: Theme.of(context).textTheme.displayMedium),
                  CustomInputWidget(
                      borderRadius: 12,
                      marginTop: 12,
                      text: "Email",
                      onChange: (v) {
                        email = v;
                      }),
                  CustomInputWidget(
                      borderRadius: 12,
                      marginTop: 12,
                      text: "Password",
                      onChange: (v) {
                        password = v;
                      }),
                  Padding(
                    padding: EdgeInsets.only(right: 18.0, top: 20.0.h),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CustomButton(
                        onPress: () => {
                          controller
                              .signinWithEmailAndPassword(
                                  email: email, password: password)
                              .then((value) {
                            if (value != true) Get.toNamed(AppRoutes.HOMEpAGE);
                          })
                        },
                        text: "Login ",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
