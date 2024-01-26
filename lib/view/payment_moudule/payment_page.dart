import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/view/payment_moudule/payment_success_page.dart';

class PaymentPage extends StatefulWidget {
  const PaymentPage({super.key});

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: ScreenUtil().statusBarHeight,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              height: 48.w,
              padding: EdgeInsets.symmetric(vertical: 8.w, horizontal: 24.w),
              child: InkWell(
                onTap: () {
                  Get.back();
                },
                child: Icon(
                  Icons.keyboard_arrow_left,
                  color: UiResource.primaryBlack,
                  size: 36,
                ),
              ),
            ),
          ),
          Expanded(
              child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            children: [
              Image(
                  width: 165.w,
                  height: 197..w,
                  image: const AssetImage(
                      "public/asset/icon/payment_page_icon.png")),
              SizedBox(
                height: 28.w,
              ),
              const Text(
                'Total',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 12.w,
              ),
              const Text(
                '\$71.88 / year',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                height: 24.w,
              ),
              const Text(
                'I have a coupon',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF2B95EB),
                ),
              ),
              GestureDetector(
                onTap: () {
                  Get.to(PaymentSuccessPage());
                },
                child: Container(
                  height: 40.w,
                  width: Get.width,
                  margin: EdgeInsets.only(top: 24.w),
                  decoration: ShapeDecoration(
                    color: UiResource.primaryBlack,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                          width: 15.w,
                          height: 18.w,
                          image:
                              const AssetImage("public/asset/icon/apple.png")),
                      const SizedBox(width: 8),
                      const Text(
                        'Apple Pay',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 24.w,
              ),
              Text(
                'Or pay with credit card',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Color(0xFF666666),
                ),
              )
            ],
          ))
        ],
      ),
    );
  }
}
