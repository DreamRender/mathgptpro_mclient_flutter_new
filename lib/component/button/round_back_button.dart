import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';

/// 左上角返回按钮
class RoundBackButton extends StatelessWidget {
  const RoundBackButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        width: 40.w,
        height: 40.w,
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: context.isDarkMode ? UiResource.lightGrey : Colors.white,
        ),
        child: Center(
          child: Icon(Icons.chevron_left,
              color: context.theme.primaryIconTheme.color),
        ),
      ),
    );
  }
}
