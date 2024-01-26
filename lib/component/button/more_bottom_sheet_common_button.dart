import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

/// 更多底部弹窗的圆形按钮
class MoreBottomSheetCommonButton extends StatelessWidget {
  const MoreBottomSheetCommonButton(
      {Key? key, required this.child, required this.name, required this.onTap})
      : super(key: key);

  final Widget child;

  final String name;

  final Function() onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 60.w,
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              //先关闭这个BottomSheet
              Get.back();
              await onTap();
            },
            child: Container(
              width: 58.w,
              height: 58.w,
              decoration: BoxDecoration(
                  color: context.theme.cardColor,
                  borderRadius: BorderRadius.circular(16.r)),
              child: Center(
                child: child,
              ),
            ),
          ),
          Container(
            height: 10.w,
          ),
          Text(
            name,
            style: TextStyle(
                color: context.textTheme.bodyMedium!.color, fontSize: 13),
          )
        ],
      ),
    );
  }
}
