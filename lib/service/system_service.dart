import 'dart:convert';

import 'package:dio/dio.dart' as dio;
import 'package:mathgptpro_mclient_flutter/model/app_version_dto.dart';
import 'package:mathgptpro_mclient_flutter/constant/main_url.dart';
import 'package:mathgptpro_mclient_flutter/constant/app_info.dart';
import 'package:mathgptpro_mclient_flutter/utils/dio_utils.dart';

class SystemService {
  final DioUtils _dioUtils = DioUtils();

  /// 获取APP版本
  Future<bool> currentVersionAvailable() async {
    dio.Response response = (await _dioUtils.get(MainUrl.getAppVersion,
        paramMap: {"currentVersion": AppInfo.appVersion}));

    AppVersionDto appVersionDto =
        AppVersionDto.fromJson(json.decode(response.data));

    return appVersionDto.currentVersionAvailable ?? false;
  }
}
