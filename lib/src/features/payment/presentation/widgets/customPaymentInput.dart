import 'package:flutter/material.dart';
import 'package:njadia/src/constants/style/color.dart';

class CustomPaymetInput extends StatelessWidget {
  const CustomPaymetInput({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
        
        focusColor: AppColor.purpleColor
      ),
    );
  }
}