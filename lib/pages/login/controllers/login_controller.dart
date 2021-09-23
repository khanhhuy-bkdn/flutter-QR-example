import 'package:flutter_demo_getx/models/login.model.dart';
import 'package:flutter_demo_getx/services/repository/interfaces/user/i_user_repository.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class LoginController extends GetxController {
  LoginController({required this.userRepository});
  final IUserRepository userRepository;

  Future<bool> login(LoginModel model) async {
    return await userRepository.login(model);
  }
}
