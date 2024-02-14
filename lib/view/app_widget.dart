import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:mathgptpro_mclient_flutter/cache/system_cache.dart';
import 'package:mathgptpro_mclient_flutter/cache/user_cache.dart';
import 'package:mathgptpro_mclient_flutter/constant/ui_resource.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/main_translation.dart';
import 'package:mathgptpro_mclient_flutter/view/home_module/home_page.dart';
import 'package:mathgptpro_mclient_flutter/view/systen_module/app_version_update_page.dart';
import 'package:mathgptpro_mclient_flutter/view/systen_module/newtork_check_page.dart';
import 'package:mathgptpro_mclient_flutter/view/welcome_module/welcome_page.dart';

Widget getReturnPage() {
  if (globalSystemCache.currentVersionAvailable == false) {
    return const AppVersionUpdatePage();
  } else if (globalSystemCache.networkCheck == false) {
    return const NetworkCheckPage();
  } else {
    if (globalUserCache.login) {
      return const HomePage();
    } else {
      return const WelcomePage();
    }
  }
}

class AppWidget extends StatefulWidget {
  const AppWidget({super.key});

  @override
  State<AppWidget> createState() => _AppWidgetState();
}

class _AppWidgetState extends State<AppWidget> {
  @override
  Widget build(BuildContext context) {
    Widget page = getReturnPage();

    return GetMaterialApp(
      //title很重要，华为应用商店上架会检查
      //“您的应用存在（修改/隐藏最近任务列表名称）的行为”
      title: "MathGPTPro",
      locale: Get.deviceLocale,
      translations: MainTranslation(),
      theme: UiResource.lightModeThemeData,
      darkTheme: UiResource.lightModeThemeData,
      supportedLocales: const <Locale>[
        Locale('zh'),
        Locale('en'),
      ],
      home: ScreenUtilInit(
        designSize: const Size(375, 812),
        builder: (_, child) => page,
      ),
      localizationsDelegates: const <LocalizationsDelegate<dynamic>>[
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
