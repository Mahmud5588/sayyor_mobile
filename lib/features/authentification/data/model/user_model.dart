import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required super.id,
    required super.phone,
    super.name,
    required super.role,
    required super.rating,
    required super.verified,
    super.available,
    super.profilePhoto,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? 0,
      phone: json['phone'] ?? '',
      name: json['name'],
      role: json['role'] ?? 'client',
      // Backend Decimal yuborsa, double ga o'giramiz
      rating: (json['rating'] is int)
          ? (json['rating'] as int).toDouble()
          : (json['rating'] as double?) ?? 0.0,
      verified: json['verified'] ?? false,
      available: json['available'] ?? false,
      profilePhoto: json['profile_photo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "phone": phone,
      "name": name,
      "role": role,
      "rating": rating,
      "verified": verified,
      "available": available,
      "profile_photo": profilePhoto,
    };
  }
}