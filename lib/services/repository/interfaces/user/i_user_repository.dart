import 'package:flutter_demo_getx/models/login.model.dart';

abstract class IUserRepository {
  Future<bool> login(LoginModel model);
}
