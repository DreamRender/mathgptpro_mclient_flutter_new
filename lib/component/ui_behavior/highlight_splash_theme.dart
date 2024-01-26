import 'package:flutter/material.dart';
import 'package:get/get.dart';

///恢复水波纹效果的Theme
class HighlightSplashTheme extends StatelessWidget {
  final Widget child;

  const HighlightSplashTheme({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: context.theme.copyWith(
            highlightColor: context.isDarkMode
                ? const Color(0x40CCCCCC)
                : const Color(0x66BCBCBC),
            splashColor: context.isDarkMode
                ? const Color(0x40CCCCCC)
                : const Color(0x66C8C8C8)),
        child: child);
  }
}
