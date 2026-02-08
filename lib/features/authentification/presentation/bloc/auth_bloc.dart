import 'package:bloc/bloc.dart';
import 'package:sayyor/features/authentification/domain/usecase/refresh_token_usecase.dart';
import 'package:sayyor/features/authentification/domain/usecase/send_otp_usecase.dart';
import 'package:sayyor/features/authentification/domain/usecase/verify_otp_usecase.dart';
import 'package:sayyor/features/authentification/presentation/bloc/auth_event.dart';
import 'package:sayyor/features/authentification/presentation/bloc/auth_state.dart';

import '../../../../core/errors/exception.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RefreshTokenUseCase refreshTokenUseCase;

  final SendOtpUseCase sendOtpUseCase;
  final VerifyOtpUseCase verifyOtpUseCase;

  AuthBloc({
    required this.refreshTokenUseCase,
    required this.sendOtpUseCase,
    required this.verifyOtpUseCase,
  }) : super(AuthInitial()) {
    on<SendOtpEvent>(_onSendOtp);
    on<VerifyOtpEvent>(_onVerifyOtp);
  }

  Future<void> _onVerifyOtp(
    VerifyOtpEvent event,
    Emitter<AuthState> emit,
  ) async {
    try {
      emit(AuthLoading());
      final response = await verifyOtpUseCase(
        phone: event.phone,
        code: event.code,
        role: event.role,
        name: event.name,
      );
      if (response.success) {
        emit(AuthSuccess(response));
      } else {
        emit(AuthFailure(response.message));
      }
    } catch (e) {
      emit(AuthFailure(_mapFailureToMessage(e)));
    }
  }

  Future<void> _onSendOtp(SendOtpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      final result = await sendOtpUseCase(
        phone: event.phone,
        telegramId: event.telegramId,
        isLogin: event.isLogin,
      );
      if (result.success) {
        emit(AuthSendOtpSuccess(result));
      } else {
        emit(AuthFailure(result.message));
      }
    } catch (e) {
      emit(AuthFailure(_mapFailureToMessage(e)));
    }
  }

  String _mapFailureToMessage(Object error) {
    if (error is ServerException) {
      return error.message ?? "Server bilan bog'lanishda xatolik";
    }
    return "Noma'lum xatolik yuz berdi: $error";
  }
}
