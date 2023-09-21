import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:njadia/chat/pages/auth/grouphome.dart';
import 'package:njadia/chat/pages/auth/login.dart';

import '../../helper/helper_function.dart';
import '../../services/authservice.dart';

class SignupChat extends StatefulWidget {
  const SignupChat({super.key});

  @override
  State<SignupChat> createState() => _SignupChatState();
}

class _SignupChatState extends State<SignupChat> {
  final formKey = GlobalKey<FormState>();
  final AuthService auth = AuthService();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isloading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: _isloading
            ? Center(
                child: CircularProgressIndicator(
                color: Colors.blueGrey,
              ))
            : Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Form(
                    key: formKey,
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Groupie", style: TextStyle(fontSize: 25)),
                          Text(
                              "with this application group of user can communicate"),
                          Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Text("Loging")),
                          Container(
                            margin: EdgeInsets.only(top: 10, bottom: 20),
                            child: TextFormField(
                                controller: _nameController,
                                decoration: textInputDecoration.copyWith(
                                    labelText: "Name",
                                    prefixIcon: Icon(Icons.email_outlined))),
                          ),
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
                                    prefixIcon: Icon(Icons.email_outlined))),
                          ),
                          Container(
                            width: double.infinity,
                            height: 50,
                            decoration: BoxDecoration(
                                color: Colors.blueGrey,
                                borderRadius: BorderRadius.circular(20)),
                            child: MaterialButton(
                              onPressed: () => register(),
                              child: Text("Register"),
                            ),
                          ),
                          Text.rich(TextSpan(
                              text: "if you alreadyhave an account",
                              style: TextStyle(fontSize: 13),
                              children: [
                                TextSpan(
                                    text: "Signin",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          nextScreen(context, LoginChat()))
                              ]))
                        ]))));
  }

  register() async {
    setState(() {
      _isloading = true;
    });
    await auth
        .registerUserCredentials(
            fullname: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text)
        .then((value) async {
      if (value == true) {
        await HelperFunction.saveUserEmail(_emailController.text);
        await HelperFunction.saveUserName(_nameController.text);
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
