import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/view/welcome_module/welcome_page.dart';

class AppVersionUpdatePage extends StatelessWidget {
  const AppVersionUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: Get.width,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.only(top: 150.w),
              child: Image(
                width: 93.w,
                height: 93.w,
                image: const AssetImage(
                    "public/asset/icon/app_version_update_page_icon.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.w),
              child: Text(
                'Update your application to the \nlatest version',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: UiResource.primaryBlack,
                ),
              ),
            ),
            Container(
              width: 303.w,
              margin: EdgeInsets.only(top: 80.w),
              child: Text(
                'A brand new version of the MathGPTPro is available in the app store. Please update your app to use all of our amazing features. ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: UiResource.primaryBlack,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.offAll(() => const WelcomePage());
              },
              child: Container(
                height: 40.w,
                width: 326.w,
                margin: EdgeInsets.only(top: 80.w),
                decoration: ShapeDecoration(
                  color: UiResource.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: const Text(
                    'Update Now',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
