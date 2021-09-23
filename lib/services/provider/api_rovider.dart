import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_demo_getx/constants/error_data.dart';
import 'package:flutter_demo_getx/constants/status_message.dart';
import 'package:flutter_demo_getx/models/dictionary_item.dart';
import 'package:flutter_demo_getx/routes/app_pages.dart';
import 'package:flutter_demo_getx/services/provider/custom_exception.dart';
import 'package:flutter_demo_getx/services/provider/i_api_provider.dart';
import 'package:flutter_demo_getx/utils/function_helper.dart';
import 'package:get/route_manager.dart';
import 'package:get_storage/get_storage.dart';

class ApiProvider implements IApiProvider {
  final Dio _dio = Dio();
  final String _baseUrl = 'Service API';
  final box = GetStorage();
  String? token;

  Future<dynamic> get(String url, {Map<String, dynamic>? params}) async {
    var responseJson;
    token = box.read<String>('token');
    try {
      final response = await _dio.get(_baseUrl + url,
          queryParameters: params,
          options: Options(
              followRedirects: false,
              validateStatus: (status) => status! < 500,
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              }));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection!');
    } catch (e) {
      FunctionHelper.showSnackbar(
          'Thông báo', 'Lỗi mạng. Vui lòng kiểm tra lại!', StatusMessage.error);
    }
    return responseJson;
  }

  Future<dynamic> post(String url, dynamic data,
      {Map<String, dynamic>? params}) async {
    var responseJson;
    var jsonConvert = jsonEncode(data);
    token = box.read<String>('token');
    try {
      final response = await _dio.post(_baseUrl + url,
          data: data,
          queryParameters: params,
          options: Options(
              followRedirects: false,
              validateStatus: (status) => status! < 500,
              headers: {
                HttpHeaders.authorizationHeader: 'Bearer $token',
              }));
      responseJson = _response(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _response(Response response) {
    switch (response.statusCode) {
      case 200:
        response is dynamic;
        var responseJson = response.data['data'];
        return responseJson;
      case 400:
        showErrorMessage(response);
        return null;
      case 401:
        GetStorage().erase();
        Get.offAllNamed(Routes.login);
        break;
      case 403:
        showErrorMessage(response);
        return null;
      case 500:

      default:
        showErrorMessage(response);
        return null;
    }
  }
}

void showErrorMessage(Response response) {
  try {
    response is dynamic;
    var responseJson = response.data['error'];
    if (responseJson != null) {
      DictionaryItem? item = ErrorData.list.firstWhere(
          (o) => o!.code == responseJson['code'],
          orElse: () => null);
      // ignore: unnecessary_null_comparison
      String? textError = item != null
          ? item.displayText
          : 'Đã có lỗi xảy ra, vui lòng thử lại!';
      FunctionHelper.showSnackbar(
          'Thông báo',
          textError ?? '',
          StatusMessage.error,
          // ignore: unnecessary_brace_in_string_interps
          'Status code: ${response.statusCode.toString()} .Error message: ${textError}');
    } else {
      FunctionHelper.showSnackbar(
          'Thông báo',
          'Đã có lỗi xảy ra, vui lòng thử lại!',
          StatusMessage.error,
          'Status code: ${response.statusCode.toString()} .Error message: ${response.statusMessage.toString()}');
    }
  } catch (Exception) {
    FunctionHelper.showSnackbar(
        'Thông báo',
        'Đã có lỗi xảy ra, vui lòng thử lại!',
        StatusMessage.error,
        'Status code: ${response.statusCode.toString()} .Error message: ${response.statusMessage.toString()} - ${response.data}');
  }
}
