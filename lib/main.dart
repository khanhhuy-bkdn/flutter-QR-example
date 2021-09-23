import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/services/provider/api_rovider.dart';
import 'package:flutter_demo_getx/services/provider/i_api_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'lang/translation_service.dart';
import 'routes/app_pages.dart';
import 'shared/logger/logger_utils.dart';
import 'dart:ui' as ui;

void main() async {
  await GetStorage.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> with WidgetsBindingObserver {
  // This widget is the root of your application.
  bool? isTablet;
  bool? isPhone;
  double defaultFontSize = 13.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    Get.put<IApiProvider>(ApiProvider(), permanent: true);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      enableLog: true,
      logWriterCallback: Logger.write,
      debugShowCheckedModeBanner: false,
      title: 'App test',
      initialRoute: AppPages.initRouter,
      getPages: AppPages.routes,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      theme: ThemeData(
          secondaryHeaderColor: defaultBgColor,
          primarySwatch: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          accentColor: defaultBgColor,
          textTheme: TextTheme(
            headline2: TextStyle(
              color: Colors.white,
              fontSize: defaultFontSize + 4,
              fontWeight: FontWeight.bold,
            ),
            headline3: TextStyle(
              color: Colors.white,
              fontSize: defaultFontSize + 2,
              fontWeight: FontWeight.bold,
            ),
            headline4: TextStyle(
              color: Colors.white,
              fontSize: defaultFontSize,
              fontWeight: FontWeight.bold,
            ),
            subtitle1:
                TextStyle(fontSize: defaultFontSize), // font for TextFormField
            subtitle2: TextStyle(
              fontSize: defaultFontSize,
            ),
            bodyText1: TextStyle(
                fontSize: defaultFontSize +
                    2), // Được sử dụng để nhấn mạnh văn bản mà nếu không sẽ là bodyText2 .
            bodyText2:
                TextStyle(fontSize: defaultFontSize), // Kiểu văn bản mặc định
            caption: TextStyle(fontSize: defaultFontSize - 2),
            overline: TextStyle(fontSize: defaultFontSize - 4),
            button: TextStyle(fontSize: 16),
          ),
          fontFamily: 'Roboto'),
      // home: CustomBarWidget()
    );
  }
}
