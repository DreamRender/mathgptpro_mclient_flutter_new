import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:mathgptpro_mclient_flutter/cache/system_cache.dart';
import 'package:mathgptpro_mclient_flutter/init_app.dart';
import 'package:mathgptpro_mclient_flutter/utils/dio_utils.dart';
import 'package:mathgptpro_mclient_flutter/view/app_widget.dart';

Future<void> main() async {
  // 确保所有的Widget都已经加载完成
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  // SplashScreen监听
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);

  // 初始化
  InitApp initApp = InitApp();
  await initApp.frameworkInit();
  await initApp.userInterfaceControlInit();
  await initApp.sdkInit();

  globalSystemCache.networkCheck = await DioUtils.checkNetwork();

  //注意修改NetworkCheckPage的内容
  if (globalSystemCache.networkCheck) {
    await initApp.dataInit();
  }

  runApp(const AppWidget());

  // 结束Splash屏
  // 需要放在runApp后面
  // 参考：https://stackoverflow.com/questions/74819481/flutter-splash-screen-got-a-black-screen-at-first-launch
  FlutterNativeSplash.remove();
}
