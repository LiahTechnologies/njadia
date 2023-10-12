import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/constants/style/appfont.dart';
import 'package:njadia/src/constants/style/color.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {super.key,
      required this.text,
      required this.controller,
      required this.hint,
      this.isBorderColor = false,
      this.height = 80,
      this.width = 350});
  final String text;
  final ValueChanged<String> controller;
  final String hint;
  final double width;
  final double height;
  final bool isBorderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 5.w, vertical: 5.h),
      width: width.w,
      height: height.h,
      decoration: BoxDecoration(
          border: Border.all(
              color: isBorderColor ? AppColor.greenColor : Colors.transparent)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            text,
            style: AppFonts.defaultFontsBold3,
          ),
          Container(
            child: TextField(
                onChanged: (value) {
                  controller(value);
                },
                decoration:
                    InputDecoration(border: InputBorder.none, hintText: hint)),
          ),
        ],
      ),
    );
  }
}
