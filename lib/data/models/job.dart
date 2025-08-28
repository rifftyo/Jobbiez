import 'package:equatable/equatable.dart';

class Job extends Equatable {
  final String id;
  final String jobTitle;
  final String companyName;
  final String companyImage;
  final String? jobCategory;
  final String jobType;
  final String jobLocation;
  final String jobSalary;

  const Job({
    required this.id,
    required this.jobTitle,
    required this.companyName,
    required this.companyImage,
    required this.jobCategory,
    required this.jobType,
    required this.jobLocation,
    required this.jobSalary,
  });

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      id: json["id"],
      jobTitle: json["job_title"],
      companyName: json["company_name"],
      companyImage: json["company_image"],
      jobCategory: json["job_category"],
      jobType: json["job_type"],
      jobLocation: json["job_location"],
      jobSalary: json["job_salary"],
    );
  }

  @override
  List<Object?> get props => [
    id,
    jobTitle,
    companyName,
    companyImage,
    jobCategory,
    jobType,
    jobLocation,
    jobSalary,
  ];
}
