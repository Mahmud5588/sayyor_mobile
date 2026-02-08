import '../../domain/entities/auth_entity.dart';
import 'user_model.dart';

class AuthModel extends AuthEntity {
  const AuthModel({
    required super.success,
    required super.message,
    required super.accessToken,
    required super.refreshToken,
    super.user,
  });

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      // Backendda ba'zan 'token', ba'zan 'access_token' kelishi mumkin
      accessToken: json['token'] ?? json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
      user: json['user'] != null ? UserModel.fromJson(json['user']) : null,
    );
  }
}