import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/component/dialog/confirm_dialog.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/service/user_service.dart';
import 'package:mathgptpro_mclient_flutter/utils/toast_utils.dart';

class UserAccountClosePage extends StatelessWidget {
  const UserAccountClosePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        iconTheme: context.theme.primaryIconTheme,
        title: Text(
          "注销账号".tr,
          style: context.textTheme.bodyMedium!.copyWith(fontSize: 16),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 20.w),
        children: [
          Text(
            "注销账户前请您知晓".tr,
            style: context.textTheme.bodyMedium!.copyWith(fontSize: 16),
          ),
          Container(
            height: 10.w,
          ),
          Text(
            "在您注销账户前，有以下事项需要与您确认：".tr,
          ),
          Container(
            height: 15.w,
          ),
          Text(
            "1. 您的账户不可恢复，所有私有数据将会被永久删除。".tr,
          ),
          Container(
            height: 10.w,
          ),
          Text(
            "2. 您的账户将在7个工作日内完成注销".tr,
          ),
          Container(
            height: 20.w,
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {
                  Get.dialog(ConfirmDialog(
                      message: "您是否确认注销账户".tr,
                      onConfirm: () async {
                        ToastUtils.showInfoToast("成功".tr);
                        //关闭页面
                        Get.back();
                        //退出登录
                        UserService.logout();
                      }));
                },
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 15.w, horizontal: 40.w),
                  decoration: BoxDecoration(
                    color: UiResource.primaryRed,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Center(
                    child: Text(
                      "注销账号".tr,
                      style: const TextStyle(
                          fontSize: 14, color: Color(0xFFFFFFFF)),
                    ),
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
