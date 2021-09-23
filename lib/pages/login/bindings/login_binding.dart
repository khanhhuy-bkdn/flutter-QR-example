import 'package:flutter_demo_getx/pages/login/controllers/login_controller.dart';
import 'package:flutter_demo_getx/services/repository/infrastructure/user/user_repository.dart';
import 'package:flutter_demo_getx/services/repository/interfaces/user/i_user_repository.dart';
import 'package:get/get.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    //Get.lazyPut<IHomeProvider>(() => HomeProvider());
    Get.lazyPut<IUserRepository>(() => UserRepository(apiProvider: Get.find()));
    Get.lazyPut(() => LoginController(userRepository: Get.find()));
  }
}
