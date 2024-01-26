import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';

class ThemeUtils {
  /// 设置和系统暗黑模式保持一致
  static setSystemBrightness() {
    var platformDispatcher = WidgetsBinding.instance.platformDispatcher;
    setThemeMode(brightnessMode: platformDispatcher.platformBrightness);
  }

  /// 监听系统的暗黑模式变化
  static bindListeningToSystemBrightnessChange() {
    var platformDispatcher = WidgetsBinding.instance.platformDispatcher;

    // This callback is called every time the brightness changes.
    platformDispatcher.onPlatformBrightnessChanged = () {
      var brightness = platformDispatcher.platformBrightness;
      if (kDebugMode) {
        log("系统的明暗模式修改为：$brightness");
      }
      //没打开Overlay才允许变换，否则有可能导致build出错
      if (!Get.isOverlaysOpen) {
        setThemeMode(brightnessMode: brightness);
      }
    };
  }

  /// 设置明暗模式
  static setThemeMode({Brightness brightnessMode = Brightness.light}) {
    if (brightnessMode == Brightness.light) {
      //设置白天模式
      log('设置白天模式ThemeData');
      Get.changeTheme(UiResource.lightModeThemeData);
      setBarMode(brightnessMode: Brightness.light);
    } else {
      //设置夜晚模式
      log('设置夜晚模式ThemeData');
      Get.changeTheme(UiResource.darkModeThemeData);
      setBarMode(brightnessMode: Brightness.dark);
    }
  }

  /// 设置明暗模式下的状态栏和导航栏
  static setBarMode({Brightness brightnessMode = Brightness.light}) {
    if (brightnessMode == Brightness.light) {
      //设置白天模式
      log('设置白天模式BarMode');
      SystemChrome.setSystemUIOverlayStyle(
          UiResource.lightModeSystemOverlayStyle);
    } else {
      //设置夜晚模式
      log('设置夜晚模式BarMode');
      SystemChrome.setSystemUIOverlayStyle(
          UiResource.darkModeSystemOverlayStyle);
    }
  }

  /// 获取当前的系统UiOverlay设置
  static SystemUiOverlayStyle getCurrentUiOverlayStyle() {
    bool isDarkMode = Get.isDarkMode;

    if (isDarkMode) {
      return UiResource.darkModeSystemOverlayStyle;
    } else {
      return UiResource.lightModeSystemOverlayStyle;
    }
  }
}
