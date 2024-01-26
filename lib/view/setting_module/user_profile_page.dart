import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/user_controller.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/view/setting_module/component/setting_detail_page_button.dart';
import 'package:mathgptpro_mclient_flutter/view/setting_module/user_account_close_page.dart';
import 'package:mathgptpro_mclient_flutter/view/setting_module/user_info_edit_page.dart';

class UserProfilePage extends StatefulWidget {
  const UserProfilePage({super.key});

  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        iconTheme: context.theme.primaryIconTheme,
        title: Text(
          "账户信息".tr,
          style: context.textTheme.bodyMedium!.copyWith(fontSize: 16),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 30.h),
        children: [
          SettingDetailPageButton(
            onTap: () {
              Get.to(() => const UserInfoEditPage());
            },
            child: Row(
              children: [
                Text(
                  "姓".tr,
                  style: TextStyle(
                      color: context.textTheme.bodyLarge!.color, fontSize: 14),
                ),
                Container(
                  width: 30.w,
                ),
                GetX<UserController>(builder: (userController) {
                  return Text(
                    "${userController.userLastName}",
                    style: TextStyle(
                        color: context.textTheme.bodyMedium!.color,
                        fontSize: 16),
                  );
                }),
                Container(
                  width: 30.w,
                ),
                Text(
                  "名".tr,
                  style: TextStyle(
                      color: context.textTheme.bodyLarge!.color, fontSize: 14),
                ),
                Container(
                  width: 30.w,
                ),
                GetX<UserController>(builder: (userController) {
                  return Text(
                    "${userController.userFirstName}",
                    style: TextStyle(
                        color: context.textTheme.bodyMedium!.color,
                        fontSize: 16),
                  );
                }),
                const Spacer(),
                Container(
                  margin: EdgeInsets.only(left: 10.w),
                  child: const Icon(
                    Icons.edit,
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          SettingDetailPageButton(
            onTap: () {
              Get.to(() => const UserAccountClosePage());
            },
            child: Row(
              children: [
                Text(
                  "注销账号".tr,
                  style: TextStyle(color: UiResource.primaryRed, fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
