import 'package:equatable/equatable.dart';

class RefreshTokenEntity extends Equatable {
  final String accessToken;
  final String refreshToken;

  const RefreshTokenEntity({
    required this.accessToken,
    required this.refreshToken,
  });

  @override
  List<Object?> get props => [accessToken, refreshToken];
}