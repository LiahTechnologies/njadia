import 'package:flutter/material.dart';

import '../helper/helper_function.dart';
import 'auth/grouphome.dart';
import 'auth/login.dart';

class ChatHome extends StatefulWidget {
  const ChatHome({super.key});

  @override
  State<ChatHome> createState() => _ChatHomeState();
}

class _ChatHomeState extends State<ChatHome> {
  bool _isLoggedIn = false;
  @override
  void initState() {
    super.initState();
  }

  getUserLogginState() async {
    await HelperFunction.getUserLoggedInData().then((value) {
      if (value != null) _isLoggedIn = value; 
     

    });
  }

  @override
  Widget build(BuildContext context) {
    return _isLoggedIn? ChatGroupHome():LoginChat();
  }
}
