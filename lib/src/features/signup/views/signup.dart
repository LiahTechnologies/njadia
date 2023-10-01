import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/chat/services/authservice.dart';

import 'package:njadia/src/utils/CustomButton.dart';

import 'package:njadia/src/routing/approutes.dart';
import 'package:njadia/src/constants/style/appfont.dart';
import 'package:njadia/src/constants/style/color.dart';
import 'package:njadia/src/features/signup/widgets/imageRequirement.dart';
import 'package:njadia/src/features/signup/widgets/radioWidget.dart';
import 'package:njadia/src/features/signup/widgets/signupInputDetails.dart';
import 'package:country_picker/country_picker.dart';
import '../../../utils/CustomDots.dart';
import '../controller/signController.dart';
import '../widgets/otp.dart';

class Signup extends StatefulWidget {
  Signup({
    super.key,
  });

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController numberController = TextEditingController();

  // this is for signup details
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  String finalUserOTP = "";
  SignController signUpController = Get.put(SignController());

  // page controller
  final controller = PageController();
  AuthService authService = AuthService();

// Checkbox state
  bool isChecked = false;
  bool isRadioChecked = false;
  String selectedCountry = '';
  String selectedCountryCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          controller: controller,
          children: [
            /**
             * INPUT NUMBER
             */

            Container(
              margin: EdgeInsets.only(
                  top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account Creation",
                    style: AppFonts.heading1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                    child: const Row(
                      children: [
                        CustomDots(index: 1, position: 1),
                        CustomDots(index: 2, position: 1),
                        CustomDots(index: 3, position: 1),
                        CustomDots(index: 3, position: 1),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Enter your ", style: AppFonts.defaultFonts2),
                      TextSpan(text: "Phone number", style: AppFonts.heading3),
                      TextSpan(text: " Below.", style: AppFonts.defaultFonts2),
                    ])),
                  ),
                  Text(
                      "We will send  a 4 digit code to verify your phone  number",
                      style: AppFonts.defaultFonts2),
                  Container(
                    margin: EdgeInsets.only(top: 35.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.grey)),
                    height: 60,
                    width: double.infinity,
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.only(left: 10.w),
                          width: 120.w,
                          child: InkWell(
                            onTap: () {
                              showCountryPicker(
                                favorite: ['CM'],
                                context: context,
                                showPhoneCode: true,
                                onSelect: (Country country) {
                                  setState(() {
                                    selectedCountry = country.flagEmoji;
                                    selectedCountryCode = country.countryCode;
                                  });
                                  print(
                                      'Select country: ${country.displayName} ${country.countryCode}');
                                },
                              );
                            },
                            child: Row(children: [
                              SizedBox(
                                  width: 30.w,
                                  child: Text(
                                    "${selectedCountry}",
                                    style: TextStyle(fontSize: 20),
                                  )),
                              Icon(Icons.arrow_drop_down),
                              SizedBox(width: 40.w, child: Text("+237")),
                            ]),
                          ),
                        ),
                        Container(
                          height: 190.h,
                          width: 180.w,
                          child: TextField(
                            controller: numberController,
                            keyboardType: TextInputType.number,
                            decoration: InputDecoration(
                                hintText: "phone number",
                                border: InputBorder.none),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 18.0, top: 20.0.h),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CustomButton(
                        onPress: () => {
                          authService.registerWithPhoneNumber(
                              "+237${numberController.text.trim()}", context),
                          controller.nextPage(
                              duration: const Duration(seconds: 1),
                              curve: Curves.easeInOut)
                        },
                        text: "Send OTP",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /**
             * VERIFY OTP CODE
             */

            Container(
              margin: EdgeInsets.only(
                  top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account Creation",
                    style: AppFonts.heading1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                    child: const Row(
                      children: [
                        CustomDots(index: 1, position: 2),
                        CustomDots(index: 2, position: 2),
                        CustomDots(index: 3, position: 2),
                        CustomDots(index: 3, position: 2),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Enter the  4 digit  ",
                          style: AppFonts.defaultFonts2),
                      TextSpan(
                        text: "verification code",
                        style: AppFonts.heading3,
                      ),
                      TextSpan(
                          text: " sent to your phone.",
                          style: AppFonts.defaultFonts2),
                    ])),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30.0.h, bottom: 8.h),
                    child: Text(
                      "Verification code",
                      style: AppFonts.heading3,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OTPInput(
                        index: 1,
                        userOTP: (value) {
                          setState(() {
                            finalUserOTP = finalUserOTP + "" + value;
                          });

                          print("THIS IS THE VALUE OF THE INPUT DATA");
                          // print(finalUserOTP.join());
                        },
                      ),
                      OTPInput(
                        index: 2,
                        userOTP: (value) {
                          setState(() {
                            finalUserOTP = finalUserOTP + "" + value;
                          });
                        },
                      ),
                      OTPInput(
                        index: 3,
                        userOTP: (value) {
                          setState(() {
                            finalUserOTP = finalUserOTP + "" + value;
                          });
                        },
                      ),
                      OTPInput(
                        index: 4,
                        userOTP: (value) {
                          setState(() {
                            finalUserOTP = finalUserOTP + "" + value;
                          });
                        },
                      ),
                      OTPInput(
                        index: 5,
                        userOTP: (value) {
                          setState(() {
                            finalUserOTP = finalUserOTP + "" + value;
                          });
                          print("THIS IS THE VALUE OF THE INPUT DATA");
                          print(finalUserOTP);
                        },
                      ),
                      OTPInput(
                        index: 6,
                        userOTP: (value) {
                          setState(() {
                            finalUserOTP = finalUserOTP + "" + value;
                          });

                          print("OTP CODE IS $finalUserOTP");
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton.icon(
                          onPressed: () {
                            authService.registerWithPhoneNumber(
                                "+237${numberController.text.trim()}", context);
                          },
                          icon: const Icon(
                            Icons.replay_outlined,
                            color: Color(0xff1FAF67),
                          ),
                          label: Text(
                            "Resend code",
                            style: AppFonts.textItalic,
                          )),
                      TextButton.icon(
                          onPressed: () {
                            controller.previousPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut);
                          },
                          icon: const Icon(
                            Icons.edit,
                            color: Color(0xff1FAF67),
                          ),
                          label: Text(
                            "change phone number",
                            style: AppFonts.textItalic,
                          ))
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 18.0, top: 20.0.h),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CustomButton(
                        onPress: () {
                          authService
                              .verifyOTP(
                                  context: context,
                                  verificationId:
                                      signUpController.OTPcode.value,
                                  userId: finalUserOTP)
                              .whenComplete(() {
                            controller.nextPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut);
                          });
                        },
                        text: "Continue",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /**
             * THIS IS THE THIRD PART
             */

            Container(
              margin: EdgeInsets.only(
                  top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Account Creation",
                    style: AppFonts.heading1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                    child: const Row(
                      children: [
                        CustomDots(index: 1, position: 3),
                        CustomDots(index: 2, position: 3),
                        CustomDots(index: 3, position: 3),
                        CustomDots(index: 4, position: 3),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text: "Now lets get to know more about you!",
                          style: AppFonts.defaultFonts2),
                    ])),
                  ),
                  Container(
                    height: 150.h,
                    width: double.infinity,
                    child: Stack(children: [
                      Positioned(
                        child: Container(
                          margin: EdgeInsets.only(top: 10.h, bottom: 10.h),
                          child: Center(
                            child: CircleAvatar(
                              radius: 50.h,
                              backgroundImage: const AssetImage(
                                  "assets/images/Ellipse 34.png"),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                          top: 90.h,
                          left: 60.w,
                          child: Image.asset("assets/images/upload.png"))
                    ]),
                  ),
                  SignUpDetails(
                    firstNamecontroller: firstNameController,
                    lastNamecontroller: lastNameController,
                  ),
                  Row(
                    children: [
                      Checkbox(
                          value: isChecked,
                          onChanged: (value) {
                            setState(() {
                              isChecked = value!;
                            });
                          }),
                      Text(
                        "I agree to the",
                        style: AppFonts.defaultFonts3,
                      ),
                      Text(
                        " Terms of service",
                        style: AppFonts.defaultFontsBold3,
                      ),
                      Text(
                        " and",
                        style: AppFonts.defaultFonts3,
                      ),
                      Text(
                        " Privacy Policy",
                        style: AppFonts.defaultFontsBold3,
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 18.0, top: 20.0.h),
                    child: Align(
                      alignment: Alignment.topRight,
                      child: CustomButton(
                        onPress: () => controller.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut),
                        text: "Continue",
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /***
             * THIS IS THE FOURTH PART
             */

            Container(
              margin: EdgeInsets.only(
                  top: 12.h, left: 12.w, right: 12.w, bottom: 7.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Verify your identity",
                    style: AppFonts.heading1,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 15.h, bottom: 15.h),
                    child: const Row(
                      children: [
                        CustomDots(index: 1, position: 4),
                        CustomDots(index: 2, position: 4),
                        CustomDots(index: 3, position: 4),
                        CustomDots(index: 4, position: 4),
                      ],
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 8.h),
                    child: RichText(
                        text: TextSpan(children: [
                      TextSpan(
                          text:
                              "Please match you face with a supported \ndocument in order to be part of Njaida group",
                          style: AppFonts.defaultFonts2),
                    ])),
                  ),
                  SizedBox(
                    height: 60.h,
                  ),
                  CustomButton(
                    onPress: () => controller.nextPage(
                        duration: const Duration(seconds: 1),
                        curve: Curves.easeInOut),
                    text: "Take a selfie hold ID",
                    height: 50.h,
                    width: 350.w,
                    icon: Icons.arrow_forward_ios_outlined,
                    image: "assets/images/camera_mask.png",
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  CustomButton(
                    onPress: () => Get.toNamed(AppRoutes.CHAT_SIGNUP),

                    // controller.nextPage(
                    // duration: const Duration(seconds: 1),
                    // curve: Curves.easeInOut),
                    text: "Add a photo ID",
                    height: 50.h,
                    width: 350.w,
                    icon: Icons.arrow_forward_ios_outlined,
                    image: "assets/images/nid.png",
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 18.0, top: 200.0.h),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CustomButton(
                        isActive: false,
                        onPress: () {},
                        text: "Continue",
                        height: 50.h,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            /**
             * THIS IS FOR CAMERA IMAGE
             */

            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        margin: EdgeInsets.only(left: 10.w, top: 5.h),
                        width: 90.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: AppColor.greenColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: MaterialButton(
                            onPressed: () => controller.previousPage(
                                duration: Duration(seconds: 1),
                                curve: Curves.easeInOut),
                            child: Text("Back", style: AppFonts.buttonColor))),
                  ),
                  Image.asset("assets/images/img_frame.png"),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 18.0.h, left: 35.w),
                      child: Text(
                        "Please take a portrait selfie whilst\nholding the ID card",
                        style: AppFonts.defaultBlack600,
                      ),
                    ),
                  ),
                  const ImageRequirementWidget(text: "Clearly show your face"),
                  const ImageRequirementWidget(
                      text: "Keep your phone vertical"),
                  const ImageRequirementWidget(
                      text: "Make sure you're well lit"),
                  const ImageRequirementWidget(
                      text: "Be sure that your ID is visible"),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 30.w, top: 10.h),
                      width: 150.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: AppColor.greenColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                        onPressed: () => controller.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut),
                        child: Text("Open the camera",
                            style: AppFonts.buttonColor),
                      ),
                    ),
                  )
                ],
              ),
            ),

            /**
             * THIS IS FOR SHOWING THE SELFIE IMAGE
             */

            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        margin: EdgeInsets.only(left: 10.w, top: 5.h),
                        width: 90.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: AppColor.greenColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: MaterialButton(
                            onPressed: () => controller.previousPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Icon(
                                  Icons.arrow_back,
                                  color: AppColor.whiteColor,
                                ),
                                Text("Back", style: AppFonts.buttonColor),
                              ],
                            ))),
                  ),
                  Container(
                    height: 300.h,
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 30.w, top: 10.h),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageRequirementWidget(
                              show: true, text: "Make sure your ID is visible"),
                          ImageRequirementWidget(
                              show: true, text: "Make sure it's bright enough"),
                          ImageRequirementWidget(
                              show: true,
                              text: "Make sure your face is showing"),
                        ],
                      )),
                  SizedBox(
                    height: 20.h,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 30.0.w, top: 30.h, bottom: 10.h),
                        child: Text("Contact us",
                            style: AppFonts.defaultBlackUnderLine700),
                      )),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 30.w, top: 10.h),
                      width: 150.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: AppColor.greenColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                        onPressed: () => controller.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut),
                        child: Text("Retake", style: AppFonts.buttonColor),
                      ),
                    ),
                  )
                ],
              ),
            ),

            /**
             * 
             * this is for selection of 
             * id,or password
             */

            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        margin: EdgeInsets.only(left: 10.w, top: 5.h),
                        width: 90.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: AppColor.greenColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: MaterialButton(
                            onPressed: () => controller.previousPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut),
                            child: Text("Back", style: AppFonts.buttonColor))),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10.w, right: 10.w, top: 10.h),
                    height: 280.h,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all(18.0.w),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Please upload a valid ID",
                                style: AppFonts.heading3,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, top: 10.0),
                                child: Text("Issuing country",
                                    style: AppFonts.heading4),
                              ),
                              Container(
                                  height: 40.h,
                                  width: 190.w,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColor.greenColor)),
                                  child: Text("Cameroon",
                                      style: AppFonts.defaultBlack400)),
                              Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 8.0, top: 10.0),
                                child: Text("Document type:",
                                    style: AppFonts.heading4),
                              ),
                              const RadioWidget(text: "ID Card"),
                              const RadioWidget(text: "Passport"),
                              const RadioWidget(text: "Driving Licence"),
                            ]),
                      ),
                    ),
                  ),
                  Container(
                      margin: EdgeInsets.only(left: 30.w, top: 40.h),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ImageRequirementWidget(
                              left: 0, text: "Try to minimize glair "),
                          ImageRequirementWidget(
                              left: 0, text: "Make sure it's well lit"),
                          ImageRequirementWidget(
                              left: 0, text: "Make sure it's sharp"),
                        ],
                      )),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 30.0.w, top: 30.h, bottom: 10.h),
                        child: Text("Retake photo",
                            style: AppFonts.defaultBlackUnderLine700),
                      )),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 30.w, top: 10.h),
                      width: 150.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: AppColor.greenColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                        onPressed: () => controller.nextPage(
                            duration: const Duration(seconds: 1),
                            curve: Curves.easeInOut),
                        child: Text("Open Camera", style: AppFonts.buttonColor),
                      ),
                    ),
                  )
                ],
              ),
            ),

            /**
         * SHOW DOCUMENT TYPE
         */

            Container(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                        margin: EdgeInsets.only(left: 10.w, top: 5.h),
                        width: 90.w,
                        height: 50.h,
                        decoration: BoxDecoration(
                            color: AppColor.greenColor,
                            borderRadius: BorderRadius.circular(15)),
                        child: MaterialButton(
                            onPressed: () => controller.previousPage(
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOut),
                            child: Text("Back", style: AppFonts.buttonColor))),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: 10.w, right: 10.w, top: 10.h, bottom: 90.h),
                      height: 250.h,
                      width: 420.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25)),
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Image.asset(
                            "assets/images/Group 55.png",
                            fit: BoxFit.cover,
                          ))),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: 30.0.w, top: 30.h, bottom: 10.h),
                        child: Text("Upload a photo",
                            style: AppFonts.defaultBlackUnderLine700),
                      )),
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: Container(
                      margin: EdgeInsets.only(left: 30.w, top: 10.h),
                      width: 150.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                          color: AppColor.greenColor,
                          borderRadius: BorderRadius.circular(15)),
                      child: MaterialButton(
                        onPressed: () {
                          Get.toNamed(AppRoutes.HOMEpAGE);
                        },
                        child:
                            Text("Upload a photo", style: AppFonts.buttonColor),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
