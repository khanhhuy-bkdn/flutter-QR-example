import 'package:flutter_demo_getx/models/dictionary_item.dart';

class ErrorData {
  static List<DictionaryItem?> list = [
    DictionaryItem(
      code: 'INTERNAL_SERVER_ERROR',
      displayText: 'Đã xảy ra lỗi. Vui lòng thử lại',
    ),
    DictionaryItem(
      code: 'GET_DATA_NOT_SUCCESS',
      displayText: 'Đã xảy ra lỗi. Vui lòng thử lại',
    ),
    DictionaryItem(
      code: 'WRONG_USERNAME',
      displayText: 'Tên tài khoản hoặc mật khẩu không đúng',
    ),
    DictionaryItem(
      code: 'WRONG_PASSWORD',
      displayText: 'Mật khẩu hiện tại không đúng',
    ),
    DictionaryItem(
      code: 'USER_DEACTIVE',
      displayText: 'Tài khoản này đã bị vô hiệu hóa',
    ),
    DictionaryItem(
      code: 'ACCOUNT_NOT_EXIST',
      displayText: 'Tài khoản không tồn tại',
    ),
    DictionaryItem(
      code: 'ACCOUNT_NOT_ACTIVE',
      displayText: 'Tài khoản chưa được kích hoạt.',
    ),
    DictionaryItem(
      code: 'TOKEN_NOT_EXIST',
      displayText: 'Token không tồn tại',
    ),
    DictionaryItem(
      code: 'OBJECT_NOT_FOUND',
      displayText: 'Không tìm thấy đối tượng',
    ),
    DictionaryItem(
      code: 'NOT_VALIDATED_EMAIL',
      displayText: 'Email không đúng định dạng',
    ),
    DictionaryItem(
      code: 'VERIFIED_ACCOUNT',
      displayText: 'Tài khoản đã xác thực',
    ),
    DictionaryItem(
      code: 'EMAIL_EXIST',
      displayText: 'Email đã tồn tại trong hệ thống',
    ),
    DictionaryItem(
      code: 'USERNAME_EXIST',
      displayText: 'Tên tài khoản đã tồn tại trong hệ thống',
    ),
    DictionaryItem(
      code: 'USERNAME_EMAIL_EXIST',
      displayText: 'Tên tài khoản hoặc tên email đã tồn tại',
    ),
    DictionaryItem(
      code: 'PERMISSION_DENIED',
      displayText: 'Bạn không được phép truy cập trang này',
    ),
    DictionaryItem(
      code: 'INVALID_STATUS',
      displayText: 'Trạng thái hồ sơ không hợp lệ',
    ),
    DictionaryItem(
      code: 'INVALID_PARAMETER',
      displayText: 'Đã xảy ra lỗi. Vui lòng thử lại',
    ),
    DictionaryItem(
      code: 'INVALID_POSTING',
      displayText: 'Ngày chứng từ vượt quá thời gian cho phép!',
    ),
    DictionaryItem(
      code: 'INVALID_INVENTORY',
      displayText: 'Không đủ số lượng tồn kho',
    ),
    DictionaryItem(
      code: 'INVALID_LOT_NO',
      displayText: 'Mã lô này đã tồn tại trong hệ thống!',
    ),
    DictionaryItem(
      code: 'WRONG_USERNAME_OR_PASSWORD',
      displayText: 'Sai tên đăng nhập hoặc mật khẩu!',
    ),
    DictionaryItem(
      code: 'INVALID_APPROVAL_PERMISSION',
      displayText: 'Bạn không có quyền duyệt!',
    ),
  ];
}
