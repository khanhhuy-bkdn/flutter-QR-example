import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/shared/theme/custom_theme.dart';

class ButtonFilterApprove extends StatelessWidget {
  const ButtonFilterApprove({this.numberString, this.textButton, this.color});
  final String? numberString;
  final String? textButton;
  final Color? color;
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(numberString ?? '',
              style: CustomTheme.headline6(context).apply(color: color)),
          Text(
            textButton ?? '',
            textAlign: TextAlign.center,
            style: CustomTheme.subText2(context).apply(color: Colors.black),
          )
        ],
      ),
    );
  }
}
