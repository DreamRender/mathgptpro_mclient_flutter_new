import 'package:get/get.dart';

/// 主导航栏（BottomNavigationBar）页面
enum MainNavigationIndexEnum { home, profile }

/// 页面控制器
class NavigationIndexController extends GetxController {
  /// 默认的主NavigationBar显示
  static const MainNavigationIndexEnum _defaultCurrentMainNavigationIndex =
      MainNavigationIndexEnum.home;

  /// 主NavigationBar
  MainNavigationIndexEnum _currentMainNavigationIndex =
      _defaultCurrentMainNavigationIndex;

  /// 获取主NavigationBar
  MainNavigationIndexEnum get currentMainNavigationIndex {
    return _currentMainNavigationIndex;
  }

  set currentMainNavigationIndex(
      MainNavigationIndexEnum mainNavigationIndexEnum) {
    _currentMainNavigationIndex = mainNavigationIndexEnum;
    update();
  }

  /// 设置默认
  setDefault() {
    currentMainNavigationIndex = _defaultCurrentMainNavigationIndex;
  }
}
