import 'package:flutter/material.dart';

///用来帮助有键盘的页面重新找回焦点
class RefocusComponent extends StatelessWidget {
  final Widget child;

  const RefocusComponent({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //根据源文件，直接unFocus是safe的，无需检测
        FocusScope.of(context).unfocus();
      },
      child: child,
    );
  }
}
