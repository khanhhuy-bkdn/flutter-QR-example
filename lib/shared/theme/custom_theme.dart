import 'package:flutter/material.dart';

class CustomTheme {
  static TextStyle headline5(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
        fontSize: (Theme.of(context).textTheme.bodyText2!.fontSize ?? 0) + 6,
        fontWeight: FontWeight.bold,
        color: Colors.white);
  }

  static TextStyle headline6(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
        fontSize: (Theme.of(context).textTheme.bodyText2!.fontSize ?? 0) + 4,
        fontWeight: FontWeight.bold,
        color: Colors.white);
  }

  static TextStyle subTitle1(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
        fontSize: (Theme.of(context).textTheme.bodyText2!.fontSize ?? 0) + 2,
        fontWeight: FontWeight.bold,
        color: Colors.white);
  }

  static TextStyle subTitle2(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
        fontSize: Theme.of(context).textTheme.bodyText2!.fontSize,
        fontWeight: FontWeight.bold);
  }

  static TextStyle bodyText(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
        fontSize: (Theme.of(context).textTheme.bodyText2!.fontSize ?? 0) + 4);
  }

  static TextStyle bodyText1(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
        fontSize: (Theme.of(context).textTheme.bodyText2!.fontSize ?? 0) + 2);
  }

  static TextStyle bodyText2(BuildContext context) {
    return Theme.of(context)
        .textTheme
        .bodyText2!
        .copyWith(fontSize: Theme.of(context).textTheme.bodyText2!.fontSize);
  }

  static TextStyle subText1(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
        fontSize: (Theme.of(context).textTheme.bodyText2!.fontSize ?? 0) - 2);
  }

  static TextStyle subText2(BuildContext context) {
    return Theme.of(context).textTheme.bodyText2!.copyWith(
        fontSize: (Theme.of(context).textTheme.bodyText2!.fontSize ?? 0) - 4);
  }
}
