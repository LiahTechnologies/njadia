import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:njadia/chat/helper/helper_function.dart';
import 'package:njadia/chat/pages/auth/chatpage.dart';
import 'package:njadia/chat/services/databaseService.dart';

class searchPage extends StatefulWidget {
  const searchPage({super.key});

  @override
  State<searchPage> createState() => _searchPageState();
}

class _searchPageState extends State<searchPage> {
  late String userName, userEmail;
  QuerySnapshot? searchSnapshot;
  bool hasUserSearch = false;
  User? user;
  final TextEditingController searchController = TextEditingController();
  @override
  void initState() {
    gettingUserData();
    super.initState();
  }

  gettingUserData() async {
    await HelperFunction.getUserEmail().then((value) {
      setState(() {
        userEmail = value;
      });
    });
    await HelperFunction.getUserName().then((value) {
      setState(() {
        userName = value;
      });
    });

    user = FirebaseAuth.instance.currentUser;
  }

  String getName(String r) {
    return r.substring(r.indexOf("_") + 1);
  }

  String getId(String res) {
    return res.substring(0, res.indexOf("_"));
  }

  bool isJoin = false;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          elevation: 0,
          backgroundColor: Colors.pinkAccent,
          title: const Text("Search")),
      body: Column(
        children: [
          Container(
            color: Colors.pinkAccent.shade700,
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                  style: const TextStyle(color: Colors.white),
                  controller: searchController,
                  decoration: const InputDecoration(),
                )),
                GestureDetector(
                  onTap: initiateSearchMethod,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration:
                        BoxDecoration(color: Colors.white.withOpacity(0.1)),
                    child: const Icon(
                      Icons.search,
                      color: Colors.white,
                    ),
                  ),
                )
              ],
            ),
          ),
          isLoading
              ? Center(
                  child: CircularProgressIndicator(color: Colors.purpleAccent),
                )
              : groupList()
        ],
      ),
    );
  }

  initiateSearchMethod() async {
    if (searchController.text.isNotEmpty) {
      setState(() {
        isLoading = true;
      });
    }
    await DatabaseService()
        .searchbyName(searchController.text)
        .then((snapshot) {
      setState(() {
        searchSnapshot = snapshot;

        isLoading = false;
        hasUserSearch = true;
      });
    });
  }

  groupList() {
    return hasUserSearch
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot!.docs.length,
            itemBuilder: (context, index) {
              print(
                searchSnapshot!.docs[index]['groupId'],
              );

              print("this is the object to be printed");

              // final details =.
                  // json.decode(searchSnapshot!.docs[index]['groupId']);

              // print("THIS IS THE GROUP DETAILS: $details");
              return groupTile(
                  userName,
                  searchSnapshot!.docs[index]["groupId"],
          
                  searchSnapshot!.docs[index]['groupName'],
                  searchSnapshot!.docs[index]['admin']);
            })
        : Center(child: Text("No group"));
  }

  Widget groupTile(
      String userName, String groupId, String groupName, String admin) {
    joinOrNot(
        userName: userName,
        groupId: groupId,
        groupName: groupName,
        admin: admin);

    //
    // return Text("Hello");
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
      leading: CircleAvatar(
          radius: 34,
          child: Text(groupName.substring(0, 1).toUpperCase(),
              style: TextStyle(color: Colors.white))),
      title: Text(
        groupName,
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: Text("Admin: ${getName(admin)}"),
      trailing: InkWell(
        onTap: () async {
          await DatabaseService(uid: user!.uid).toggleGroupJoin(
              groupId: groupId, userName: userName, groupName: groupName);
          if (isJoin) {
            setState(() {
              isJoin = !isJoin;
            });
            showSnackMessage(context, Colors.green, "successfully join group");
          } else {
            setState(() {
              isJoin = !isJoin;
            });
            showSnackMessage(context, Colors.red,
                "successfully removed from group ${groupName}");
          }
//
          Future.delayed(Duration(seconds: 2), () {
            nextScreen(
                context,
                ChatPage(
                    groupId: groupId,
                    groupName: groupName,
                    userName: userName));
          });
        },
        child: isJoin
            ? Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.black,
                    border: Border.all(color: Colors.white)),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  "Joined",
                  style: TextStyle(color: Colors.white),
                ),
              )
            : Container(
                decoration: BoxDecoration(
                  color: Colors.pinkAccent[400],
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: const Text(
                  "Join",
                  style: TextStyle(color: Colors.white),
                ),
              ),
      ),
    );
  }

  joinOrNot(
      {required userName,
      required groupId,
      required groupName,
      required admin}) async {
    await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
        .isUserJoin(groupName: groupName, groupId: groupId, userName: userName)
        .then((value) {
      setState(() {
        isJoin = value;
      });
    });
  }
}
