import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:njadia/src/common/helper_function.dart';

class ThemeController extends GetxController {
  final _box =HelperFunction();
  final _key = "isDarkMode";

   late bool currentTheme;


  // Get the theme mode from local storage


  ThemeMode get theme => _loadTheme() ? ThemeMode.dark : ThemeMode.light;
  bool _loadTheme() => currentTheme??false;

  // void savetheme (bool isDarkMode) =_box.writeTheme(_key,"isDarkMode");
  void changeTheme(ThemeData theme)=>Get.changeTheme(theme);
  void changeThemeMode(ThemeMode themeMode)=>Get.changeThemeMode(themeMode);

}
