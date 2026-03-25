import 'package:dio/dio.dart';
import 'package:sayyor/core/networks/dio_client.dart';
import 'package:sayyor/core/utils/constants.dart';
import 'package:sayyor/features/authentification/data/model/auth_model.dart';
import 'package:sayyor/features/authentification/data/model/refresh_token_model.dart';
import 'package:sayyor/features/authentification/data/model/send_otp_model.dart';

import '../../../../core/errors/exception.dart';

abstract class AuthRemoteDatasource {
  Future<AuthModel> verifyOtp({
    required String phone,
    required String code,
    String? name,
    String? role,
  });

  Future<RefreshTokenModel> refreshToken({required String refreshToken});

  Future<SendOtpModel> sendOtp({
    required String phone,
    int? telegramId,
    bool isLogin = false,
  });
}

class AuthRemoteDatasourceImpl implements AuthRemoteDatasource {
  final DioClient dio;
  AuthRemoteDatasourceImpl({required this.dio});

  @override
  Future<RefreshTokenModel> refreshToken({required String refreshToken}) async {
    try {
      final response = await dio.post(
        AppUrls.refresh,
        data: {"refresh_token": refreshToken},
      );
      if (response.statusCode == 200) {
        return RefreshTokenModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException(
        message: e.response?.data["detail"] ?? "Sessiya tugadi",
      );
    }
  }

  @override
  Future<SendOtpModel> sendOtp({
    required String phone,
    int? telegramId,
    bool isLogin = false,
  }) async {
    try {
      final response = await dio.post(
        AppUrls.sendOTP,
        data: {"phone": phone, "is_login": isLogin},
        queryParameters: telegramId != null
            ? {'telegram_id': telegramId}
            : null,
      );
      if (response.statusCode == 200) {
        return SendOtpModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException(
        message: e.response?.data['detail'] ?? "Server xatosi",
      );
    } catch (e) {
      throw ServerException();
    }
  }

  @override
  Future<AuthModel> verifyOtp({
    required String phone,
    required String code,
    String? name,
    String? role,
  }) async {
    try {
      final Map<String, dynamic> body = {'phone': phone, 'code': code};
      if (name != null) body['name'] = name;
      if (role != null) body['role'] = role;

      final response = await dio.post(AppUrls.verifyOTP, data: body);

      if (response.statusCode == 200) {
        return AuthModel.fromJson(response.data);
      } else {
        throw ServerException();
      }
    } on DioError catch (e) {
      throw ServerException(
        message: e.response?.data['detail'] ?? "Kod noto'g'ri yoki eskirgan",
      );
    }
  }
}
