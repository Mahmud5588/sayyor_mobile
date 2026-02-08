import '../../domain/entities/refresh_token_entity.dart';

class RefreshTokenModel extends RefreshTokenEntity {
  const RefreshTokenModel({
    required super.accessToken,
    required super.refreshToken,
  });

  factory RefreshTokenModel.fromJson(Map<String, dynamic> json) {
    return RefreshTokenModel(
      accessToken: json['access_token'] ?? '',
      refreshToken: json['refresh_token'] ?? '',
    );
  }
}