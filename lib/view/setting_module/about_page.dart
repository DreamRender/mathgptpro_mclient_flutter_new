import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/constant/main_url.dart';
import 'package:mathgptpro_mclient_flutter/view/common_module/web_view_page.dart';
import 'package:mathgptpro_mclient_flutter/view/setting_module/component/setting_detail_page_button.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 1,
        iconTheme: context.theme.primaryIconTheme,
        title: Text(
          "关于我们".tr,
          style: context.textTheme.bodyMedium!.copyWith(fontSize: 16),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.only(top: 30.h),
        children: [
          SettingDetailPageButton(
            onTap: () {
              Get.to(() => WebViewPage(url: MainUrl.appTermsOfService));
            },
            child: Row(
              children: [
                Text(
                  "用户协议".tr,
                  style: TextStyle(
                      color: context.textTheme.bodyMedium!.color, fontSize: 16),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: context.theme.primaryIconTheme.color,
                  size: 26,
                )
              ],
            ),
          ),
          SettingDetailPageButton(
            onTap: () {
              Get.to(() => WebViewPage(url: MainUrl.appPrivacyAgreement));
            },
            child: Row(
              children: [
                Text(
                  "隐私政策".tr,
                  style: TextStyle(
                      color: context.textTheme.bodyMedium!.color, fontSize: 16),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: context.theme.primaryIconTheme.color,
                  size: 26,
                )
              ],
            ),
          ),
          SettingDetailPageButton(
            onTap: () {
              showLicensePage(context: context);
            },
            child: Row(
              children: [
                Text(
                  "开源许可".tr,
                  style: TextStyle(
                      color: context.textTheme.bodyMedium!.color, fontSize: 16),
                ),
                const Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: context.theme.primaryIconTheme.color,
                  size: 26,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
