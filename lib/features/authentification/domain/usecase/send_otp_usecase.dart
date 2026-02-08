import 'package:sayyor/features/authentification/domain/entities/send_otp_entity.dart';
import 'package:sayyor/features/authentification/domain/repository/auth_repository.dart';

class SendOtpUseCase {
  AuthRepository authRepository;

  SendOtpUseCase({required this.authRepository});

  Future<SendOtpEntity> call({
    required String phone,
    int? telegramId,
    bool isLogin = false,
  }) async {
    return await authRepository.sendOtp(
      phone: phone,
      telegramId: telegramId,
      isLogin: isLogin,
    );
  }
}
