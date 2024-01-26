import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mathgptpro_mclient_flutter/cache/session_cache.dart';
import 'package:mathgptpro_mclient_flutter/cache/system_cache.dart';
import 'package:mathgptpro_mclient_flutter/cache/user_cache.dart';
import 'package:mathgptpro_mclient_flutter/constant/key_value_storage.dart';
import 'package:mathgptpro_mclient_flutter/service/session_service.dart';
import 'package:mathgptpro_mclient_flutter/service/system_service.dart';
import 'package:mathgptpro_mclient_flutter/service/user_service.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/content_manage_controller.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/navigation_index_controller.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/question_image_controller.dart';
import 'package:mathgptpro_mclient_flutter/state/controller/user_controller.dart';
import 'package:mathgptpro_mclient_flutter/utils/dio_utils.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

class InitApp {
  /// 框架初始化
  Future<void> frameworkInit() async {
    await GetStorage.init();
    //页面控制器
    Get.put(NavigationIndexController(), permanent: true);
    //图片剪切文件控制器
    Get.put(QuestionImageController(), permanent: true);
    //内容控制器
    Get.put(ContentManageController(), permanent: true);
    //用户数据控制器
    Get.put(UserController(), permanent: true);
  }

  /// 初始化UI
  Future<void> userInterfaceControlInit() async {
    //横竖屏设置
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
    // //设置和系统暗黑模式保持一致
    // ThemeUtils.setSystemBrightness();
    // //监听系统的暗黑模式变化
    // ThemeUtils.bindListeningToSystemBrightnessChange();

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        //默认导航栏是黑色的，现在改成白色
        systemNavigationBarColor: Colors.grey.shade50));
  }

  /// SDK初始化
  Future<void> sdkInit() async {
    SentryFlutter.init((options) {
      options.dsn =
          'https://354b96952db30731c3d4704e53fec55d@o984263.ingest.sentry.io/4505850842316800';
      //TODO Set tracesSampleRate to 1.0 to capture 100% of transactions for performance monitoring. We recommend adjusting this value in production.
      options.tracesSampleRate = 0.1;
    });
  }

  /// 系统级数据初始化
  Future<void> appDataInit() async {
    bool currentVersionAvailable =
        await SystemService().currentVersionAvailable();
    globalSystemCache.currentVersionAvailable = currentVersionAvailable;
  }

  /// 用户级数据初始化
  Future<void> userDataInit() async {
    //检查版本信息
    if (!globalSystemCache.currentVersionAvailable) {
      return;
    }

    bool login =
        GetStorage().read<String?>(KeyValueStorageResource.accessKey) != null;
    globalUserCache.login = login;

    if (!login) {
      return;
    }

    DioUtils dioUtils = DioUtils();
    String? token = await dioUtils.getUserTokenWithUpdateUserInfo();

    //如果获取不到Token就自动退出登录
    if (token == null) {
      UserService.logout();
      return;
    }

    SessionService sessionService = SessionService();

    globalSessionCache.sessionHistoryDtoList =
        await sessionService.getSessionAll();
  }
}
