import 'package:get/get.dart';
import 'package:njadia/chat/pages/auth/grouphome.dart';
import 'package:njadia/chat/pages/auth/login.dart';
import 'package:njadia/chat/pages/auth/signup.dart';
import 'package:njadia/src/features/onboarding/onboardingScreen.dart';
import 'package:njadia/main.dart';
import 'package:njadia/src/features/group_chat/presentation/view/add_contact.dart';
import 'package:njadia/src/features/group_chat/presentation/view/group_template.dart';
import 'package:njadia/src/features/group_chat/presentation/view/join_group.dart';
import '../features/group_chat/presentation/view/create_group.dart';
import '../features/signup/views/signup.dart';

class AppRoutes {
  static const String splashScreen = '/';
  static const String onBoardingScreen = '/onBoarding';
  static const String signUp = '/signup';
  static const String chatSignUp = '/signupChat';
  static const String chatLogin = '/loginChat';
  static const String createGroup = '/createGroup';
  static const String createGroupTemplate = '/createGroupTemplate';
  static const String joinGroup = '/joinGroup';
  static const String addContacts = '/addContacts';
  

  String intialScreen() => splashScreen;
}

class AppPages {
  static List<GetPage> appPagas = [
    GetPage(name: AppRoutes.splashScreen, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.onBoardingScreen, page: () => OnBoardingScreens(),binding: BindingsBuilder(() {})),
    GetPage(name: AppRoutes.signUp, page: () => Signup()),
    GetPage(name: AppRoutes.chatSignUp, page: () =>const SignupChat()),
    GetPage(name: AppRoutes.chatLogin, page: () =>const LoginChat()),
    GetPage(name: AppRoutes.createGroup, page: () =>const createGroup()),
    GetPage(name: AppRoutes.createGroupTemplate, page: () =>const GroupTemplate()),
    GetPage(name: AppRoutes.joinGroup, page: () => JoinGroup()),
    GetPage(name: AppRoutes.addContacts, page: () => AddContacts()),
  ];
}
