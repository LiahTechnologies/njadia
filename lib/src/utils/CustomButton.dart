import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'themes/style/appfont.dart';
import 'themes/style/color.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    super.key,
    required this.onPress,
    required this.text,
    this.icon = Icons.arrow_forward,
    this.image = "",
    this.height = 0,
    this.width = 0,
    this.isActive = true,
    this.border = 12,
  });
  final VoidCallback onPress;
  final String text;
  final double height;
  final double border;
  final double width;
  final IconData? icon;
  final String? image;
  final bool? isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: width == 0 ? 150.w : width,
      height: height == 0 ? 40.h : height,
      decoration: BoxDecoration(
          color: isActive! ? AppColor.greenColor : Colors.grey.withOpacity(0.3),
          borderRadius: BorderRadius.circular(border)),
      child: MaterialButton(
        onPressed: onPress,
        child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          if (image!.isNotEmpty) Image.asset(image!),
          Center(
            child: Text(
              text,
              style: AppFonts.buttonColor,
            ),
          ),
          if (icon != null)
            Padding(
              padding: EdgeInsets.only(left: 18.0),
              child: Icon(
                icon,
                color: Colors.white,
              ),
            )
        ]),
      ),
    );
  }
}
