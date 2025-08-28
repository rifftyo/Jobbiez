import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String noTelepon;
  final String? fotoProfile;

  const User({
    required this.id,
    required this.username,
    required this.email,
    required this.noTelepon,
    required this.fotoProfile,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"],
      username: json["username"],
      email: json["email"],
      noTelepon: json["no_telepon"],
      fotoProfile: json["foto_profile"],
    );
  }

  @override
  List<Object?> get props => [id, username, email, noTelepon, fotoProfile];
}
