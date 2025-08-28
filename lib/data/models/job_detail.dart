import 'package:equatable/equatable.dart';
import 'package:jobbiez/data/models/review.dart';

class JobDetail extends Equatable {
  final String id;
  final String jobTitle;
  final String companyImage;
  final String jobLocation;
  final String jobOverview;
  final String aboutCompany;
  final Review reviews;

  const JobDetail({
    required this.id,
    required this.jobTitle,
    required this.companyImage,
    required this.jobLocation,
    required this.jobOverview,
    required this.aboutCompany,
    required this.reviews,
  });

  factory JobDetail.fromJson(Map<String, dynamic> json) {
    return JobDetail(
      id: json['id'],
      jobTitle: json['job_title'],
      companyImage: json['company_image'],
      jobLocation: json['job_location'],
      jobOverview: json['job_overview'],
      aboutCompany: json['about_company'],
      reviews: Review.fromJson(json['reviews']),
    );
  }

  @override
  List<Object?> get props => [
    id,
    jobTitle,
    companyImage,
    jobLocation,
    jobOverview,
    aboutCompany,
    reviews,
  ];
}
