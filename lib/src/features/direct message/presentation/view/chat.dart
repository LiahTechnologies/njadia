import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import 'package:njadia/src/constants/style/color.dart';
import 'package:njadia/src/features/direct%20message/presentation/controller/direct_message_controller.dart';
import 'package:njadia/src/warnings/custombackarrow.dart';

import '../../../../common/helper_function.dart';
import '../../../authentication/data/databaseService.dart';
import '../../../group_chat/presentation/widgets/messageTitle.dart';

class DirectMessageChat extends StatefulWidget {
  final String profileImg;
  final String userName;
  final String userId;

  // final String ;
  const DirectMessageChat(
      {super.key,
      required this.profileImg,
      required this.userName,
      required this.userId});

  @override
  State<DirectMessageChat> createState() => _DirectMessageChatState();
}

class _DirectMessageChatState extends State<DirectMessageChat> {
  Stream<QuerySnapshot>? chat;
  String admin = '';
  User? user;

  // @override
  // void initState() {
  //   getChatandAdmin();
  //   super.initState();
  // }

  // void getChatandAdmin() {
  //   DatabaseServices().getChats(widget.groupId).then((val) {
  //     setState(() {
  //       chat = val;
  //     });
  //   });

  //   DatabaseServices().getGroupAdmin(widget.groupId).then((value) {
  //     setState(() {
  //       admin = value;
  //     });
  //   });
  // }

  //final authService = AuthService();
  final TextEditingController messageController = TextEditingController();

  final controller = DirectMessageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          leading: CustomBackArrow(),
          // // IconButton(
          // //   icon: Icon(
          // //     Icons.arrow_back_ios,
          // //     size: 11,
          // //     color: Theme.of(context).iconTheme.color,
          // //   ),
          //   onPressed: () => Get.back(),
          // ),
          centerTitle: true,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 18,
                backgroundImage: AssetImage(widget.profileImg),
              ),
              Text(
                widget.userName.capitalizeFirst.toString(),
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          actions: [
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.videocam,
                  color: Theme.of(context).iconTheme.color,
                )),
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.phone,
                  color: Theme.of(context).iconTheme.color,
                )),
            PopupMenuButton(
                onSelected: (value) {},
                icon: Icon(
                  Icons.more_vert,
                  color: Theme.of(context).iconTheme.color,
                ),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: Text("send money"),
                      value: "send money",
                    ),
                    PopupMenuItem(
                      child: Text("send money"),
                      value: "send money",
                    )
                  ];
                }),
          ],
        ),
        body: Stack(children: [
          chatMessages(),
          Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 5.h),
                  child: Row(
                    children: [
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 5.w, vertical: 5.h),
                        // height: 50.h,
                        width: 280.w,
                        decoration: BoxDecoration(
                            color: Theme.of(context).cardTheme.color,
                            borderRadius: BorderRadius.circular(20)),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                  minLines: 1,
                                  maxLines: 6,
                                  controller: messageController,
                                  style:
                                      Theme.of(context).textTheme.displayLarge,
                                  decoration: InputDecoration(
                                    alignLabelWithHint: true,
                                    contentPadding: const EdgeInsets.symmetric(
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
        ]));
  }

  chatMessages() {
    return StreamBuilder(
        stream: chat,
        builder: (context, snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  // shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    // return Text(snapshot.data!.docs[index]['message']);
                    return MessageTile(
                      message: snapshot.data!.docs[index]['message'],
                      sender: snapshot.data!.docs[index]['sender'],
                      sendbyMe: widget.userName ==
                          snapshot.data!.docs[index]['sender'],
                      
                     repliedMessage: snapshot.data!.docs[index]['replyMessage'],
                      replySender: snapshot.data!.docs[index]['replySender'],
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
      };

      DatabaseServices()
          .sendChatMessage(chatMessages: chatMessageMap, chatId: user!.uid);

      setState(() {
        messageController.clear();
      });
      controller.createChat(
          userName: widget.userName,
          profileImg: widget.profileImg,
          userId: widget.userId);
    }
  }
}
