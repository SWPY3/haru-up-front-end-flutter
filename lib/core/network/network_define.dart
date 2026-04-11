class NetworkDefine {
  NetworkDefine._();

  static const String _debugBaseUrl = 'http://223.130.141.179:8082/';
  static const String _releaseBaseUrl = 'https://haru.jinuk.dev/';

  static String get baseUrl {
    const bool isRelease = bool.fromEnvironment('dart.vm.product');
    return isRelease ? _releaseBaseUrl : _debugBaseUrl;
  }

  static const Duration connectTimeout = Duration(seconds: 10);
  static const Duration receiveTimeout = Duration(seconds: 15);

  // Auth
  static const String login = 'api/v1/auth/login';
  static const String refresh = 'api/v1/auth/refresh';
  static const String logout = 'api/v1/auth/logout';

  // User
  static const String userProfile = 'api/v1/user/profile';
  static const String userOnboarding = 'api/v1/user/onboarding';
}
