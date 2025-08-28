import 'package:equatable/equatable.dart';
import 'package:jobbiez/data/models/job_detail.dart';

class DetailResponse extends Equatable {
  final String message;
  final JobDetail jobDetail;

  const DetailResponse({required this.message, required this.jobDetail});

  factory DetailResponse.fromJson(Map<String, dynamic> json) => DetailResponse(
    message: json['message'],
    jobDetail: JobDetail.fromJson(json['data']),
  );

  @override
  List<Object?> get props => [message, jobDetail];
}
