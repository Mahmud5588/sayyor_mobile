import 'package:dio/dio.dart';
import 'package:sayyor/core/storage/token_storage.dart';
import 'package:sayyor/core/utils/constants.dart';

class ErrorInterceptor extends Interceptor {
  final Dio dio;
  final TokenStorage tokenStorage;

  ErrorInterceptor(this.tokenStorage, this.dio);

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    if (err.response?.statusCode == 401) {
      final success = await _refreshToken();
      if (success) {
        print("✅ Token yangilandi! So'rov qayta yuborilmoqda...");
        final response = await _retry(err.requestOptions);
        return handler.resolve(response);
      } else {
        await tokenStorage.clear();
      }
    }
    return handler.next(err);
  }

  Future<bool> _refreshToken() async {
    final refreshToken = await tokenStorage.getRefreshToken();
    if (refreshToken == null) return false;

    try {
      final response = await dio.post(
        AppUrls.refresh,
        data: {"refresh_token": refreshToken},
      );
      if (response.statusCode == 200) {
        final newAccessToken = response.data["access_token"];
        final newRefreshToken = response.data["refresh_token"];

        await tokenStorage.saveToken(
          accessToken: newAccessToken,
          refreshToken: newRefreshToken,
        );
      }
      return true;
    } catch (e) {
      print("Token yangilashda xato: $e");
      return false;
    }
  }

  Future<Response<dynamic>> _retry(RequestOptions requestOptions) async {
    final newAccessToken = await tokenStorage.getAccessToken();
    final option = Options(
      method: requestOptions.method,
      headers: {
        ...requestOptions.headers,
        "Authorization": "Bearer $newAccessToken",
      },
    );
    return dio.request<dynamic>(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: option,
    );
  }
}
