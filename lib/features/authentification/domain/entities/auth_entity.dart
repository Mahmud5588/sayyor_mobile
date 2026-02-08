import 'package:equatable/equatable.dart';
import 'user_entity.dart';

class AuthEntity extends Equatable {
  final bool success;
  final String message;
  final String accessToken;
  final String refreshToken;
  final UserEntity? user;

  const AuthEntity({
    required this.success,
    required this.message,
    required this.accessToken,
    required this.refreshToken,
    this.user,
  });

  @override
  List<Object?> get props => [success, message, accessToken, refreshToken, user];
}