import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/constants/style/appfont.dart';

class CustomInput extends StatelessWidget {
  const CustomInput(
      {super.key,
      required this.text,
      required this.controller,
      required this.hint,
      this.height = 80,
      this.width = 350});
  final String text;
  final ValueChanged<String> controller;
  final String hint;
  final double width;
  final double height;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width.w,
      height: height.h,
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
