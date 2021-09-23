import 'package:flutter_demo_getx/constants/status_message.dart';
import 'package:flutter_demo_getx/models/login.model.dart';
import 'package:flutter_demo_getx/services/provider/i_api_provider.dart';
import 'package:flutter_demo_getx/services/repository/interfaces/user/i_user_repository.dart';
import 'package:flutter_demo_getx/utils/function_helper.dart';
import 'package:get_storage/get_storage.dart';

class UserRepository implements IUserRepository {
  UserRepository({required this.apiProvider});
  final IApiProvider apiProvider;
  final GetStorage box = GetStorage();

  Future<bool> login(LoginModel model) async {
    try {
      await box.write('token', 'hello');
      return true;
    } catch (error, stacktrace) {
      FunctionHelper.showSnackbar(
          'Thông báo',
          'Đã có lỗi xảy ra. Vui lòng thử lại!',
          StatusMessage.error,
          'Error occurred $error\n Stacktrace: $stacktrace}');
      return false;
    }
  }
}
