import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

/// ----[CREATE GROUP]

import 'package:njadia/src/features/authentication/data/databaseService.dart';
import 'package:njadia/src/routing/approutes.dart';

class CreateGroupService extends GetxController {
  /// ---Variables
  final authDatabase = DatabaseServices(uid:FirebaseAuth.instance.currentUser!.uid );
  final userId = FirebaseAuth.instance.currentUser!.uid;
  final userName = FirebaseAuth.instance.currentUser!.displayName;

  ///  --- ReadMe(Docs[5]) ---Create Group Services

  Future createNewNjangiGroup(
      {required String groupName,
      required String groupLevi,
      required String groupLimit}) async {
    print("CREATE GROUP SERVICES CLASSS");
    return await authDatabase.createGroup(
        "Betrand", userId, groupName, groupLevi, groupLimit);
  }
}
