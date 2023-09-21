import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String? uid;
  DatabaseService({this.uid});

//
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("group");

  updateUserData({
    required String name,
    required String email,
  }) {
    userCollection
        .doc(uid)
        .set({'fullname': name, 'email': email, 'groups': [], 'uid': uid});
  }

  //getting user data

  Future gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where('email', isEqualTo: email).get();

    return snapshot;
  }

  Future getUserGroup() async {
    return await userCollection.doc(uid).snapshots();
  }

  Future createGroup(String userName, String id, String groupName) async {
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "recentMessage": "",
      "recentMessageSender": ""
    });

    await groupDocumentReference.update({
      'members': FieldValue.arrayUnion(["${uid}_$userName"]),
      'groupId': groupDocumentReference.id
    });

    DocumentReference userDocumentReference = userCollection.doc(uid);
    return await userDocumentReference.update({
      'groups':
          FieldValue.arrayUnion(["${groupDocumentReference.id}_$groupName"])
    });
  }

// getting chats

  Future<Stream<QuerySnapshot>> getChats(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }

  Future<String> getGroupAdmin(String groupId) async {
    DocumentReference d = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await d.get();
    return await documentSnapshot['admin'];
  }

  // get group members
  getGroupMembers(groupid) async {
    return groupCollection.doc(groupid).snapshots();
  }

  // search by name
  Future<QuerySnapshot> searchbyName(String groupName) async {
    return await groupCollection.where('groupName', isEqualTo: groupName).get();
  }

  Future<bool> isUserJoin(
      {required groupName, required groupId, required userName}) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userDocumentReference.get();

    List<dynamic> groups = await documentSnapshot['groups'];
    if (groups.contains("${groupId}_$groupName")) {
      print("user joined");
      return true;
    } else {
      print("user not joined");
      return false;
    }
  }

  // toggling the join or not button

  Future toggleGroupJoin(
      {required groupId, required userName, required groupName}) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    //

    if (groups.contains("${groupId}_${userName}")) {
      await userDocumentReference.update({
        'groups': FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_${userName}"])
      });
    } else {
      await userDocumentReference.update({
        'groups': FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_${userName}"])
      });
    }
  }

  sendMessage(
      {required groupId, required Map<String, dynamic> chatMessages}) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessages);
    groupCollection.doc(groupId).update({
      'recentMessage': chatMessages['message'],
      'recentMessageSender': chatMessages['sender'],
      'recentMessageTime': chatMessages['time'].toString()
    });
  }
}
