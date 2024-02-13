/// 记录所有的网络访问Url
class MainUrl {
  /// 用户协议
  static String appTermsOfService =
      "https://info.mathgptpro.com/terms-of-service";

  /// 隐私政策
  static String appPrivacyAgreement =
      "https://www.info.mathgptpro.com/privacy-policy";

  /// 用户注册
  static String signup = "https://mathgptpro.com/new";

  /// 用户登录
  static String login = "https://dev-be.mathgptpro.com/auth/login";

  /// 获取AccessKey
  static String getAccessKey = "https://dev-be.mathgptpro.com/user/access-key";

  /// 更新Token
  static String refreshToken = "https://dev-be.mathgptpro.com/token/refresh";

  /// 通过AccessKey获取Jwt
  static String accessKeyGetJwt =
      "https://dev-be.mathgptpro.com/auth/login/access-key";

  /// 更新用户信息
  static String userProfileUpdate = "https://dev-be.mathgptpro.com/user/update";

  /// 忘记密码
  static String userForgotPassword =
      "https://mathgptpro.com/account/forgot-password";

  /// Flask地址
  static String flask = 'https://dev-flask.mathgptpro.com';

  /// 历史记录
  static String sessionHistory = "https://dev-be.mathgptpro.com/session/all/en";

  /// 保存输出结果
  static String outputSave =
      "https://dev-be.mathgptpro.com/session/output/save";

  /// 保存输入结果
  static String inputSave = "https://dev-be.mathgptpro.com/session/input/save";

  /// 获得图片保存链接
  static String preSignedPutUrl =
      "https://dev-be.mathgptpro.com/s3/presigned-put-url";

  /// 保存反馈
  static String feedbackSave =
      "https://dev-be.mathgptpro.com/session/feedback/save";

  /// 对话详情
  static String sessionDetail =
      "https://dev-be.mathgptpro.com/session/detail/uuid/";

  /// 删除对话
  static String deleteSession =
      "https://dev-be.mathgptpro.com/session/delete/id/";

  /// 获取APP版本
  static String getAppVersion =
      "https://dev-be.mathgptpro.com/open-api/get-app-version";

  /// 获取账户余额信息
  static String getBalanceInfo = "https://dev-be.mathgptpro.com/balance/info";

  /// 更新Balance信息
  static String updateBalanceHistory =
      "https://dev-be.mathgptpro.com/history/update";

  /// 获取用户信息
  static String getUserInfo = "https://dev-be.mathgptpro.com/user/info";

  /// 获取Education List
  static String getEducationList =
      "https://dev-be.mathgptpro.com/constants/education-list";
}
