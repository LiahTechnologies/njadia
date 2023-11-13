import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:njadia/src/constants/style/color.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.dmSans(fontSize: 13,color: AppColor.blackColor),
      displaySmall: GoogleFonts.dmSans(fontSize: 11,color: AppColor.blackColor),
      displayMedium: GoogleFonts.dmSans(fontSize: 12,color:AppColor.blackColor),
      titleLarge: GoogleFonts.dmSans(fontSize: 20,color: AppColor.blackColor),
      titleMedium: GoogleFonts.dmSans(fontSize: 18,color: AppColor.greenColor)

    ),
appBarTheme: AppBarTheme(
  backgroundColor: AppColor.greenColor,
  elevation: 0
)
    
  );

   static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),

    textTheme: TextTheme(
      displayLarge: GoogleFonts.dmSans(fontSize: 13,color: AppColor.whiteColor),
      displaySmall: GoogleFonts.dmSans(fontSize: 11,color: AppColor.whiteColor),
      displayMedium: GoogleFonts.dmSans(fontSize: 12,color:AppColor.whiteColor),
      titleLarge: GoogleFonts.dmSans(fontSize: 20,color: AppColor.whiteColor),
      titleMedium: GoogleFonts.dmSans(fontSize: 18,color: AppColor.greenColor)

    ),
appBarTheme: AppBarTheme(
  backgroundColor: AppColor.greenColor,
  elevation: 0
)
    // buttonTheme: ButtonTheme(child: ,)
  );
}
