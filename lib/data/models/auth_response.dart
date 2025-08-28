import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  final String message;
  final String accessKey;

  const AuthResponse({required this.message, required this.accessKey});

  factory AuthResponse.fromJson(Map<String, dynamic> json) =>
      AuthResponse(message: json["message"], accessKey: json["accessKey"]);

  @override
  List<Object?> get props => [message, accessKey];
}
