import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/cache/system_cache.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/init_app.dart';
import 'package:mathgptpro_mclient_flutter/utils/dio_utils.dart';
import 'package:mathgptpro_mclient_flutter/view/app_widget.dart';

class NetworkCheckPage extends StatefulWidget {
  const NetworkCheckPage({super.key});

  @override
  State<NetworkCheckPage> createState() => _NetworkCheckPageState();
}

class _NetworkCheckPageState extends State<NetworkCheckPage> {
  final InitApp initApp = InitApp();

  bool loading = false;

  handleNetworkChange() async {
    setState(() {
      loading = true;
    });

    globalSystemCache.networkCheck = await DioUtils.checkNetwork();

    if (globalSystemCache.networkCheck) {
      await initApp.dataInit();
    }

    Get.offAll(() => getReturnPage());

    setState(() {
      loading = false;
    });
  }

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
                    "public/asset/icon/network-disconnect.png"),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40.w),
              child: Text(
                'Whoops!\n Please check your network connection',
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
                "It seems there's a problem with the network connection. Please check if your cellular or WiFi is turned on.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: UiResource.primaryBlack,
                ),
              ),
            ),
            GestureDetector(
              onTap: handleNetworkChange,
              child: Container(
                height: 40.w,
                width: 303.w,
                margin: EdgeInsets.only(top: 32.w),
                decoration: ShapeDecoration(
                  color: UiResource.primaryBlue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(100.r),
                  ),
                ),
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 10.w),
                  child: loading
                      ? Center(
                          child: SizedBox(
                            height: 15.w,
                            width: 15.w,
                            child: const CircularProgressIndicator(
                                color: Colors.white),
                          ),
                        )
                      : const Text(
                          'Recheck',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
