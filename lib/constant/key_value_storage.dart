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

  ///权限被拒绝的次数Key（int类型）
  static String requestPermissionDeniedCountKey =
      "requestPermissionDeniedCount$timeVersion";
}
