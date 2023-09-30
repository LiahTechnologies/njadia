import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomCardItems extends StatelessWidget {
  const CustomCardItems(
      {super.key,
      required this.image,
      required this.text,
      required this.onTap});
  final String image;
  final String text;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(),
      child: Card(
          child: SizedBox(
        height: 60.h,
        child: ListTile(
          leading: Image.asset(
            image,
            width: 30,
          ),
          title: Text(text),
          trailing: const Icon(Icons.arrow_forward_ios_outlined),
        ),
      )),
    );
  }
}
