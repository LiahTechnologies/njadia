import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:njadia/src/features/signup/views/signup.dart';
import '../../src/features/signup/controller/signController.dart';
import '../helper/helper_function.dart';
import 'databaseService.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  SignController signUpController = Get.put(SignController());
// login

  var OTP = '';
  String _uid = '';
  String get uid => _uid;

  Future signinUser({required password, required email}) async {
    try {
      User user = (await firebaseAuth.signInWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null) return true;
    } catch (e) {}
  }

// phone number signup

  Future registerWithPhoneNumber(
      String phoneNumber, BuildContext context) async {
    try {
      firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (credential) async {
            await firebaseAuth
                .signInWithCredential(credential)
                .then((value) => {print("THIS IS THE CODE $value")});
          },
          verificationFailed: (e) {
            if (e.code == 'invalid-phone-number') {
              showSnackMessage(context, const Color.fromARGB(255, 10, 7, 7),
                  "Inalid phone number");
            } else {
              print("THIS  IS THE VERIFICATION CODE $e");

              showSnackMessage(context, Colors.green, "successful");
            }
          },
          codeSent: (verificationId, resendToken) {
            // this.OTP = verificationId;
            // Navigator.push(context, route)

            signUpController.OTPcode = RxString(verificationId);
           
           
           
          },
          codeAutoRetrievalTimeout: (verificationId) {
            this.OTP = verificationId;
          });
    } catch (e) {}
  }

  // OTP  verification

  Future<void> verifyOTP(
      {required BuildContext context,
      required String verificationId,
      required String userId,
      Function? onSubmit}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userId);
      User user = (await firebaseAuth.signInWithCredential(credential)).user!;

      if (user != null) {
        _uid = user.uid;
        onSubmit!();
      }
    } on FirebaseAuthException catch (e) {}
  }

  // register
  Future registerUserCredentials(
      {required password, required email, required fullname}) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      if (user != null)
        await DatabaseService(uid: user.uid)
            .updateUserData(name: fullname, email: email);
      return true;
    } catch (e) {}
  }

// login
  login() async {
    await HelperFunction.saveUserEmail("");
    await HelperFunction.saveUserLoggInState(false);
    await HelperFunction.saveUserName("");
    await firebaseAuth.signOut();
  }

  logout() {}
}
