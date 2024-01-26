import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/component/dialog/loading_dialog.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/service/user_service.dart';
import 'package:mathgptpro_mclient_flutter/view/setting_module/about_page.dart';
import 'package:mathgptpro_mclient_flutter/view/setting_module/component/setting_page_button.dart';
import 'package:mathgptpro_mclient_flutter/view/setting_module/user_profile_page.dart';

class SettingMainPage extends StatefulWidget {
  const SettingMainPage({super.key});

  @override
  State<SettingMainPage> createState() => _SettingMainPageState();
}

class _SettingMainPageState extends State<SettingMainPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        iconTheme: context.theme.primaryIconTheme,
        title: Text(
          "设置".tr,
          style: context.textTheme.bodyMedium!.copyWith(fontSize: 16),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 30.h),
        children: [
          SettingPageButton(
            onTap: () {
              Get.to(() => const UserProfilePage());
            },
            text: Text('账户信息'.tr,
                style: TextStyle(
                    color: context.textTheme.bodyMedium!.color, fontSize: 16)),
          ),
          SettingPageButton(
            onTap: () {
              Get.to(() => const AboutPage());
            },
            text: Text('关于我们'.tr,
                style: TextStyle(
                    color: context.textTheme.bodyMedium!.color, fontSize: 16)),
          ),
          SettingPageButton(
            onTap: () async {
              //加载弹窗
              Get.dialog(const LoadingDialog(), barrierDismissible: false);
              //退出登录
              UserService.logout();
            },
            text: Text('退出登录'.tr,
                style: TextStyle(color: UiResource.primaryRed, fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
