import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class ContentEmptyView extends StatelessWidget {
  final double topMargin;

  final String tipText;

  const ContentEmptyView(
      {Key? key, this.topMargin = 120, this.tipText = "这里好像没啥"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.only(top: topMargin),
          child: Lottie.asset('public/asset/lottie/cat-tail-wag.json'),
        ),
        Text(
          tipText,
          style: TextStyle(
              color: context.textTheme.bodyMedium!.color, fontSize: 15),
        )
      ],
    );
  }
}
