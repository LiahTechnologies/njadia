import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../helper/helper_function.dart';
import '../../services/databaseService.dart';
import '../../widgets/groupTile.dart';
import 'searchpage.dart';

class ChatGroupHome extends StatefulWidget {
  const ChatGroupHome({super.key});

  @override
  State<ChatGroupHome> createState() => _ChatGroupHomeState();
}

class _ChatGroupHomeState extends State<ChatGroupHome> {
  @override
  void initState() {
    getUserData();
    super.initState();
  }

  bool _isloading = false;
  String groupName = '';
  String userName = '';
  String email = '';
  Stream? group;

  getUserData() async {
    await HelperFunction.getUserName().then((value) {
      setState(() {
        userName = value;
      });
    });

    await HelperFunction.getUserEmail().then((value) {
      setState(() {
        email = value;
      });
    });

    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroup()
        .then((snapshot) {
      setState(() {
        group = snapshot;
      });
    });
    print("this is the group data");
    print(group);
  }

  String getId(String res) {
    return res.substring(9, res.indexOf('_'));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        title: const Text("Groups"),
        actions: [
          IconButton(
              onPressed: () {
                nextScreen(context, const searchPage());
              },
              icon: const Icon(Icons.search))
        ],
      ),
      body: grouplist(),
      floatingActionButton: FloatingActionButton(
        onPressed: popupDialogue,
        child: const Icon(Icons.add_outlined),
      ),
    );
  }

  popupDialogue() {
    return showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Text("Create Group"),
              content: Column(
                children: [
                  _isloading
                      ? Center(child: CircularProgressIndicator())
                      : TextField(
                          onChanged: (value) {
                            groupName = value;
                          },
                        ),
                ],
              ),
              actions: [
                ElevatedButton(onPressed: () {}, child: Text("CANCEL")),
                ElevatedButton(
                    onPressed: () {
                      if (groupName != '') {
                        setState(
                          () {
                            _isloading = true;
                          },
                        );

                        DatabaseService(
                                uid: FirebaseAuth.instance.currentUser!.uid)
                            .createGroup(
                                userName,
                                FirebaseAuth.instance.currentUser!.uid,
                                groupName)
                            .whenComplete(() {
                          setState(
                            () {
                              _isloading = false;
                            },
                          );
                        });
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text("CREATE"))
              ],
            );
          });
        });
  }

  grouplist() {
    return StreamBuilder(
        stream: group,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['groups'] != null) {
              if (snapshot.data['groups'].length != 0) {
                return ListView.builder(
                    itemCount: snapshot.data['groups'].length,
                    itemBuilder: (context, index) {
                      var reverseIndex =
                          snapshot.data['groups'].length - index - 1;
                      return GroupTile(
                          groupName:
                              getName(snapshot.data['groups'][reverseIndex]),
                          userName: snapshot.data['fullname'],
                          groupid:
                              getId(snapshot.data['groups'][reverseIndex]));
                    });
              } else {
                return noGroupWidget();
              }
            } else {
              return noGroupWidget();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(color: Colors.red),
            );
          }
        });
  }

  noGroupWidget() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 25),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
                onPressed: popupDialogue,
                icon: Icon(
                  Icons.add_circle,
                  size: 22,
                )),
            SizedBox(
              height: 25,
            ),
            Text(
                "You have not joined any group, tap on the add icon to create a new group or also search groups")
          ]),
    );
  }
}
