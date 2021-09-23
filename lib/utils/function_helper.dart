import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/shared/theme/custom_theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/constants/status_message.dart';
import 'package:get/get.dart';

class FunctionHelper {
  static double fontSizeIcon = 13;
  static String formatCurrencyNumber(num number, {int? decimalDigits}) {
    int nguyen = number.toInt();
    num thapphan = number - nguyen;
    NumberFormat currencyFormat = new NumberFormat.currency(
        locale: "en_US",
        symbol: "",
        decimalDigits:
            (decimalDigits ?? 0) > 0 ? (thapphan > 0 ? decimalDigits : 0) : 0);
    return currencyFormat.format(number);
  }

  static void showSnackbar(String title, String message, String type,
      [String? messageError]) {
    if (type == StatusMessage.success) {
      Get.snackbar(title, message,
          titleText: Text(
            title,
            style:
                TextStyle(color: Colors.green, fontSize: defaultFontSize + 2),
          ),
          messageText: Text(message),
          colorText: Colors.black,
          icon: Icon(Icons.check_rounded, color: Colors.green),
          backgroundColor: Colors.white);
    } else {
      Get.snackbar(title, message,
          titleText: Text(
            title,
            style: TextStyle(color: Colors.red, fontSize: defaultFontSize + 2),
          ),
          messageText: Text(message),
          colorText: Colors.red,
          icon: Icon(
            Icons.error_sharp,
            color: Colors.red,
          ),
          backgroundColor: Colors.white);
      print(messageError);
    }
  }

  static comingSoon(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              child: Column(
                children: <Widget>[
                  Text(
                    'Chức năng này sẽ sớm cập nhật',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: CustomTheme.bodyText2(context).fontSize),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: defaultPadding / 2),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Colors.black.withOpacity(0.5),
                        textColor: Colors.white,
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text("Đóng"),
                      ))
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
