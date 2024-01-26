import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mathgptpro_mclient_flutter/component/ui_behavior/highlight_splash_theme.dart';

class SettingPageButton extends StatelessWidget {
  final Function onTap;
  final Text text;

  const SettingPageButton({Key? key, required this.onTap, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return HighlightSplashTheme(
        child: InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 40.w, vertical: 20.h),
        margin: EdgeInsets.only(bottom: 5.h),
        child: text,
      ),
    ));
  }
}
