import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:njadia/src/constants/style/appAsset.dart';
import 'package:njadia/src/constants/style/color.dart';
import 'package:njadia/src/features/direct%20message/presentation/view/chat.dart';
import 'package:njadia/src/routing/approutes.dart';

import 'see-chat-profile.dart';

class MessageTile extends StatefulWidget {
  const MessageTile(
      {super.key,
      required this.message,
      required this.sender,
      required this.sendbyMe,
      required this.repliedMessage,
      required this.replySender
      });
  final String message;
  final bool sendbyMe;
  final String sender;
  final String repliedMessage;
  final String replySender;
  @override
  State<MessageTile> createState() => _MessageTileState();
}

class _MessageTileState extends State<MessageTile> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 4,
          bottom: 4,
          left: widget.sendbyMe ? 24 : 24,
          right: widget.sendbyMe ? 24 : 24),
      alignment: widget.sendbyMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        child: ListTile(
          leading: GestureDetector(
            onTap: () {
              showDialog(
                  context: context,
                  builder: (context) => SeeChatProfile(
                        profileImag: AppImages.PERSON,
                        chat: () async {
                          Get.to(DirectMessageChat(
                            profileImg: AppImages.PERSON,
                            userName: "cliff",
                            userId: FirebaseAuth.instance.currentUser!.uid,
                          ));
                        },
                        videoCall: () {
                          Get.back();
                          Get.toNamed(AppRoutes.HOMEpAGE);
                        },
                      ));
            },
            child: const CircleAvatar(
              radius: 15,
              backgroundImage: AssetImage(AppImages.PERSON),
            ),
          ),
          title: Container(

              // margin: widget.sendbyMe
              //   ? const EdgeInsets.only(left: 30)
              // : const EdgeInsets.only(right: 30),
              padding: const EdgeInsets.only(
                  top: 17, bottom: 17, left: 20, right: 20),
              decoration: BoxDecoration(
                  borderRadius: widget.sendbyMe
                      ? const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomLeft: Radius.circular(20),
                        )
                      : const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                          bottomRight: Radius.circular(20)),
                  color: widget.sendbyMe ? AppColor.purpleColor : Colors.grey),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if(widget.repliedMessage.isNotEmpty)
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 2.w,vertical: 10.h),
                      decoration: BoxDecoration(
                      color: widget.sendbyMe ? AppColor.purpleColor!.withOpacity(0.5) : Colors.grey!.withOpacity(0.5)
                      ),
                      child: Row(
                        children: [
                          // if(widget.repliedMessage.isNotEmpty)
                           Container(
                                          height: 50.h,
                                          width: 2.h,
                                          decoration: BoxDecoration(
                                              color: widget.sendbyMe ? AppColor.cardColor:AppColor.whiteColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10))),
                                        ),

                                        SizedBox(width: 10.w,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [Text("${widget.replySender}",overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.displayMedium!.copyWith(color: AppColor.greenColor,fontWeight: FontWeight.bold,fontSize: 16),), 
                            Text("${widget.repliedMessage}",overflow: TextOverflow.ellipsis,style: Theme.of(context).textTheme.displayMedium!)],
                          ),
                        ],
                      ),
                    ),
                    Text(widget.message,
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white)),
                    const SizedBox(height: 8),
                    Text(
                      widget.sender.toUpperCase(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: -0.2),
                    ),
                  ])),
        ),
      ),
    );
  }
}
