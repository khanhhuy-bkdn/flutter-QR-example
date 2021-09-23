import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:flutter_demo_getx/constants/status_message.dart';
import 'package:flutter_demo_getx/models/login.model.dart';
import 'package:flutter_demo_getx/pages/login/controllers/login_controller.dart';
import 'package:flutter_demo_getx/routes/app_pages.dart';
import 'package:flutter_demo_getx/shared/theme/custom_theme.dart';
import 'package:flutter_demo_getx/utils/function_helper.dart';
import 'package:flutter_demo_getx/utils/hex_color.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert'; // for the utf8.encode method
import 'package:collection/collection.dart';
import 'package:local_auth/local_auth.dart';
import 'package:local_auth/error_codes.dart' as auth_error;

class SignInScreen extends StatefulWidget {
  @override
  LoginFormState createState() {
    return LoginFormState();
  }
}

class LoginFormState extends State<SignInScreen> {
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _branchFocus = FocusNode();
  final _formKey = GlobalKey<FormState>();
  final mq = MediaQueryData.fromWindow(window);
  bool isSaveAcc = true;
  bool showPass = false;
  TextEditingController userNameEditingController = TextEditingController();
  TextEditingController passwordEditingController = TextEditingController();
  LoginModel loginModel = new LoginModel(null, null);

  bool _loading = false;

  @override
  void initState() {
    super.initState();
    // getBranch();
    _checkBiometrics();
    _getAvailableBiometrics();
  }

  final LocalAuthentication auth = LocalAuthentication();
  bool? _canCheckBiometrics;
  List<BiometricType>? _availableBiometrics;
  String _authorized = 'Not Authorized';
  bool _isAuthenticating = false;

  Future<void> _checkBiometrics() async {
    late bool canCheckBiometrics;
    try {
      canCheckBiometrics = await auth.canCheckBiometrics;
    } on PlatformException catch (e) {
      canCheckBiometrics = false;
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _canCheckBiometrics = canCheckBiometrics;
    });
  }

  Future<void> _getAvailableBiometrics() async {
    late List<BiometricType> availableBiometrics;
    try {
      availableBiometrics = await auth.getAvailableBiometrics();
    } on PlatformException catch (e) {
      availableBiometrics = <BiometricType>[];
      print(e);
    }
    if (!mounted) return;

    setState(() {
      _availableBiometrics = availableBiometrics;
    });
  }

  //xác thực passcode + vân tay
  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason: 'Let OS determine authentication method',
          useErrorDialogs: true,
          stickyAuth: true);
      setState(() {
        _isAuthenticating = false;
      });
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        // Handle this exception here.
        FunctionHelper.showSnackbar('Thông báo',
            'Thiết bị chưa kích hoạt các yếu tố xác thực', StatusMessage.error);
      }
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;

    setState(() {
      _authorized = authenticated ? 'Authorized' : 'Not Authorized';
      if (authenticated) {
        Get.offNamed(Routes.home);
      }
    });
  }

  //xác thực vân tay
  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      setState(() {
        _isAuthenticating = true;
        _authorized = 'Authenticating';
      });
      authenticated = await auth.authenticate(
          localizedReason:
              'Scan your fingerprint (or face or whatever) to authenticate',
          useErrorDialogs: true,
          stickyAuth: true,
          biometricOnly: true);
      setState(() {
        _isAuthenticating = false;
        _authorized = 'Authenticating';
      });
    } on PlatformException catch (e) {
      if (e.code == auth_error.notEnrolled) {
        // Handle this exception here.
        FunctionHelper.showSnackbar(
            'Thông báo',
            'Thiết bị chưa kích hoạt vân tay hoặc face ID',
            StatusMessage.error);
      }
      print(e);
      setState(() {
        _isAuthenticating = false;
        _authorized = "Error - ${e.message}";
      });
      return;
    }
    if (!mounted) return;

    final String message = authenticated ? 'Authorized' : 'Not Authorized';
    setState(() {
      _authorized = message;
      if (authenticated) {
        Get.offNamed(Routes.home);
      }
    });
  }

  void _cancelAuthentication() async {
    await auth.stopAuthentication();
    setState(() => _isAuthenticating = false);
  }

  String encodePassword(String input) {
    var byte = AsciiCodec().encode(input);
    return base64.encode((sha1.convert(byte)).bytes);
  }

  void clearLogin(BuildContext context) {
    showMyDialog(context);
    GetStorage().erase();
  }

  Future<void> signin() async {
    setState(() {
      _loading = true;
    });
    if (_formKey.currentState!.validate()) {
      loginModel.userName = userNameEditingController.value.text;
      loginModel.password =
          encodePassword(passwordEditingController.value.text);
      bool login = await Get.find<LoginController>().login(loginModel);
      await Future.delayed(Duration(seconds: 1));
      setState(() {
        _loading = false;
      });
      if (login) {
        Get.offNamed(Routes.home);
        //clearLogin(context);
      }
    }
    setState(() {
      _loading = false;
    });
  }

  void showMyDialog(BuildContext context) {
    showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.fromLTRB(24.0, 20.0, 24.0, 10),
          content: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Container(
              //height: 118,
              child: Column(
                children: <Widget>[
                  Text(
                    'Thông báo',
                    style: CustomTheme.headline5(context),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Bạn không được phép truy cập vào chi nhánh này!',
                    textAlign: TextAlign.justify,
                    style: TextStyle(
                        fontSize: CustomTheme.bodyText1(context).fontSize),
                  ),
                  Padding(
                      padding: EdgeInsets.only(top: defaultPadding / 2),
                      child: FlatButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        color: Colors.black.withOpacity(0.5),
                        textColor: Colors.white,
                        // padding: EdgeInsets.symmetric(
                        //     vertical: defaultPadding / 2,
                        //     horizontal: defaultPadding),
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

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          Opacity(
            opacity: _loading ? 0.7 : 1.0,
            child: AbsorbPointer(
              absorbing: _loading ? true : false,
              child: Scaffold(
                  // resizeToAvoidBottomInset: false,
                  // resizeToAvoidBottomPadding: false,
                  body: SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    height: mq.size.height,
                  ),
                  child: Container(
                      padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage("assets/images/bg.png"),
                          fit: BoxFit.cover,
                        ),
                      ),
                      alignment: Alignment.center,
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // SizedBox(
                            //   width: MediaQuery.of(context).size.width * 0.85,
                            //   child: Image(
                            //       image: AssetImage(
                            //           'assets/images/logo-achau.png')),
                            // ),
                            Container(
                              margin: EdgeInsets.all(defaultPadding * 2),
                              padding: EdgeInsets.all(defaultPadding),
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.all(
                                      Radius.circular(defaultPadding))),
                              child: Form(
                                key: _formKey,
                                child: SingleChildScrollView(
                                  child: Column(children: <Widget>[
                                    Text(
                                      'Đăng nhập',
                                      style: TextStyle(
                                          fontSize: 22.0,
                                          color: HexColor('#3498B7'),
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: defaultPadding,
                                            top: defaultPadding,
                                            right: defaultPadding),
                                        child: TextFormField(
                                          controller: userNameEditingController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Trường này là bắt buộc';
                                            }
                                            return null;
                                          },
                                          decoration: new InputDecoration(
                                              prefixIcon: Container(
                                                  margin: EdgeInsets.only(
                                                      bottom: 6),
                                                  child: Icon(Icons.person,
                                                      size: 14)),
                                              hintText: 'Tài khoản',
                                              fillColor: Colors.white,
                                              filled: true),
                                          textInputAction: TextInputAction.next,
                                          // autofocus: true,
                                          onFieldSubmitted: (String data) {
                                            FocusScope.of(context)
                                                .requestFocus(_passwordFocus);
                                          },
                                        )),
                                    Padding(
                                        padding: EdgeInsets.only(
                                            left: defaultPadding,
                                            top: defaultPadding,
                                            right: defaultPadding),
                                        child: TextFormField(
                                          controller: passwordEditingController,
                                          validator: (value) {
                                            if (value!.isEmpty) {
                                              return 'Trường này là bắt buộc';
                                            }
                                            return null;
                                          },
                                          obscureText: !this.showPass,
                                          focusNode: _passwordFocus,
                                          decoration: new InputDecoration(
                                            prefixIcon: Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 6),
                                                child:
                                                    Icon(Icons.lock, size: 14)),
                                            hintText: 'Mật khẩu',
                                            fillColor: Colors.white,
                                            filled: true,
                                            suffixIcon: Container(
                                                margin:
                                                    EdgeInsets.only(bottom: 6),
                                                child: InkWell(
                                                    onTap: () => setState(() {
                                                          this.showPass =
                                                              !this.showPass;
                                                        }),
                                                    child: this.showPass
                                                        ? Icon(
                                                            Icons
                                                                .remove_red_eye_outlined,
                                                            size: 20)
                                                        : Icon(
                                                            Icons
                                                                .remove_red_eye_rounded,
                                                            size: 20))),
                                          ),
                                          textInputAction: TextInputAction.send,
                                          onFieldSubmitted: (String data) {
                                            signin();
                                          },
                                        )),
                                    SizedBox(
                                      height: 30,
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: defaultPadding * 2),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10.0),
                                child: RaisedButton(
                                  padding: EdgeInsets.zero,
                                  onPressed: () => signin(),
                                  textColor: Colors.white,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: <Color>[
                                          HexColor('#3498B7'),
                                          HexColor('#3498B7')
                                        ],
                                      ),
                                    ),
                                    padding: EdgeInsets.all(defaultPadding),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Text(
                                        'Đăng nhập',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () => _authenticateWithBiometrics(),
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        top: defaultPadding,
                                        bottom: defaultPadding / 2,
                                      ),
                                      width: 120.0,
                                      height: 50,
                                      child: Image(
                                        image: AssetImage(
                                            'assets/images/fingerprint.png'),
                                      ),
                                    ),
                                  ),
                                  Text(
                                    'Đăng nhập bằng vân tay',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  )
                                ],
                              ),
                            ),
                          ])),
                ),
              )),
            ),
          ),
          _loading
              ? Center(
                  child: CircularProgressIndicator(
                      //valueColor: AlwaysStoppedAnimation<Color>(Colors.amberAccent),
                      ))
              : Container(),
        ],
      ),
    );
  }
}
