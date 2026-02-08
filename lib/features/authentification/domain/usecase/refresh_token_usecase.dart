import 'package:sayyor/features/authentification/domain/entities/refresh_token_entity.dart';
import 'package:sayyor/features/authentification/domain/repository/auth_repository.dart';

class RefreshTokenUseCase {
  AuthRepository authRepository;

  RefreshTokenUseCase({required this.authRepository});

  Future<RefreshTokenEntity> call({required String refreshToken})async{
    return await authRepository.refreshToken(refreshToken: refreshToken);
  }
}