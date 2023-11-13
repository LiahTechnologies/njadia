import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../common/helper_function.dart';
import '../../../authentication/data/databaseService.dart';
import '../widgets/groupTile.dart';

class AllGroups extends StatefulWidget {
  const AllGroups({super.key});

  @override
  State<AllGroups> createState() => _AllGroupsState();
}

class _AllGroupsState extends State<AllGroups> {

   final TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  String userName = '';
  String userEmail = '';
  Stream? group;

  getUserData() async {
    await HelperFunction.getUserName().then((value) {
      setState(() {
        userName = value;
      });
    });
    await HelperFunction.getUserEmail().then((value) {
      setState(() {
        userEmail = value;
      });
    });
    await DatabaseServices(uid: FirebaseAuth.instance.currentUser!.uid)
        .getUserGroup()
        .then((snapshot) {
      setState(() {
        group = snapshot;
      });
    });

    print(
        "THIS IS THE LIST OF GROUPS  ${FirebaseAuth.instance.currentUser!.uid}");
    print(" THE NUMBE OF GROUPS IS  ${await group!.length}");
  }

  String getId(String res) {
    return res.substring(9, res.indexOf('_'));
  }

  String getName(String res) {
    return res.substring(res.indexOf("_") + 1);
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: grouplist(),
    );
  }


    grouplist() {
    return StreamBuilder(
        stream: group,
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data['groups'] != null) {
              if (snapshot.data['groups'].length != 0) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data['groups'].length,
                    itemBuilder: (context, index) {
                      var reverseIndex =
                          snapshot.data['groups'].length - index - 1;
                      return GroupTile(
                          groupName:
                              getName(snapshot.data['groups'][reverseIndex]),
                          userName: snapshot.data['firstName'],
                          groupid:
                              getId(snapshot.data['groups'][reverseIndex]));
                    });
              } else {
                return Text("");
                // return noGroupWidget();
              }
            } else {
              return Text("");
              // return noGroupWidget();
            }
          } else {
            return Container(
                height: 560.h,
                child: const Center(child: Text("No Group Created")));
          }
        });
  }
}
