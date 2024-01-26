import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/constant/main_url.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/view/common_module/web_view_page.dart';
import 'package:mathgptpro_mclient_flutter/view/welcome_module/login_page.dart';
import 'package:mathgptpro_mclient_flutter/view/welcome_module/signup_page.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      "public/asset/background/welcome_page_background.png")),
            ),
          ),
          SizedBox(
            width: Get.width,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 211.h),
                  child: Image(
                    width: 112.93.w,
                    height: 120.w,
                    image: const AssetImage(
                        "public/asset/icon/welcome_page_logo.png"),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 72.h),
                  child: const Text(
                    'All-time Interactive \n Learning',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    //Get.to(() => WebViewPage(url: MainUrl.signup));
                    Get.to(() => const SignupPage());
                  },
                  child: Container(
                    width: 327.w,
                    height: 40.h,
                    margin: EdgeInsets.only(top: 88.06.h),
                    decoration: ShapeDecoration(
                      color: UiResource.primaryWhiteBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: const Text(
                        'Sign Up',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF0053A6),
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(() => const LoginPage());
                  },
                  child: Container(
                    width: 327.w,
                    height: 40.h,
                    margin: EdgeInsets.only(top: 16.h),
                    decoration: ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        side: const BorderSide(width: 1, color: Colors.white),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.h),
                      child: const Text(
                        'Log in',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 325.w,
                  margin: EdgeInsets.only(top: 32.h),
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'By continuing, you agree to MathGPTPro',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const TextSpan(
                          text: '\n',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        WidgetSpan(
                            child: GestureDetector(
                          onTap: () {
                            Get.to(() =>
                                WebViewPage(url: MainUrl.appTermsOfService));
                          },
                          child: Container(
                            transform: Matrix4.translationValues(0, 1.5, 0),
                            child: const Text(
                              'Terms of service',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )),
                        const TextSpan(
                          text: ' ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextSpan(
                          text: 'and',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        const TextSpan(
                          text: ' ',
                        ),
                        WidgetSpan(
                            child: GestureDetector(
                          onTap: () {
                            Get.to(() =>
                                WebViewPage(url: MainUrl.appPrivacyAgreement));
                          },
                          child: Container(
                            transform: Matrix4.translationValues(0, 1.5, 0),
                            child: const Text(
                              'Privacy policy',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                        )),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
