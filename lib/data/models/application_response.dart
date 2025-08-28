import 'package:equatable/equatable.dart';

class ApplicationsResponse extends Equatable {
  final String message;
  final List<Applications> data;

  const ApplicationsResponse({required this.message, required this.data});

  factory ApplicationsResponse.fromJson(Map<String, dynamic> json) {
    return ApplicationsResponse(
      message: json["message"],
      data:
          (json["data"] as List).map((e) => Applications.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [message, data];
}

class Applications extends Equatable {
  final String jobId;
  final String jobTitle;
  final String companyName;
  final String companyImage;
  final String status;

  const Applications({
    required this.jobId,
    required this.jobTitle,
    required this.companyName,
    required this.companyImage,
    required this.status,
  });

  factory Applications.fromJson(Map<String, dynamic> json) {
    return Applications(
      jobId: json["job_id"],
      jobTitle: json["job_title"],
      companyName: json["company_name"],
      companyImage: json["company_image"],
      status: json["status"],
    );
  }

  @override
  List<Object?> get props => [
    jobId,
    jobTitle,
    companyName,
    companyImage,
    status,
  ];
}
