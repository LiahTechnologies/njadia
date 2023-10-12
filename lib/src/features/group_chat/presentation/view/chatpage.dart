import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../../../../../../chat/pages/auth/grouphome.dart';
import '../../../../../../../chat/services/authservice.dart';
import 'package:njadia/src/constants/style/color.dart';

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

  final authService = AuthService();
  final TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          title: Text(widget.groupName),
          backgroundColor: AppColor.greenColor,
          actions: [
            IconButton(
                onPressed: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text("Exit"),
                          content:
                              Text("Are you sure you wanat to exit this group"),
                          actions: [
                            IconButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                icon: Icon(
                                  Icons.cancel,
                                  color: Colors.red,
                                )),
                            IconButton(
                                onPressed: () {
                                  DatabaseServices(
                                          uid: FirebaseAuth
                                              .instance.currentUser!.uid)
                                      .toggleGroupJoin(
                                          groupId: widget.groupId,
                                          userName: widget.userName,
                                          groupName: widget.groupName)
                                      .whenComplete(() {
                                    nextScreen(context, ChatGroupHome());
                                  });
                                },
                                icon: Icon(
                                  Icons.info,
                                ))
                          ],
                        );
                      });
                  // nextScreen(
                  // context,
                  // GroupInfo(
                  // adminName: admin,
                  // groupId: widget.groupId,
                  // groupName: widget.groupName));
                },
                icon: const Icon(Icons.info)),
          ],
        ),
        body: Stack(children: [
          chatMessages(),
          Container(
              alignment: Alignment.bottomCenter,
              width: double.infinity,
              child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  color: Colors.grey[700],
                  child: Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                            controller: messageController,
                            style: TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                                hintText: "Send a Message",
                                hintStyle: TextStyle(color: Colors.white),
                                border: InputBorder.none)),
                      ),
                      const SizedBox(width: 12),
                      GestureDetector(
                        onTap: sendMessage,
                        child: Container(
                            width: 50,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.pinkAccent[400],
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
          .sendMessage(groupId: widget.groupId, chatMessages: chatMessageMap);
      setState(() {
        messageController.clear();
      });
    }
  }
}
