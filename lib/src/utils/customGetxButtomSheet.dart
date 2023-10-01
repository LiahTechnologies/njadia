import 'package:flutter/material.dart';
import 'package:get/get.dart';

customGetxBottomsheet(Widget child,
    {bool? enbaleDrag = false, bool? isDismissable = true}) {
  return Get.bottomSheet(
      Scaffold(
        resizeToAvoidBottomInset: false,
        body: child,
      ),
      enableDrag: enbaleDrag!,
      isDismissible: isDismissable!);
}
