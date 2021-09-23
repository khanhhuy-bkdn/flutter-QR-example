import 'package:flutter_demo_getx/pages/home-qr/bindings/home_qr_binding.dart';
import 'package:flutter_demo_getx/pages/home-qr/views/home_qr_view.dart';
import 'package:flutter_demo_getx/pages/login/bindings/login_binding.dart';
import 'package:flutter_demo_getx/pages/login/views/SignIn_screen.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
part 'app_routes.dart';

// ignore: avoid_classes_with_only_static_members
class AppPages {
  static final initRouter =
      GetStorage().read('token') == null ? Routes.login : Routes.home;

  static final routes = [
    GetPage(
        name: Routes.login,
        page: () => SignInScreen(),
        binding: LoginBinding()),
    GetPage(
      name: Routes.home,
      page: () => HomeQrView(),
      binding: HomeQrBinding(),
    ),
  ];
}
