import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/pages/shares/qr-scan/QRScan.dart';
import 'package:flutter_demo_getx/routes/app_pages.dart';
import 'package:flutter_demo_getx/shared/theme/custom_theme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeQrView extends StatefulWidget {
  @override
  _HomeQrViewState createState() => _HomeQrViewState();
}

class _HomeQrViewState extends State<HomeQrView>
    with SingleTickerProviderStateMixin {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  var defaultFontSize = 13.0;
  var defaultTextPosisionSize = 11.0;

  var resultQrcode = ''.obs;

  @override
  void initState() {
    super.initState();
  }

  scanCode() async {
    await QRScan.scan().then((result) {
      //result = 'https://stackoverflow.com/questions/ask';
      resultQrcode.value = result ?? '';
      if (result != null && result != "") {
        if (result.contains("https") || result.contains("http")) {
          Get.defaultDialog(
            title: 'Mở trình duyệt',
            titleStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: defaultBgColor,
                fontSize: defaultFontSize + 4),
            content:
                Text('Bạn có muốn mở trình duyệt cho đường dẫn này không?'),
            actions: <Widget>[
              CupertinoDialogAction(
                child: Text('Từ chối'),
                onPressed: () => Get.back(),
              ),
              CupertinoDialogAction(
                  child: Text('Đi đến'), onPressed: () => _launchURL(result)),
            ],
          );
        }
      }
    });
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      endDrawerEnableOpenDragGesture: false,
      drawerEnableOpenDragGesture: false,
      body: SafeArea(
        child: Container(
          child: Stack(
            children: <Widget>[
              Positioned.fill(
                child: Column(
                  children: <Widget>[
                    headerWidget(context),
                    Expanded(child: contentWidget(context)),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.qr_code,
          color: Colors.white,
        ),
        onPressed: () => scanCode(),
      ),
    );
  }

  Widget headerWidget(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: defaultBgColor,
      ),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.map,
                  color: Colors.white,
                ),
                onPressed: () {
                  Get.toNamed(Routes.map);
                },
              ),
              Expanded(
                child: Text(
                  "QUÉT MÃ QR/BARCODE",
                  textAlign: TextAlign.center,
                  style: CustomTheme.headline6(context),
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.logout,
                  color: Colors.white,
                ),
                onPressed: () {
                  GetStorage().erase();
                  Get.offAllNamed(Routes.login);
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  Widget contentWidget(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.5,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: defaultPadding),
            child: Text(
              'Kết quả',
              style: TextStyle(
                  fontSize: defaultFontSize + 4,
                  fontWeight: FontWeight.bold,
                  color: defaultBgColor),
            ),
          ),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(defaultPadding),
              margin: EdgeInsets.all(defaultPadding),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red),
                color: Color(0xFFBFBFBF),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Obx(
                () => SelectableText('${resultQrcode}'),
              ),
            ),
          )
        ],
      ),
    );
  }
}
