import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mathgptpro_mclient_flutter/component/ui_behavior/highlight_splash_theme.dart';

class SettingDetailPageButton extends StatelessWidget {
  const SettingDetailPageButton(
      {Key? key, required this.child, required this.onTap})
      : super(key: key);

  final void Function()? onTap;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return HighlightSplashTheme(
        child: InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30.w, vertical: 20.w),
        child: child,
      ),
    ));
  }
}
