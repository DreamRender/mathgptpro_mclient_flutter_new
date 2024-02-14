import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/component/ui_behavior/refocus_component.dart';
import 'package:mathgptpro_mclient_flutter/constant/main_url.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/init_app.dart';
import 'package:mathgptpro_mclient_flutter/service/user_service.dart';
import 'package:mathgptpro_mclient_flutter/utils/toast_utils.dart';
import 'package:mathgptpro_mclient_flutter/view/common_module/web_view_page.dart';
import 'package:mathgptpro_mclient_flutter/view/introducation_module/introduction_page_1.dart';
import 'package:mathgptpro_mclient_flutter/view/welcome_module/profile_infill_page.dart';
import 'package:mathgptpro_mclient_flutter/view/welcome_module/signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController accountTextFieldController = TextEditingController();
  TextEditingController passwordTextFieldController = TextEditingController();

  final UserService userService = UserService();

  bool isPasswordVisible = false;
  bool loginLoading = false;
  bool loginAuthWrong = false;
  bool accountTextFieldVerify = true;
  bool passwordTextFieldVerify = true;

  /// 登录
  onLogin() async {
    setState(() {
      loginLoading = true;
    });

    String account = accountTextFieldController.text;
    String password = passwordTextFieldController.text;

    if (account.isEmpty || password.isEmpty) {
      ToastUtils.showSystemToast("请输入账号和密码".tr);
      setState(() {
        accountTextFieldVerify = false;
        passwordTextFieldVerify = false;
        loginLoading = false;
      });
      return;
    }

    bool result = await userService.userLogin(account, password);
    if (result) {
      //初始化数据
      await InitApp().dataInit();
      //关闭Dialog
      Get.back();
      Get.offAll(() => const IntroductionPage1());
    } else {
      setState(() {
        accountTextFieldVerify = false;
        passwordTextFieldVerify = false;
        loginAuthWrong = true;
        loginLoading = false;
      });
    }
  }

  @override
  void dispose() {
    accountTextFieldController.dispose();
    passwordTextFieldController.dispose();
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
                      'Log In',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w600,
                        color: UiResource.primaryBlack,
                      ),
                    ),
                  ),
                  Container(
                    height: 40.w,
                    margin: EdgeInsets.only(top: 24.w),
                    padding: EdgeInsets.only(left: 8.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                            color: accountTextFieldVerify
                                ? UiResource.primaryGrey
                                : UiResource.primaryRed,
                            width: 1.w)),
                    child: Center(
                      child: TextField(
                        controller: accountTextFieldController,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "Email",
                          hintStyle: TextStyle(color: UiResource.primaryGrey),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                        ),
                        onChanged: (value) {
                          setState(() {
                            accountTextFieldVerify = true;
                            passwordTextFieldVerify = true;
                            loginAuthWrong = false;
                          });
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 40.w,
                    margin: EdgeInsets.only(top: 24.w),
                    padding: EdgeInsets.only(left: 8.w),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(6.r),
                        border: Border.all(
                            color: passwordTextFieldVerify
                                ? UiResource.primaryGrey
                                : UiResource.primaryRed,
                            width: 1.w)),
                    child: Center(
                      child: TextField(
                        controller: passwordTextFieldController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          isDense: true,
                          hintText: "Password",
                          hintStyle: TextStyle(color: UiResource.primaryGrey),
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: Icon(isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off),
                            onPressed: () => setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            }),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            accountTextFieldVerify = true;
                            passwordTextFieldVerify = true;
                            loginAuthWrong = false;
                          });
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      loginAuthWrong
                          ? Container(
                              margin: EdgeInsets.only(top: 16.w),
                              child: Text(
                                'Invalid Email Or Password. ',
                                style: TextStyle(
                                  color: UiResource.primaryRed,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            )
                          : Container(),
                      GestureDetector(
                        onTap: () {
                          Get.to(() =>
                              WebViewPage(url: MainUrl.userForgotPassword));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 16.w),
                          child: Text(
                            'Forget password?',
                            style: TextStyle(
                              color: UiResource.primaryBlue,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: onLogin,
                    child: Container(
                      height: 40.w,
                      margin: EdgeInsets.only(top: 24.w),
                      decoration: ShapeDecoration(
                        color: UiResource.primaryBlue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100.r),
                        ),
                      ),
                      child: Center(
                        child: loginLoading
                            ? SizedBox(
                                height: 18.w,
                                width: 18.w,
                                child: const CircularProgressIndicator(
                                  color: Colors.white,
                                ),
                              )
                            : Container(
                                padding: EdgeInsets.symmetric(vertical: 10.w),
                                child: const Text(
                                  'Log in',
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
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 23.w),
                    child: Row(
                      children: [
                        Container(
                          width: 96.w,
                          height: 1.w,
                          color: UiResource.primaryGrey,
                        ),
                        const Spacer(),
                        Text(
                          'Or continue with',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: UiResource.primaryBlack,
                          ),
                        ),
                        const Spacer(),
                        Container(
                          height: 1.w,
                          width: 96.w,
                          color: UiResource.primaryGrey,
                        ),
                      ],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const ProfileInfillPage());
                    },
                    child: Container(
                      height: 40.w,
                      margin: EdgeInsets.only(top: 16.w),
                      decoration: ShapeDecoration(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                              width: 1, color: UiResource.primaryGrey),
                          borderRadius: BorderRadius.circular(100),
                        ),
                      ),
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10.w),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image(
                                width: 18.w,
                                height: 18.w,
                                image: const AssetImage(
                                    "public/asset/icon/login_page_google_icon.png")),
                            Container(
                              margin: EdgeInsets.only(left: 8.w),
                              child: Text(
                                'Google',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: UiResource.primaryBlue,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 26.w),
                    child: Text.rich(
                      textAlign: TextAlign.center,
                      TextSpan(
                        children: [
                          TextSpan(
                            text: 'Don’t have an account? ',
                            style: TextStyle(
                              color: UiResource.primaryBlack,
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          WidgetSpan(
                              child: GestureDetector(
                            onTap: () {
                              //Get.to(() => WebViewPage(url: MainUrl.signup));
                              Get.to(() => const SignupPage());
                            },
                            child: Container(
                              transform: Matrix4.translationValues(0, 1.5, 0),
                              child: Text(
                                'Sign up',
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
