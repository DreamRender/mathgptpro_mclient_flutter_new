import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UiResource {
  /// 标准黑色
  static Color primaryBlack = const Color(0xFF333333);

  /// 标准灰色
  static Color primaryGrey = const Color(0xFFA6AAAE);

  /// 透明型灰色
  /// 主要用于在需要不透明的地方，替换cardColor
  static Color lightGrey = const Color(0xFF454545);

  /// 标准紫色
  static Color primaryPurple = const Color(0xFF8222F8);

  /// 标准蓝色
  static Color primaryBlue = const Color(0xFF339AF0);

  /// 标准浅蓝
  static Color primaryWhiteBlue = const Color(0xFFF1F9FF);

  /// 标准绿色
  static Color primaryGreen = const Color(0xFF04D076);

  /// 标准黄色
  static Color primaryYellow = const Color(0xFFFCC01B);

  /// primaryYellow
  static Color primaryRed = const Color(0xffFF5F5F);

  /// 亮色系统模式
  static ThemeData lightModeThemeData = ThemeData.light(useMaterial3: true)
      .copyWith(
          //主题颜色
          primaryColor: primaryBlue,
          //文字主题
          textTheme: const TextTheme(
            //不透明度30
            bodyLarge: TextStyle(
                color: Color(0x4D222222),
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
                wordSpacing: 0),
            //bodyText1自带bold属性，用于所有带有bold字体的情况
            //其他正文使用bodyText1.color
            bodyMedium: TextStyle(
                color: Color(0xFF222222),
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
                wordSpacing: 0),
            //不透明度50
            bodySmall: TextStyle(
                color: Color(0x80222222),
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
                wordSpacing: 0),
          ),
          //AppBar主题
          appBarTheme: const AppBarTheme(
              backgroundColor: Colors.white,
              foregroundColor: Color(0xFF222222)),
          //弹窗背景色
          dialogBackgroundColor: const Color(0xFFf4f7f9),
          //背景颜色
          scaffoldBackgroundColor: const Color(0xfff4f7f9),
          //卡片颜色
          cardColor: const Color(0xFFFFFFFF),
          //默认为黑色的图标颜色
          primaryIconTheme: const IconThemeData(color: Color(0xFF222222)),
          //默认为白色的图标颜色
          iconTheme: const IconThemeData(color: Color(0xFFD8D8D8)),
          //底部导航栏颜色，也可作为卡片父容器的背景颜色（如话题和地点页）
          bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFFFFFFFF)),
          //去除水波纹1
          highlightColor: Colors.transparent,
          //去除水波纹2
          splashColor: Colors.transparent);

  /// 暗色系统模式
  static ThemeData darkModeThemeData = ThemeData.dark(useMaterial3: true)
      .copyWith(
          //主题颜色
          primaryColor: primaryBlue,
          //文字主题
          textTheme: const TextTheme(
            //不透明度30
            bodyLarge: TextStyle(
                color: Color(0x4DFFFFFF),
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
                wordSpacing: 0),
            //bodyText1自带bold属性，用于所有带有bold字体的情况
            //其他正文使用bodyText1.color
            bodyMedium: TextStyle(
                color: Color(0xFFFFFFFF),
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
                wordSpacing: 0),
            //不透明度50
            bodySmall: TextStyle(
                color: Color(0x80FFFFFF),
                fontWeight: FontWeight.normal,
                letterSpacing: 0,
                wordSpacing: 0),
          ),
          //AppBar主题
          appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF424242),
              foregroundColor: Color(0xFFFFFFFF)),
          //弹窗背景色
          dialogBackgroundColor: const Color(0xFF343434),
          //背景颜色
          scaffoldBackgroundColor: const Color(0xFF111111),
          //使用设计师给的“卡片透明度百分之10”方案
          //会造成SelectableText的弹窗出现透明的情况
          //这个是我们调出来的，更舒服的颜色
          //cardColor: Color(0x1AFFFFFF),
          cardColor: const Color(0xFF1D1D1D),
          //默认为黑色的图标颜色
          primaryIconTheme: const IconThemeData(color: Color(0xFFD8D8D8)),
          //默认为白色的图标颜色
          iconTheme: const IconThemeData(color: Color(0xFF222222)),
          //去除水波纹1
          highlightColor: Colors.transparent,
          //去除水波纹2
          splashColor: Colors.transparent,
          bottomAppBarTheme: const BottomAppBarTheme(color: Color(0xFF0A0A0A)));

  /// 系统将会显示黑色的文字和图标，用作白色的背景
//System overlays should be drawn with a dark color. Intended for applications with a light background.
//   static const SystemUiOverlayStyle dark = SystemUiOverlayStyle(
//     systemNavigationBarColor: Color(0xFF000000),
//     systemNavigationBarDividerColor: null,
//     statusBarColor: null,
//     systemNavigationBarIconBrightness: Brightness.light,
//     statusBarIconBrightness: Brightness.dark,
//     statusBarBrightness: Brightness.light,
//   );
  static SystemUiOverlayStyle lightModeSystemOverlayStyle =
      SystemUiOverlayStyle.dark.copyWith(
          //默认状态栏是没有颜色的（浅灰色），改为透明色
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          //默认导航栏是黑色的，现在改成白色
          systemNavigationBarColor: Colors.grey.shade50);

  /// 系统将会显示白色的文字和图标，用作黑色的背景
//System overlays should be drawn with a light color. Intended for applications with a dark background.
//   static const SystemUiOverlayStyle light = SystemUiOverlayStyle(
//     systemNavigationBarColor: Color(0xFF000000),
//     systemNavigationBarDividerColor: null,
//     statusBarColor: null,
//     systemNavigationBarIconBrightness: Brightness.light,
//     statusBarIconBrightness: Brightness.light,
//     statusBarBrightness: Brightness.dark,
//   );
  static SystemUiOverlayStyle darkModeSystemOverlayStyle =
      SystemUiOverlayStyle.light.copyWith(
          //默认状态栏是没有颜色的（浅灰色），改为透明色
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          //默认导航栏是黑色的，现在改成白色
          systemNavigationBarColor: const Color(0xFF000000));

  /// 默认屏幕方向
  static List<DeviceOrientation> defaultOrientationList = [
    DeviceOrientation.portraitUp
  ];

  /// 全向屏幕方向（用户拍照）
  static List<DeviceOrientation> allOrientationList = [
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight
  ];

  /// 默认在卡片中的照片的高度（需配合ScreenUtil使用）
  static double defaultCardImageHeight = 104;

  /// 默认在卡片中的照片的宽度（需配合ScreenUtil使用）
  static double defaultCardImageWidth = 104;

  /// 对于动态尺寸的照片的默认最小高度（需配合ScreenUtil使用）
  static double defaultAdaptiveImageMinHeight = 104;

  /// 对于动态尺寸的照片的默认最大高度（需配合ScreenUtil使用）
  static double defaultAdaptiveImageMaxHeight = 325;

  /// 对于动态尺寸的照片的默认最小宽度（需配合ScreenUtil使用）
  static double defaultAdaptiveImageMinWidth = 104;

  /// 对于动态尺寸的照片的默认最大宽度（需配合ScreenUtil使用）
  static double defaultAdaptiveImageMaxWidth = 325;

  /// 卡片中长文本的最大显示长行数
  static int defaultCardTextMaxLine = 8;

  /// 评论输入框长文本的最大显示行数
  static int defaultCommentTextMaxLine = 8;
}
