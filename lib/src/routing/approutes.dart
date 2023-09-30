import 'package:get/get.dart';
import 'package:njadia/chat/pages/auth/grouphome.dart';
import 'package:njadia/chat/pages/auth/login.dart';
import 'package:njadia/chat/pages/auth/signup.dart';
import 'package:njadia/src/features/add%20_people/presentation/view/add_people.dart';
import 'package:njadia/src/features/group_chat/presentation/view/create_group.dart';
import 'package:njadia/src/features/group_chat/presentation/view/group_category.dart';
import 'package:njadia/src/features/group_home_page/presentation/view/group_home_page.dart';
import 'package:njadia/src/features/group_home_page/presentation/view/menu_page.dart';
import 'package:njadia/src/features/group_home_page/presentation/view/select_group_member.dart';
import 'package:njadia/src/features/group_home_page/presentation/view/send_money.dart';
import 'package:njadia/src/features/group_home_page/presentation/view/send_money_details.dart';
import 'package:njadia/src/features/onboarding/onboardingScreen.dart';
import 'package:njadia/main.dart';
import 'package:njadia/src/features/group_chat/presentation/view/add_group_contact.dart';
import 'package:njadia/src/features/group_chat/presentation/view/group_template_option.dart';
import 'package:njadia/src/features/group_chat/presentation/view/join_group.dart';
import '../features/home/presentation/view/home.dart';
import '../features/signup/views/signup.dart';

class AppRoutes {
  static const String SPLASHSCREEN      = '/';
  static const String ONBOARDING        = '/onBoarding';
  static const String SIGNUP            = '/signup';
  static const String CHAT_SIGNUP = '/signupChat';
  static const String CHAT_LOGIN = '/loginChat';
  static const String HOMEpAGE   = '/homepage';
  static const String CREATE_GROUP_TEMPLATE = '/createGroupTemplate';
  static const String JOINGROUP = '/joinGroup';
  static const String ADDCONTACT = '/addContacts';
  static const String GROUP_CATEGORYg = '/group_category';
  static const String CREATE_GROUP = '/create_group';
  static const String ADD_USERS_LINK = '/add_users_link';
  static const String GROUP_MENU_PAGE = '/group_menu_page';
  static const String GROUP_HOME_PAGE = '/group_home_page';
  static const String SEND_MONEY_PAGE = '/send_money';
  static const String SELECT_GROUP_MEMBER_PAGE      = '/select_group_member';
  static const String SEND_MONEY_DETAIL_PAGE        = '/send_money_detail';
  

  String intialScreen() => SPLASHSCREEN;
}

class AppPages {
  static List<GetPage> appPagas = [
    GetPage(name: AppRoutes.SPLASHSCREEN, page: () => const SplashScreen()),
    GetPage(name: AppRoutes.ONBOARDING, page: () => OnBoardingScreens(),binding: BindingsBuilder(() {})),
    GetPage(name: AppRoutes.SIGNUP, page: () => Signup()),
    GetPage(name: AppRoutes.CHAT_SIGNUP, page: () =>const SignupChat()),
    GetPage(name: AppRoutes.CHAT_LOGIN, page: () =>const LoginChat()),
    GetPage(name: AppRoutes.HOMEpAGE, page: () =>const HomePage()),
    GetPage(name: AppRoutes.CREATE_GROUP_TEMPLATE, page: () =>const GroupTemplateOption()),
    GetPage(name: AppRoutes.JOINGROUP, page: () => JoinGroup()),
    GetPage(name: AppRoutes.ADDCONTACT, page: () => AddContacts()),
    GetPage(name: AppRoutes.GROUP_CATEGORYg, page: () => GroupCategory()),
    GetPage(name: AppRoutes.CREATE_GROUP, page: () => CreateGroup()),
    GetPage(name: AppRoutes.ADD_USERS_LINK, page: () => AddUserLink()),
    GetPage(name: AppRoutes.GROUP_MENU_PAGE, page: () =>const GroupMenuPage()),
    GetPage(name: AppRoutes.GROUP_HOME_PAGE, page: () =>const GroupHomePage()),
    GetPage(name: AppRoutes.SELECT_GROUP_MEMBER_PAGE, page: () =>const SelectGroupMember()),
    GetPage(name: AppRoutes.SEND_MONEY_PAGE, page: () =>const SendMoney()),
    GetPage(name: AppRoutes.SEND_MONEY_DETAIL_PAGE, page: () => SendMoneyDetail()),
  ];
}
