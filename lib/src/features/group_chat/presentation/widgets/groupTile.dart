import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/constants/style/color.dart';

import '../../../../common/helper_function.dart';
import '../view/chatpage.dart';

class GroupTile extends StatefulWidget {
  final String? userName;
  final String? groupid;
  final String groupName;
  const GroupTile(
      {super.key, required this.groupName, this.userName, this.groupid});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(ChatPage(
            groupId: widget.groupid!,
            groupName: widget.groupName!,
            userName: widget.userName!),
            transition: Transition.zoom,
            
            );
      },
      child: Container(
        height: 50.h,
        width: 500.w,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          // padding: const EdgeInsets.only(bottom: 16),

        child:ListTile(
        leading:
         CircleAvatar(
          radius: 20,
          backgroundColor: Colors.pinkAccent,
          child: Text(
            widget.groupName.substring(0, 1).toUpperCase(),
            textAlign: TextAlign.center,
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        
        title: Text(
        widget.groupName,
        style: Theme.of(context).textTheme.displayLarge,
        ),
        subtitle: Text(widget.userName!,style: Theme.of(context).textTheme.displaySmall,),
        trailing: Container(
          
          height: 20.h,
          width: 20.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: AppColor.greenColor
          ),
          child: Center(child: Text("22",style: TextStyle(color: AppColor.whiteColor),)),
        )
        
            )
      ),
    );
  }
}
