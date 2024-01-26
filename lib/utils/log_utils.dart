import 'dart:developer';

import 'package:sentry_flutter/sentry_flutter.dart';

/// 日志记录工具
class LogUtils {
  /// 利用Sentry追踪的Error
  static void sendSentryTrackError({exception, stackTrace}) {
    log('----------出现错误----------');
    log(exception);
    log(stackTrace);
    //Sentry追踪（异步处理）
    Sentry.captureException(exception, stackTrace: stackTrace);
  }
}
