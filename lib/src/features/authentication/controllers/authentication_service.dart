import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:njadia/src/features/authentication/data/auth_repository.dart';

/// ----README.md ----Bindings
class AuthenticationServices extends GetxController {
  static AuthenticationServices get instance => Get.find();

  /// --- Variables ---
  final auth = AuthenticationRepository();

  /// ---loads when app lounch form main
  @override
  void onReady() {
    super.onReady();
  }

/*--------------- SIGN IN WITH EMAIL & PASSWORD -----------------------------*/

  /// ---- [SENDEMAILVERIFICATION] --LOGIN
  Future<void> sendVerification() async {
    try {
      await auth.emailverification();
    } on FirebaseException catch (e) {
      print(e.message);
    }
  }

  /// ----[EMAIL & PASSWORD] --REGISTRATION
  Future<bool?> registerWithEmailAndPassword(
      {password, email, firstName, lastName, phoneNumber, dateOfBirth}) async {
    final respons = await auth.registerUserWithEmailAndPassword(
        password: password,
        email: email,
        firstName: firstName,
        lastName: lastName,
        phoneNumber: phoneNumber,
        dateOBirth: dateOfBirth);
    return respons;
  }

  /// ---

  Future<bool?> signinWithEmailAndPassword({email, password}) async {
    final response = await auth.signinUser(password: password, email: email);
    return response;
  }
}
