import 'package:equatable/equatable.dart';

class SendOtpEntity extends Equatable {
  final bool success;
  final String message;
  final String? via;

  const SendOtpEntity({
    required this.success,
    required this.message,
    this.via,
  });

  @override
  List<Object?> get props => [success, message, via];
}