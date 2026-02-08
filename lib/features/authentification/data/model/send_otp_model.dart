import '../../domain/entities/send_otp_entity.dart';

class SendOtpModel extends SendOtpEntity {
  const SendOtpModel({
    required super.success,
    required super.message,
    super.via,
  });

  factory SendOtpModel.fromJson(Map<String, dynamic> json) {
    return SendOtpModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      via: json['via'],
    );
  }
}