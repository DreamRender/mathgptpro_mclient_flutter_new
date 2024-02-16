import 'package:flutter/material.dart';

///UI相关计算工具包
class UiCalculatorUtils {
  ///计算文字装饰条的长度
  static double paintWidthWithTextStyle(TextStyle style, String text) {
    final TextPainter textPainter = TextPainter(
        text: TextSpan(text: text, style: style),
        maxLines: 1,
        textDirection: TextDirection.ltr)
      ..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size.width;
  }

  ///规避textOverflow对于数字字母的过分缩进问题
  static String breakWord(String word) {
    if (word.isEmpty) {
      return word;
    }
    String breakWord = ' ';
    for (var element in word.runes) {
      breakWord += String.fromCharCode(element);
      breakWord += '\u200B';
    }
    return breakWord;
  }
}
