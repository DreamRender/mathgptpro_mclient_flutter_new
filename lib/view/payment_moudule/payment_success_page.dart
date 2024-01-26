import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/view/home_module/home_page.dart';

class PaymentSuccessPage extends StatelessWidget {
  const PaymentSuccessPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Stack(
          children: [
            Container(
              width: Get.width,
              margin: EdgeInsets.only(top: 158.w),
              child: Column(
                children: [
                  Image(
                      width: 120.w,
                      height: 120.w,
                      image: const AssetImage(
                          "public/asset/icon/payment_success_page_success_icon.png")),
                  SizedBox(
                    height: 46.w,
                  ),
                  const Text(
                    'Congratulations! ',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    height: 24.w,
                  ),
                  const Text(
                    "You've now unlocked all the membership benefits! You can expect an email soon with details regarding this payment.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Color(0xFF333333),
                    ),
                  ),
                  Container(
                    width: Get.width,
                    height: 40.w,
                    margin: EdgeInsets.only(top: 24.w),
                    decoration: ShapeDecoration(
                      color: const Color(0x33999999),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'Transaction number: 12345667',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF333333),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Positioned(
                left: 0,
                bottom: 20.w,
                child: GestureDetector(
                  onTap: () {
                    Get.offAll(() => const HomePage());
                  },
                  child: Container(
                    height: 40.w,
                    width: 327.w,
                    margin: EdgeInsets.only(top: 30.w),
                    decoration: ShapeDecoration(
                      color: UiResource.primaryBlue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(100.r),
                      ),
                    ),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10.w),
                      child: const Text(
                        'Back to home',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
