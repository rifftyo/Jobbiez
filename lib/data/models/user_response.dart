import 'package:equatable/equatable.dart';
import 'package:jobbiez/data/models/user.dart';

class UserResponse extends Equatable {
  final String message;
  final User data;

  const UserResponse({required this.message, required this.data});

  factory UserResponse.fromJson(Map<String, dynamic> json) {
    return UserResponse(
      message: json["message"],
      data: User.fromJson(json["data"]),
    );
  }

  @override
  List<Object?> get props => [message, data];
}
