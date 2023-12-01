import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:njadia/src/constants/style/color.dart';
import 'package:njadia/src/routing/approutes.dart';
import 'package:swipe_to/swipe_to.dart';

import '../../../../common/helper_function.dart';
import '../../../authentication/data/databaseService.dart';
import '../widgets/messageTitle.dart';

class ChatPage extends StatefulWidget {
  final String groupId;
  final String groupName;
  final String userName;
  const ChatPage(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.userName});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  Stream<QuerySnapshot>? chat;
  String admin = '';

  @override
  void initState() {
    getChatandAdmin();
    super.initState();
  }

  void getChatandAdmin() {
    DatabaseServices().getChats(widget.groupId).then((val) {
      setState(() {
        chat = val;
      });
    });

    DatabaseServices().getGroupAdmin(widget.groupId).then((value) {
      setState(() {
        admin = value;
      });
    });
  }

  //final authService = AuthService();
  final TextEditingController messageController = TextEditingController();

  // final ValueChanged<String> onSwipeMessage;
  String message = '';
  String sender = '';
  bool showSwipeDialog = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 11,
            color: Theme.of(context).iconTheme.color,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
        elevation: 0,
        title: Text(
          widget.groupName,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        actions: [
          PopupMenuButton(
              onSelected: (value) {
                switch (value) {
                  case "send money":
                    Get.toNamed(AppRoutes.SELECT_GROUP_MEMBER_PAGE);
                }
              },
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).iconTheme.color,
              ),
              itemBuilder: (context) {
                return [
                  //  PopupMenuItem(
                  //   child: Text("send money"),value: "send money",

                  //   ),

                  PopupMenuItem(
                    child: Text("send money"),
                    value: "send money",
                  )
                ];
              }),
        ],
      ),
      body:
          Stack(children: [

          chatMessages(),
      
          Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  child: Row(
                    children: [
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          if (showSwipeDialog)
                            Container(
                                padding: EdgeInsets.symmetric(horizontal: 9.w),
                                height: 80.h,
                                decoration: BoxDecoration(
                                    color: Theme.of(context)
                                        .cardTheme
                                        .color!
                                        .withOpacity(0.5),
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(20),
                                        topRight: Radius.circular(20))),
                                width: 280.w,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Container(
                                          height: 50.h,
                                          width: 3.h,
                                          decoration: BoxDecoration(
                                              color: AppColor.cardColor,
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  bottomLeft:
                                                      Radius.circular(10))),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 10.w),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    bottom: 9.0),
                                                child: Text(
                                                  "$sender",
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .displayMedium,
                                                ),
                                              ),
                                              Text(
                                                "$message",
                                                overflow: TextOverflow.ellipsis,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .displayMedium,
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        icon: Icon(Icons.close),
                                        onPressed: () {
                                          setState(() {
                                            showSwipeDialog = false;
                                          });
                                        },
                                      ),
                                    ),
                                  ],
                                )),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 5.w,
                                vertical: showSwipeDialog ? 0 : 5.h),
                            // height: 50.h,
                            width: 280.w,
                            decoration: BoxDecoration(
                                color: Theme.of(context).cardTheme.color,
                                borderRadius: BorderRadius.only(
                                  topLeft: showSwipeDialog
                                      ? Radius.zero
                                      : Radius.circular(20),
                                  topRight: showSwipeDialog
                                      ? Radius.zero
                                      : Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                )),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                      minLines: 1,
                                      maxLines: 6,
                                      controller: messageController,
                                      style: Theme.of(context)
                                          .textTheme
                                          .displayLarge,
                                      decoration: InputDecoration(
                                        alignLabelWithHint: true,
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                horizontal: 5),
                                        hintText: "Send a Message",
                                        hintStyle: Theme.of(context)
                                            .textTheme
                                            .displayMedium,
                                        border: InputBorder.none,
                
                                        // suffixIcon: IconButton(icon:const  Icon(Icons.link,),onPressed: (){},)
                                      )),
                                ),
                                RotatedBox(
                                    quarterTurns: 2,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.attachment_outlined,
                                        size: 25,
                                      ),
                                      onPressed: () {},
                                    ))
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: sendMessage,
                        child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: AppColor.purpleColor,
                                borderRadius: BorderRadius.circular(30)),
                            child: Icon(Icons.send, color: Colors.white)),
                      )
                    ],
                  )))

                  
      ])
    );
  }

  chatMessages() {
    return StreamBuilder(
        stream: chat,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  
                   itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // return Text(snapshot.data!.docs[index]['message']);
                    return 
                    
                    
                    GestureDetector(
                      onLongPress: () {},
                      child: SwipeTo(
                        onRightSwipe: (v) {
                          setState(() {
                            showSwipeDialog = true;
                            sender = snapshot.data!.docs[index]['sender'];

                            message = snapshot.data!.docs[index]['message'];
                          });

                          // print("MESSAGE WAS SWIPED ");
                        },
                        child: MessageTile(
                          message: snapshot.data!.docs[index]['message'],
                          sender: snapshot.data!.docs[index]['sender'],
                          sendbyMe: widget.userName ==
                              snapshot.data!.docs[index]['sender'],
                          repliedMessage: snapshot.data!.docs[index]
                              ['replyMessage'],
                          replySender: snapshot.data!.docs[index]
                              ['replySender'],
                        ),
                      ),
                    );

                    
                  })
              : Container();
        });
  }

  sendMessage() {
    if (messageController.text.isNotEmpty) {
      Map<String, dynamic> chatMessageMap = {
        "message": messageController.text,
        "sender": widget.userName,
        "time": DateTime.now().millisecondsSinceEpoch,
        "isReply": showSwipeDialog,
        "replyMessage": message,
        "replySender": sender
      };

      DatabaseServices()
          .sendMessage(groupId: widget.groupId, chatMessages: chatMessageMap);
      setState(() {
        messageController.clear();
      });
      setState(() {
        showSwipeDialog = false;
      });
    }
  }
}
