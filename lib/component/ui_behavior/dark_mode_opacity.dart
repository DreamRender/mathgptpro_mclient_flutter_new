import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DarkModeOpacity extends StatelessWidget {
  final double lightModeOpacity;

  final double darkModeOpacity;

  final Widget child;

  const DarkModeOpacity(
      {Key? key,
      this.lightModeOpacity = 1,
      this.darkModeOpacity = 0.7,
      required this.child})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: context.isDarkMode ? darkModeOpacity : lightModeOpacity,
      child: child,
    );
  }
}
