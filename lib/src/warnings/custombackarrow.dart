

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackArrow extends StatelessWidget {
  const CustomBackArrow({super.key});

  @override
  Widget build(BuildContext context) {
    return  IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new_outlined,
            size: 11,
          ),
          onPressed: () => Get.back(),
        );
  }
}