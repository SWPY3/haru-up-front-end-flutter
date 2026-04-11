import 'package:dio/dio.dart';
import '../storage/secure_storage.dart';
import 'network_define.dart';

class ApiClient {
  ApiClient._();

  static final Dio _dio = _createDio();

  static Dio get dio => _dio;

  static Dio _createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: NetworkDefine.baseUrl,
        connectTimeout: NetworkDefine.connectTimeout,
        receiveTimeout: NetworkDefine.receiveTimeout,
        headers: {'Content-Type': 'application/json'},
      ),
    );

    dio.interceptors.add(_AuthInterceptor(dio));
    return dio;
  }
}

class _AuthInterceptor extends Interceptor {
  _AuthInterceptor(this._dio);

  final Dio _dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await SecureStorage.getAccessToken();
    if (token != null) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final refreshed = await _refreshToken();
      if (refreshed) {
        final token = await SecureStorage.getAccessToken();
        err.requestOptions.headers['Authorization'] = 'Bearer $token';
        final response = await _dio.fetch(err.requestOptions);
        handler.resolve(response);
        return;
      }
    }
    handler.next(err);
  }

  Future<bool> _refreshToken() async {
    final refreshToken = await SecureStorage.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final response = await _dio.post(
        NetworkDefine.refresh,
        data: {'refreshToken': refreshToken},
      );
      final newAccessToken = response.data['accessToken'] as String?;
      final newRefreshToken = response.data['refreshToken'] as String?;
      if (newAccessToken != null && newRefreshToken != null) {
        await SecureStorage.saveTokens(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );
        return true;
      }
    } catch (_) {}
    return false;
  }
}
