import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final int id;
  final String phone;
  final String? name;
  final String role;
  final double rating;
  final bool verified;
  final bool available;
  final String? profilePhoto;

  const UserEntity({
    required this.id,
    required this.phone,
    this.name,
    required this.role,
    required this.rating,
    required this.verified,
    this.available = false,
    this.profilePhoto,
  });

  @override
  List<Object?> get props => [
    id,
    phone,
    name,
    role,
    rating,
    verified,
    available,
    profilePhoto,
  ];
}