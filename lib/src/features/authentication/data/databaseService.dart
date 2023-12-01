import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseServices {
  final String? uid;
  DatabaseServices({this.uid});

//
  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");
  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("group");
  final CollectionReference chatCollection =
      FirebaseFirestore.instance.collection("chats");

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
      'chats': [],
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
    DocumentReference userDocumentReference = userCollection.doc(uid!);
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

  Future<bool> toggleGroupJoin(
      {required groupId, required userName, required groupName}) async {
    DocumentReference userDocumentReference = userCollection.doc(uid);
    DocumentReference groupDocumentReference = groupCollection.doc(groupId);

    DocumentSnapshot documentSnapshot = await userDocumentReference.get();
    List<dynamic> groups = await documentSnapshot['groups'];

    //

    // print("JOIN GROUP DETIALS ${groupId}  $groupName userid: $uid ");

    if (groups.contains("${groupId}_${userName}")) {
      print(" IF JOIN GROUP DETIALS ${groupId}  $groupName userid: $uid ");
      await userDocumentReference.update({
        'groups': FieldValue.arrayRemove(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayRemove(["${uid}_${userName}"])
      });
      return true;
    } else {
      print(
          " else JOIN GROUP DETIALS ${groupId}  $groupName userid: $uid   $userName    $groupName");
      await userDocumentReference.update({
        'groups': FieldValue.arrayUnion(["${groupId}_$groupName"])
      });
      await groupDocumentReference.update({
        "members": FieldValue.arrayUnion(["${uid}_${userName}"])
      });
      return true;
    }
  }

  sendMessage(
      {required groupId, required Map<String, dynamic> chatMessages}) async {
    groupCollection.doc(groupId).collection("messages").add(chatMessages);
    groupCollection.doc(groupId).update({
      'recentMessage': chatMessages['message'],
      'recentMessageSender': chatMessages['sender'],
      'recentMessageTime': chatMessages['time'].toString(),
      "isReply":chatMessages['isReply'],
      "replyMessage":chatMessages['replyMessage'],
      "replySender":chatMessages['replySender']
    });
  }

  // DIRECT MESSAGING

  Future createChat(
      {required String recipientId, required String recipientName}) async {
    // DocumentReference chatDocumentReference = await chatCollection.add({
    //   "chatId": recipientId,
    //   "recipientName": recipientName,
    //   "recentMessage": "",
    //   "recentMessageSender": ""
    // });

    // await chatDocumentReference.update({'chatId': chatDocumentReference.id});

    // DocumentReference userDocumentReference = userCollection.doc(recipientId);
    // return await userDocumentReference.update({
    //   'chats':
    //       FieldValue.arrayUnion(["${chatDocumentReference.id}_$recipientId"])
    // });

    DocumentReference userDocumentReference = userCollection.doc(recipientId);
    // userDocumentReference.update(data)
    // if(userCollection.where("chats", isEqualTo: recipientId).count().)
    return await userDocumentReference.update({
      'chats': FieldValue.arrayUnion(["${recipientId}_$recipientName"])
    });
  }

  Future sendChatMessage(
      {required chatId, required Map<String, dynamic> chatMessages}) async {
    chatCollection.doc(chatId).collection("messages").add(chatMessages);
    chatCollection.doc(chatId).update({
      'recentMessage': chatMessages['message'],
      'recentMessageSender': chatMessages['sender'],
      'recentMessageTime': chatMessages['time'].toString()
    });
  }

  Future<Stream<QuerySnapshot>> getChatMessages(String chatId) async {
    return chatCollection
        .doc(chatId)
        .collection('messages')
        .orderBy('time')
        .snapshots();
  }
}
