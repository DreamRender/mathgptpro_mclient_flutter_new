import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/component/ui_behavior/refocus_component.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/view/welcome_module/email_verification_page.dart';
import 'package:mathgptpro_mclient_flutter/view/welcome_module/login_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: RefocusComponent(
        child: Stack(
          children: [
            Container(
              height: 240.w,
              width: Get.width,
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          "public/asset/background/login_page_background.png"))),
            ),
            Container(
              margin: EdgeInsets.only(top: 88.w, left: 24.w),
              child: Image(
                width: 63.w,
                height: 67.w,
                image:
                    const AssetImage("public/asset/icon/login_page_logo.png"),
              ),
            ),
            Container(
              width: Get.width,
              margin: EdgeInsets.only(top: 220.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15.r),
              ),
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 64.w),
                    child: Text(
                      'Let’s sign you up!',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: UiResource.primaryBlack,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 16.w),
                    child: Text(
                      'Enter the email that you want to receive a verification code.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: UiResource.primaryBlack,
                      ),
                    ),
                  ),
                  Container(
                    height: 40.w,
                    margin: EdgeInsets.only(top: 40.w),
                    padding: EdgeInsets.symmetric(horizontal: 8.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                            color: UiResource.primaryGrey, width: 1.w)),
                    child: Center(
                      child: TextField(
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "Email",
                          hintStyle: TextStyle(color: UiResource.primaryGrey),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 4.w),
                    child: Text(
                      'Resend notification code',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: UiResource.primaryBlue,
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const EmailVerificationPage());
                    },
                    child: Container(
                      height: 40.w,
                      margin: EdgeInsets.only(top: 160.w),
                      decoration: ShapeDecoration(
                        color: UiResource.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.w),
                        child: const Text(
                          'Get a verification code',
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
                  Container(
                    margin: EdgeInsets.only(top: 16.w),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Already have an account? ',
                            style: TextStyle(
                              color: UiResource.primaryBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          WidgetSpan(
                              child: GestureDetector(
                            onTap: () {
                              Get.offAll(() => const LoginPage());
                            },
                            child: Container(
                              transform: Matrix4.translationValues(0, 1.5, 0),
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                  color: UiResource.primaryBlue,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
