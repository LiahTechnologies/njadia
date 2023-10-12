import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServices {
  final String? uid;
  DatabaseServices({this.uid});

//
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("group");

  Future updateUserData({
    required String firstName,
    required String lastName,
    required String email,
    required String phoneNumber,
    required String dateOfBirth,
  }) {
    final userResponse = userCollection.doc(uid).set({
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      "phoneNumber": phoneNumber,
      'dataOfBirth': dateOfBirth,
      'groups': [],
      'uid': uid
    });

    return userResponse;
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

  Future createGroup(String userName, String id, String groupName,
      String groupLimit, String groupLevi) async {
    print("CREATING NJANGI GROUP");
    DocumentReference groupDocumentReference = await groupCollection.add({
      "groupName": groupName,
      "groupIcon": "",
      "admin": "${id}_$userName",
      "members": [],
      "groupId": "",
      "groupLevi": groupLevi,
      "groupLimit": groupLimit,
      "recentMessage": "",
      "recentMessageSender": ""
    });

    print("UPDATING NJANGI FIELDS");

    await groupDocumentReference.update({
      'members': FieldValue.arrayUnion(["${id}_$userName"]),
      'groupId': groupDocumentReference.id
    });

    DocumentReference userDocumentReference = userCollection.doc(id);
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
