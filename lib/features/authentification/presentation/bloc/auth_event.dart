import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class SendOtpEvent extends AuthEvent {
  final String phone;
  final int? telegramId;
  final bool isLogin;

  const SendOtpEvent({
    required this.phone,
    this.telegramId,
    this.isLogin = false,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [phone, telegramId, isLogin];
}

class VerifyOtpEvent extends AuthEvent {
  final String phone;
  final String code;
  final String? name;
  final String? role;

  const VerifyOtpEvent({
    required this.phone,
    required this.code,
    this.name,
    this.role,
  });

  @override
  List<Object?> get props => [phone, code, name, role];
}

class RefreshTokenEvent extends AuthEvent {}

class CheckAuthStatusEvent extends AuthEvent {}
