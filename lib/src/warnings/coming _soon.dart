import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:njadia/src/utils/CustomButton.dart';
import 'package:njadia/src/constants/style/appAsset.dart';
import 'package:njadia/src/constants/style/appfont.dart';
import 'package:njadia/src/constants/style/color.dart';

class ComiingSoon extends StatelessWidget {
  const ComiingSoon({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        child: SimpleDialog(alignment: Alignment.center, children: [

          Align(
            alignment: Alignment.topRight,
            child: IconButton(icon: Icon(Icons.close),onPressed: ()=>Get.back(),),
          ),
      Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Coming Soon!",
            style:Theme.of(context).textTheme.titleMedium
          ),
        ),
      ),
      
    ]));
  }
}
