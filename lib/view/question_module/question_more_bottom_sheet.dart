import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/component/button/more_bottom_sheet_common_button.dart';
import 'package:mathgptpro_mclient_flutter/component/dialog/confirm_dialog.dart';
import 'package:mathgptpro_mclient_flutter/component/dialog/loading_dialog.dart';
import 'package:mathgptpro_mclient_flutter/service/session_service.dart';
import 'package:mathgptpro_mclient_flutter/utils/toast_utils.dart';

class QuestionMoreBottomSheet extends StatelessWidget {
  QuestionMoreBottomSheet(
      {Key? key, required this.sessionId, this.isDeleteInPage = false})
      : super(key: key);

  final int sessionId;

  final bool isDeleteInPage;

  final SessionService sessionService = SessionService();

  @override
  Widget build(BuildContext context) {
    List<Widget> warpContent = [
      MoreBottomSheetCommonButton(
          name: '删除'.tr,
          child: Image.asset(
            "public/asset/icon/删除.png",
            width: 30.w,
            height: 30.w,
          ),
          onTap: () {
            Get.dialog(ConfirmDialog(
              message: "确认删除？".tr,
              onConfirm: () async {
                Get.dialog(const LoadingDialog(), barrierDismissible: false);

                bool result = await sessionService.deleteSessionById(sessionId);

                if (result) {
                  ToastUtils.showInfoToast("成功".tr);

                  //在页面中就要退出
                  if (isDeleteInPage) {
                    Get.back(closeOverlays: true);
                  } else {
                    //只关闭Dialog
                    Get.back();
                  }
                } else {
                  ToastUtils.showWarningToast("删除失败".tr);
                }
              },
            ));
          })
    ];

    return Container(
      width: Get.width,
      decoration: BoxDecoration(
        color: context.theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Stack(
        children: [
          ListView(
            padding: EdgeInsets.symmetric(vertical: 35.h, horizontal: 15.w),
            shrinkWrap: true,
            children: [
              Text(
                "更多".tr,
                style: TextStyle(
                    color: context.textTheme.bodyMedium!.color, fontSize: 15),
              ),
              Container(
                height: 20.w,
              ),
              //按钮区域
              Wrap(
                spacing: 26.w,
                alignment: WrapAlignment.start,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: warpContent,
              )
            ],
          ),
          Positioned(
              top: 20.h,
              right: 20.w,
              child: GestureDetector(
                onTap: () {
                  Get.back();
                },
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Icon(
                    Icons.close,
                    color: context.theme.primaryIconTheme.color,
                    size: 15.w,
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
