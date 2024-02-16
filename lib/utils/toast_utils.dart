import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

/// toast显示工具
class ToastUtils {
  /// 系统Toast上一次的内容
  /// 用于防止重复内容打印
  static String _systemToastLastTimeMessage = "";

  /// 初始化Toast
  static FToast? _getFToast() {
    //获得全局的OverlayContext
    BuildContext? buildContext = Get.overlayContext;
    //如果为null的话就返回null，后续做进一步处理
    if (buildContext == null) {
      return null;
    }

    //初始化Toast
    FToast fToast = FToast();
    fToast.init(buildContext);
    return fToast;
  }

  /// 系统级toast
  /// 由于系统级Toast对用户体验影响很大
  /// 因此使用preventDuplicateMessage来防止多次重复的消息
  static Future<void> showSystemToast(String message,
      {bool preventDuplicateMessage = false, int displaySeconds = 3}) async {
    //防止多次重复消息
    if (preventDuplicateMessage && _systemToastLastTimeMessage == message) {
      log('-----重复SystemToast：$message-----');
      return;
    } else {
      _systemToastLastTimeMessage = message;
    }

    Toast toastLength;

    //根据时间长度判断
    if (displaySeconds <= 3) {
      toastLength = Toast.LENGTH_SHORT;
    } else {
      toastLength = Toast.LENGTH_LONG;
    }

    //首先先取消已有的调用
    await Fluttertoast.cancel();
    //显示系统级Toast
    await Fluttertoast.showToast(
      msg: message,
      toastLength: toastLength,
      gravity: ToastGravity.BOTTOM,
    );
  }

  /// 错误
  static void showErrorToast(String message, {int displaySeconds = 5}) {
    FToast? fToast = _getFToast();
    //如果获取到的Toast是null，就执行系统级Toast
    if (fToast == null) {
      showSystemToast(message, displaySeconds: displaySeconds);
      return;
    }

    //首先清除之前有可能的调用
    fToast.removeQueuedCustomToasts();

    Widget toast = getCommonToastWidget(
        message, Colors.deepOrange, "public/asset/lottie/error.json");

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: displaySeconds),
    );
  }

  /// 警告
  static void showWarningToast(String message, {int displaySeconds = 3}) {
    FToast? fToast = _getFToast();
    //如果获取到的Toast是null，就执行系统操作
    if (fToast == null) {
      showSystemToast(message, displaySeconds: displaySeconds);
      return;
    }

    //首先清除之前有可能的调用
    fToast.removeQueuedCustomToasts();

    Widget toast = getCommonToastWidget(
        message, Colors.yellow, "public/asset/lottie/warning-triangle.json");

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: displaySeconds),
    );
  }

  /// 成功
  static void showSuccessToast(String message, {int displaySeconds = 3}) {
    FToast? fToast = _getFToast();
    //如果获取到的Toast是null，就执行系统操作
    if (fToast == null) {
      showSystemToast(message, displaySeconds: displaySeconds);
      return;
    }

    //首先清除之前有可能的调用
    fToast.removeQueuedCustomToasts();

    Widget toast = getCommonToastWidget(
        message, Colors.lightGreenAccent, "public/asset/lottie/complete.json");

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: displaySeconds),
    );
  }

  /// 成功
  static void showInfoToast(String message, {int displaySeconds = 3}) {
    FToast? fToast = _getFToast();
    //如果获取到的Toast是null，就执行系统操作
    if (fToast == null) {
      showSystemToast(message, displaySeconds: displaySeconds);
      return;
    }

    //首先清除之前有可能的调用
    fToast.removeQueuedCustomToasts();

    Widget toast = getCommonToastWidget(
        message, Colors.white, "public/asset/lottie/info.json");

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: Duration(seconds: displaySeconds),
    );
  }

  /// 通用Toast构造器
  static Widget getCommonToastWidget(
      String message, Color backgroundColor, String lottieAnimPath) {
    return Container(
      //这里margin的主要作用是保证boxShadow的正常显示
      margin: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.w),
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24.r),
        color: backgroundColor,
        boxShadow: [
          BoxShadow(
              offset: Offset(0, 4.w),
              //x,y轴
              color: const Color(0x1A000000),
              //投影颜色
              blurRadius: 10.w)
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Lottie.asset(lottieAnimPath, width: 20.w, repeat: false),
          Container(
            margin: EdgeInsets.only(left: 6.w),
            constraints: BoxConstraints(maxWidth: 200.w),
            child: Text(
              message,
              style: const TextStyle(color: Colors.black, fontSize: 13),
            ),
          )
        ],
      ),
    );
  }
}
