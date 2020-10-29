class AppConfig {
  static const bool _IS_RELEASE = false; // false is demo, true is production
  static const String DOMAIN_API = _IS_RELEASE ? 'https://orimx.vnptit.vn/' : "https://orimx-demo.vnptit.vn/";
  static const String apiKeyVcm = "";
}