import 'package:equatable/equatable.dart';

class CategoryResponse extends Equatable {
  final String message;
  final List<String> data;

  const CategoryResponse({required this.message, required this.data});

  factory CategoryResponse.fromJson(Map<String, dynamic> json) {
    return CategoryResponse(
      message: json["message"],
      data: (json["data"] as List).map((e) => e.toString()).toList(),
    );
  }

  @override
  List<Object?> get props => [message, data];
}
