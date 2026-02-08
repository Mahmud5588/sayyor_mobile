import 'package:sayyor/features/authentification/domain/entities/auth_entity.dart';
import 'package:sayyor/features/authentification/domain/repository/auth_repository.dart';

class VerifyOtpUseCase {
  AuthRepository authRepository;

  VerifyOtpUseCase({required this.authRepository});

  Future<AuthEntity> call({
    required String phone,
    required String code,
    String? name,
    String? role,
  }) async {
    return await authRepository.verifyOtp(
      phone: phone,
      code: code,
      name: name,
      role: role,
    );
  }
}
