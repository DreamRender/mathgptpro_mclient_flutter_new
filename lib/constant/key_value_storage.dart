///键值对存储器的Key
class KeyValueStorageResource {
  ///用于标记版本
  ///可用于要求用户强制重新登录
  static String timeVersion = "1633322420";

  ///用户Jwt
  static String jwt = "jwt$timeVersion";

  ///用户jwtExpireTime
  static String jwtExpireTime = "jwtExpireTime$timeVersion";

  ///用户的AccessKey
  static String accessKey = "accessKey$timeVersion";

  ///用户姓氏
  static String userLastName = "userLastName$timeVersion";

  ///Pro使用量
  static String trialCount = "trialCount$timeVersion";

  ///用户名字
  static String userFirstName = "userFirstName$timeVersion";

  ///用户是否已订阅
  static String subActived = "subActived$timeVersion";

  ///用户的订阅状态关键字
  static String subStatus = "subStatus$timeVersion";

  ///用户的UserId（String类型）
  static String userId = "userId$timeVersion";

  ///权限被拒绝的次数Key（int类型）
  static String requestPermissionDeniedCountKey =
      "requestPermissionDeniedCount$timeVersion";

  ///App许可协议是否同意（bool类型）
  static String appUsageAgree = "appUsageAgree$timeVersion";
}
