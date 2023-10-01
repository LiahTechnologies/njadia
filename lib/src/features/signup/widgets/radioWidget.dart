import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:njadia/src/constants/style/appfont.dart';

class RadioWidget extends StatefulWidget {
  const RadioWidget({super.key,required this.text});
  final String text;
  @override
  State<RadioWidget> createState() => _RadioWidgetState();
}

class _RadioWidgetState extends State<RadioWidget> {
  bool isRadioChecked = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20.h,
      child: Row(
        children: [
          Radio(
              value: isRadioChecked,
              groupValue: isRadioChecked,
              onChanged: (value) {
                setState(() {
                  isRadioChecked = value!;
                });
              }),
          Text(widget.text,style:AppFonts.defaultGreen400),
        ],
      ),
    );
  }
}
