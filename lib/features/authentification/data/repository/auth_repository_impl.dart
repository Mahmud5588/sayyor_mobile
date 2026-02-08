import 'package:sayyor/features/authentification/data/datasource/auth_remote_datasource.dart';
import 'package:sayyor/features/authentification/domain/entities/auth_entity.dart';
import 'package:sayyor/features/authentification/domain/entities/refresh_token_entity.dart';
import 'package:sayyor/features/authentification/domain/entities/send_otp_entity.dart';
import 'package:sayyor/features/authentification/domain/repository/auth_repository.dart';

import '../../../../core/storage/token_storage.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDatasourceImpl authRemoteDatasourceImpl;
  final TokenStorage tokenStorage;

  AuthRepositoryImpl({
    required this.authRemoteDatasourceImpl,
    required this.tokenStorage,
  });

  @override
  Future<RefreshTokenEntity> refreshToken({
    required String refreshToken,
  }) async {
    final result = await authRemoteDatasourceImpl.refreshToken(
      refreshToken: refreshToken,
    );

    await tokenStorage.saveToken(
      accessToken: result.accessToken,
      refreshToken: result.refreshToken,
    );

    return result;
  }

  @override
  Future<SendOtpEntity> sendOtp({
    required String phone,
    int? telegramId,
    bool isLogin = false,
  }) async {
    return await authRemoteDatasourceImpl.sendOtp(
      phone: phone,
      telegramId: telegramId,
      isLogin: isLogin,
    );
  }

  @override
  Future<AuthEntity> verifyOtp({
    required String phone,
    required String code,
    String? name,
    String? role,
  }) async {
    final result = await authRemoteDatasourceImpl.verifyOtp(
      phone: phone,
      code: code,
      name: name,
      role: role,
    );

    if (result.success) {
      await tokenStorage.saveToken(
        accessToken: result.accessToken,
        refreshToken: result.refreshToken,
      );
    }

    return result;
  }
}
