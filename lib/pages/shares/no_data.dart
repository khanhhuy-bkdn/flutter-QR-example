import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/shared/theme/custom_theme.dart';

class NoData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverFillRemaining(
          hasScrollBody: false,
          child: Column(
            children: <Widget>[
              Expanded(
                child: Container(
                  margin: EdgeInsets.all(4),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(color: Colors.white),
                  child: Center(
                    child: Text(
                      'Chưa có dữ liệu',
                      style: CustomTheme.bodyText2(context),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
