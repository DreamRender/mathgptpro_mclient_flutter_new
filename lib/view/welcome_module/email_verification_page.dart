import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/component/ui_behavior/refocus_component.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/view/welcome_module/create_account_page.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  bool isPasswordVisible = false;

  TextEditingController captchaEditController = TextEditingController();

  @override
  void dispose() {
    captchaEditController.dispose();
    super.dispose();
  }

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
                      'Verification code',
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
                      'Please enter the 6-digit verification code that sent to your associated email address.',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: UiResource.primaryBlack,
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 40.w),
                    child: Center(
                      child: PinCodeTextField(
                        length: 6,
                        obscureText: false,
                        enableActiveFill: true,
                        appContext: Get.context!,
                        controller: captchaEditController,
                        animationType: AnimationType.fade,
                        animationDuration: const Duration(milliseconds: 300),
                        pinTheme: PinTheme(
                          fieldHeight: 50,
                          fieldWidth: 40,
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(5),
                          activeColor: UiResource.primaryBlue,
                          activeFillColor: Colors.white,
                          inactiveColor: UiResource.primaryGrey,
                          inactiveFillColor: Colors.transparent,
                        ),
                        onCompleted: (v) {
                          log("Completed");
                          Get.off(() => const CreateAccountPage());
                        },
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
