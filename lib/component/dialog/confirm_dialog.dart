import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';

/// 信息确认dialog
class ConfirmDialog extends StatelessWidget {
  /// 提醒信息
  final String message;

  ///确认后执行
  final Function onConfirm;

  ///该操作是否为危险操作，如果是的话，确认按钮颜色就会变淡
  final bool isDangerConfirm;

  const ConfirmDialog(
      {Key? key,
      required this.message,
      required this.onConfirm,
      this.isDangerConfirm = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    //阻止用户关闭这个Dialog
    return PopScope(
        canPop: false,
        // 由于dialog有一个默认的宽度，所以使用UnconstrainedBox+SizedBox来去除这个默认宽度
        child: UnconstrainedBox(
          child: SizedBox(
            //这个width有一个最大限制，不能达到全屏幕宽度
            width: 375.w,
            child: Dialog(
              backgroundColor: context.theme.dialogBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.r)),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30.w, horizontal: 26.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: 9.w,
                          child: const Image(
                            fit: BoxFit.cover,
                            image: AssetImage("public/asset/icon/标题装饰（右）.png"),
                          ),
                        ),
                        Container(
                          width: 10.w,
                        ),
                        Text(
                          "提示".tr,
                          style: context.textTheme.bodyMedium!
                              .copyWith(fontSize: 16),
                        ),
                        Container(
                          width: 10.w,
                        ),
                        SizedBox(
                          width: 9.w,
                          child: const Image(
                            fit: BoxFit.cover,
                            image: AssetImage("public/asset/icon/标题装饰（右）.png"),
                          ),
                        )
                      ],
                    ),
                    //主内容
                    Container(
                      margin: EdgeInsets.only(top: 31.w),
                      constraints: BoxConstraints(maxHeight: 200.h),
                      child: ScrollConfiguration(
                          behavior: const ScrollBehavior(),
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              Text(
                                message,
                                textAlign: TextAlign.center,
                                style: context.textTheme.bodyMedium!
                                    .copyWith(fontSize: 16),
                              )
                            ],
                          )),
                    ),
                    //下方按钮
                    Container(
                      margin: EdgeInsets.only(top: 30.w),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          GestureDetector(
                            onTap: () {
                              //关闭dialog
                              Get.back();
                            },
                            child: Container(
                              height: 42.w,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(44.5.r),
                                  border: Border.all(
                                      color: const Color(0x1A007EFF),
                                      width: 2.w)),
                              child: Center(
                                child: Text(
                                  "取消".tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: UiResource.primaryBlue),
                                ),
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () async {
                              //一定是关闭dialog
                              Get.back();
                              //再执行操作
                              await onConfirm();
                            },
                            child: Container(
                              height: 42.w,
                              width: 100.w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(44.5.r),
                                  border: Border.all(
                                      color: const Color(0x1A007EFF),
                                      width: 2.w)),
                              child: Center(
                                child: Text(
                                  "确认".tr,
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: UiResource.primaryBlue.withOpacity(
                                          isDangerConfirm ? 0.5 : 1)),
                                ),
                              ),
                            ),
                          )
                        ],
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
