import 'package:flutter/material.dart';
import 'package:get/get.dart';

customGetxBottomsheet(Widget child,
    {bool? enbaleDrag = false, bool? isDismissable = true}) {
  return Get.bottomSheet(
      Scaffold(
        body: child,
      ),
      enableDrag: enbaleDrag!,
      isDismissible: isDismissable!);
}
