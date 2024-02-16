import 'dart:developer';

/// 日志记录工具
class LogUtils {
  /// 利用Sentry追踪的Error
  static void sendSentryTrackError({exception, stackTrace}) {
    log('----------出现错误----------');
    log(exception);
    log(stackTrace);
  }
}
