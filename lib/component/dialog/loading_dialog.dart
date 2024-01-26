import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class LoadingDialog extends StatelessWidget {
  const LoadingDialog({super.key});

  @override
  Widget build(BuildContext context) {
    //阻止用户关闭这个Dialog
    return PopScope(
        canPop: false,
        // 由于dialog有一个默认的宽度，所以使用UnconstrainedBox+SizedBox来去除这个默认宽度
        child: UnconstrainedBox(
          child: SizedBox(
            //这个width有一个最大限制，不能达到全屏幕宽度
            width: 250.w,
            child: Dialog(
              backgroundColor: context.theme.dialogBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10.r))),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20.w),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 50.w,
                      child: OverflowBox(
                        minHeight: 30.w,
                        maxHeight: 150.w,
                        child: Lottie.asset("public/asset/lottie/loading.json",
                            height: 150.w),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.only(top: 30.w),
                      child: Text(
                        "处理中".tr,
                        style: context.textTheme.bodyMedium!
                            .copyWith(fontSize: 16),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
