import 'package:sayyor/features/authentification/domain/entities/auth_entity.dart';
import 'package:sayyor/features/authentification/domain/entities/refresh_token_entity.dart';
import 'package:sayyor/features/authentification/domain/entities/send_otp_entity.dart';

abstract class AuthRepository {
  Future<SendOtpEntity> sendOtp({
    required String phone,
    int? telegramId,
    bool isLogin = false,
  });

  Future<RefreshTokenEntity> refreshToken({required String refreshToken});

  Future<AuthEntity> verifyOtp({
    required String phone,
    required String code,
    String? name,
    String? role,
  });
}
