import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'localdata.dart';

class AreaInfo {
  static double bottomPadding = 0;
}

double getFontSize(int size) {
  // print('height ${ScreenUtil().screenHeight}' );
  // print('bottom padding ${AreaInfo.bottomPadding}' );
  double ratio = ScreenUtil().screenWidth /
      (ScreenUtil().screenHeight - AreaInfo.bottomPadding);
  double newScaleHeight =
      (ScreenUtil().screenHeight - AreaInfo.bottomPadding) / 1000.0;

  //double ratio = ScreenUtil().screenWidth / (ScreenUtil().screenHeight);
  //double newScaleHeight = (ScreenUtil().screenHeight) / 844.0;

  if (ratio < designRatio) {
    double ratio2 = ratio / designRatio;
    return size.toDouble() * ScreenUtil().scaleHeight * ratio2;
  }

  //return size.toDouble() * ScreenUtil().scaleHeight;
  return size.toDouble() * newScaleHeight;
}

const double designRatio = 600.0 / 1000.0;
//const double designRatio = 390.0 / 797.0;

double getSize(double size) {
  double ratio = ScreenUtil().screenWidth /
      (ScreenUtil().screenHeight - AreaInfo.bottomPadding);
  double newScaleHeight =
      (ScreenUtil().screenHeight - AreaInfo.bottomPadding) / 1000.0;

  //double ratio = ScreenUtil().screenWidth / (ScreenUtil().screenHeight);
  //double newScaleHeight = (ScreenUtil().screenHeight) / 844.0;

  //print('height ${ScreenUtil().screenHeight}' );
  //print('bottom padding ${AreaInfo.bottomPadding}' );

  if (ratio < designRatio) {
    double ratio2 = ratio / designRatio;
    return ScreenUtil().scaleHeight * size * ratio2;
  }

  //return ScreenUtil().scaleHeight * size;
  return newScaleHeight * size;
}

class F {
  // ignore: non_constant_identifier_names
  static FontWeight get Thin => FontWeight.w100;
  // ignore: non_constant_identifier_names
  static FontWeight get ExtraLight => FontWeight.w200;
  // ignore: non_constant_identifier_names
  static FontWeight get Light => FontWeight.w300;
  // ignore: non_constant_identifier_names
  static FontWeight get Regular => FontWeight.w400;
  // ignore: non_constant_identifier_names
  static FontWeight get Medium => FontWeight.w500;
  // ignore: non_constant_identifier_names
  static FontWeight get SemiBold => FontWeight.w600;
  // ignore: non_constant_identifier_names
  static FontWeight get Bold => FontWeight.w700;
  // ignore: non_constant_identifier_names
  static FontWeight get ExtraBold => FontWeight.w800;
  // ignore: non_constant_identifier_names
  static FontWeight get Black => FontWeight.w900;
}

Size getTextSize(String text, TextStyle style) {
  final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr)
    ..layout(minWidth: 0, maxWidth: double.infinity);
  return textPainter.size;
}

void showToast(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    // gravity: ToastGravity.CENTER,
    // timeInSecForIosWeb: 1,
    // backgroundColor: Colors.red,
    // textColor: Colors.white,
    // fontSize: 16.0,
  );
}

class Debug {
  static JsonDecoder decoder = const JsonDecoder();
  static JsonEncoder encoder = const JsonEncoder.withIndent('  ');

  static void formattedJson(String input) {
    if (kDebugMode) {
      if (input.isEmpty) {
        log('json is empty.');
        return;
      }
      var object = decoder.convert(input);
      var prettyString = encoder.convert(object);
      prettyString.split('\n').forEach((element) => log(element));
    }
  }

  static void log(Object? obj) {
    if (kDebugMode) {
      print(obj);
    }
  }

  static void showErrorMessage({required int status, required String body}) {
    // 에러 확인을 위해 release 에서도...
    // if (kDebugMode == false) {
    //   return;
    // }

    if (body.isEmpty) {
      showToast('Empty body. ($status)');
      return;
    }

    var jsonObject = jsonDecode(body);
    showToast(
        '${jsonObject['path']}\n${jsonObject['message']}\n${jsonObject['errorMessage']}\n($status)');
  }

  static const _chars =
      'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
  static final Random _rnd = Random();
  static String getRandomString(int length) =>
      String.fromCharCodes(Iterable.generate(
          length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));
}

void checkLogin(
    {required Function loggedIn, required Function notLogin}) async {
  //LoginPlatform loginPlatform = await LocalData.getLoginPlatform();
  //LocalData.setToken('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2OTEzMDg4MzksImRhdGEiOnsidWlkIjo0LCJlbWFpbCI6InljZTMyMkBnbWFpbC5jb20iLCJzbnNfdHlwZSI6MCwicmVnX2RhdGUiOiIyMDIzLTA2LTMwVDEyOjA0OjE5LjAwMFoiLCJsb2dpbl9kYXRlIjoiMjAyMy0wNy0wN1QwODowMDozOS4wMDBaIiwiaXNfbGVhdmUiOjAsImxlYXZlX2RhdGUiOm51bGwsImlzX2JhbiI6MCwic25zX3VzZXJfaWQiOiJrYWthbzoyODc2NzEwMjMxIiwibmF2ZXJfcmVmcmVzaF90b2tlbiI6bnVsbH0sImlhdCI6MTY4ODcxNjgzOX0.wNpbnhwe-x8VkmSmHHQBoAaxvTl86-Md9rpaWxGGhW0');
  String token = await LocalData.getToken();
  if (token == '') {
    notLogin();
  } else {
    loggedIn();
  }
}

class LoadingIndicator {
  late BuildContext context;

  LoadingIndicator(this.context);

  Future<void> startLoading() async {
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return const PopScope(
            canPop: false,
            child: SimpleDialog(
              elevation: 0.0,
              backgroundColor: Colors.transparent,
              children: [
                Center(
                  child: CircularProgressIndicator(),
                ),
              ],
            ),
          );
        });
  }

  Future<void> stopLoading() async {
    Navigator.of(context).pop();
  }
}
