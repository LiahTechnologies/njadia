import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../src/features/signup/views/signup.dart';
import '../../helper/helper_function.dart';
import '../../services/authservice.dart';
import '../../services/databaseService.dart';
import 'grouphome.dart';

class LoginChat extends StatefulWidget {
  const LoginChat({super.key});

  @override
  State<LoginChat> createState() => _LoginChatState();
}

class _LoginChatState extends State<LoginChat> {
  final formKey = GlobalKey<FormState>();
  final AuthService auth = AuthService();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isloading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Form(
                    key: formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Text("Groupie", style: TextStyle(fontSize: 25)),
                          const Text(
                              "with this application group of user can communicate"),
                          const Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text("Loging")),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                            child: TextFormField(
                                controller: _emailController,
                                decoration: textInputDecoration.copyWith(
                                    labelText: "Email",
                                    prefixIcon: Icon(Icons.email_outlined))),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                            child: TextFormField(
                                controller: _passwordController,
                                decoration: textInputDecoration.copyWith(
                                    labelText: "Password",
                                    prefixIcon: Icon(Icons.lock))),
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(20)),
                            child: MaterialButton(
                              onPressed: () => login(),
                              child: Text("Login"),
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Text.rich(TextSpan(
                              text: "if you don't have an account",
                              mouseCursor: MouseCursor.defer,
                              children: [
                                TextSpan(
                                    text: "Signup",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap =
                                          () => nextScreen(context, Signup()))
                              ]))
                        ]))));
  }

  login() async {
    setState(() {
      _isloading = true;
    });
    await auth
        .signinUser(
            email: _emailController.text, password: _passwordController.text)
        .then((value) async {
      if (value == true) {
        QuerySnapshot snapshot =
            await DatabaseService(uid: FirebaseAuth.instance.currentUser!.uid)
                .gettingUserData(_emailController.text);
        // await HelperFunction.saveUserEmail(
        // FirebaseAuth.instance.currentUser!.displayName!);
        await HelperFunction.saveUserName(snapshot.docs[0]['fullname']);
        await HelperFunction.saveUserLoggInState(true);

        // navigate to home screen
        nextScreen(context, ChatGroupHome());
      } else {
        showSnackMessage(context, Colors.red, value);
        setState(() {
          _isloading = false;
        });
      }
    });
  }
}
