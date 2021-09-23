import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/pages/shares/qr-scan/scan_qr.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class QRScan {
  static Future<dynamic> scan() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      var resulta;
      await Get.to(() => QRViewExample(callback: (result) {
            resulta = result;
          }));
      return resulta;
    } else if (status.isPermanentlyDenied) {
      Get.defaultDialog(
        title: 'Yêu cầu cho phép truy cập máy ảnh',
        titleStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: defaultBgColor,
            fontSize: defaultFontSize + 4),
        content: Text('Ứng dụng cần cấp quyền truy cập máy ảnh để quét mã QR'),
        actions: <Widget>[
          CupertinoDialogAction(
            child: Text('Từ chối'),
            onPressed: () => Get.back(),
          ),
          CupertinoDialogAction(
            child: Text('Cài đặt'),
            onPressed: () => openAppSettings(),
          ),
        ],
      );
    }
  }
}
