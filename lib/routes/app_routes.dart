import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:vtinter_chat/pages/auth/forgotPassword/binding/forgot_password_binding.dart';
import 'package:vtinter_chat/pages/auth/forgotPassword/screen/forgot_password_page.dart';
import 'package:vtinter_chat/pages/auth/login/binding/login_binding.dart';
import 'package:vtinter_chat/pages/auth/login/screen/login_page.dart';
import 'package:vtinter_chat/pages/main/drawer/binding/drawer_binding.dart';
import 'package:vtinter_chat/pages/main/drawer/screen/drawer_page.dart';
import 'package:vtinter_chat/pages/splash/binding/splash_binding.dart';
import 'package:vtinter_chat/pages/splash/screen/splash_page.dart';

class PageName {
  static const splashPage = '/';
  static const loginPage = '/login';
  static const drawerPage = '/drawerPage';
  static const forgotPasswordPage = '/forgotPasswordPage';
}

class AppRoutes {
  static List<GetPage> routes = [
    GetPage(
      name: PageName.drawerPage,
      page: () => const DrawerPage(),
      binding: DrawerBinding(),
    ),
    GetPage(
      name: PageName.forgotPasswordPage,
      page: () => const ForgotPasswordPage(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: PageName.loginPage,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: PageName.splashPage,
      page: () => const SplashPage(),
      binding: SplashBinding(),
    ),
  ];
}
