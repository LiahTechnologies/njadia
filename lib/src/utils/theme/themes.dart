import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:njadia/src/constants/style/color.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    colorScheme: const ColorScheme.light(),
    textTheme: TextTheme(
      displayLarge: GoogleFonts.dmSans(fontSize: 13,color: AppColor.blackColor),
      displaySmall: GoogleFonts.dmSans(fontSize: 11,color: AppColor.grayColor),
      displayMedium: GoogleFonts.dmSans(fontSize: 12,color:AppColor.blackColor),
      titleLarge: GoogleFonts.dmSans(fontSize: 20,color: AppColor.whiteColor),
      titleMedium: GoogleFonts.dmSans(fontSize: 18,color: AppColor.greenColor),
      labelSmall: GoogleFonts.dmSans(fontSize: 11,color: AppColor.whiteColor),

    ),
  appBarTheme:const  AppBarTheme(
  backgroundColor: AppColor.greenColor,
  elevation: 0
  ) ,

  iconTheme:const IconThemeData(color: AppColor.blackColor),
  inputDecorationTheme:const  InputDecorationTheme(
    iconColor:AppColor.grayColor 
  ),

// color for cards

  cardTheme: CardTheme(
    color: AppColor.whiteColor
  )

    
  );

   static final darkTheme = ThemeData(
    colorScheme: const ColorScheme.dark(),

    textTheme: TextTheme(
      displayLarge: GoogleFonts.dmSans(fontSize: 13,color: AppColor.whiteColor),
      displaySmall: GoogleFonts.dmSans(fontSize: 11,color: AppColor.grayColor),
      displayMedium: GoogleFonts.dmSans(fontSize: 12,color:AppColor.whiteColor),
      titleLarge: GoogleFonts.dmSans(fontSize: 20,color: AppColor.whiteColor),
      titleMedium: GoogleFonts.dmSans(fontSize: 18,color: AppColor.greenColor),
      labelSmall: GoogleFonts.dmSans(fontSize: 11,color: AppColor.whiteColor),
      // subtitle1: GoogleFonts.dmSans(fontSize: 11,color: AppColor.grayColor)

    ),
    appBarTheme:const AppBarTheme(
  backgroundColor: AppColor.greenColor,
  elevation: 0
   ),



    buttonTheme: const ButtonThemeData(buttonColor: AppColor.purpleColor),
  iconTheme:const  IconThemeData(
    color: AppColor.whiteColor,
    
  ),


  inputDecorationTheme:const InputDecorationTheme(
    iconColor:AppColor.grayColor 
  ),


// color for cards

  cardTheme: CardTheme(
    color: AppColor.cardColor
  )

// typography: Typography(black: TextTheme())
    // buttonTheme: ButtonTheme(child: ,)
  );

  
}
