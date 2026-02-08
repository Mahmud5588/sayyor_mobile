import 'package:equatable/equatable.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/entities/send_otp_entity.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSendOtpSuccess extends AuthState {
  final SendOtpEntity result;

  const AuthSendOtpSuccess(this.result);

  @override
  List<Object?> get props => [result];
}

class AuthSuccess extends AuthState {
  final AuthEntity authEntity;

  const AuthSuccess(this.authEntity);

  @override
  List<Object?> get props => [authEntity];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
