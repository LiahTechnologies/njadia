import 'package:flutter/material.dart';

import '../helper/helper_function.dart';
import '../pages/auth/chatpage.dart';

class GroupTile extends StatefulWidget {
  final String userName;
  final String groupid;
  final String groupName;
  const GroupTile(
      {super.key,
      required this.groupName,
      required this.userName,
      required this.groupid});

  @override
  State<GroupTile> createState() => _GroupTileState();
}

class _GroupTileState extends State<GroupTile> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        nextScreen(
            context,
            ChatPage(
                groupId: widget.groupid,
                groupName: widget.groupName,
                userName: widget.userName));
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10,vertical: 6),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.pinkAccent.withOpacity(0.09),
        ),
        
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Colors.pinkAccent,
            child: Text(
              widget.groupName.substring(0, 1).toUpperCase(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
          title: Text(
            widget.groupName,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(widget.userName),
        ),
      ),
    );
  }
}
 