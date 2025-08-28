import 'package:equatable/equatable.dart';
import 'package:jobbiez/data/models/job.dart';

class JobResponse extends Equatable{
  final String message;
  final List<Job> data;

  const JobResponse({required this.message, required this.data});

  factory JobResponse.fromJson(Map<String, dynamic> json) {
    return JobResponse(
      message: json["message"],
      data: (json["data"] as List).map((e) => Job.fromJson(e)).toList(),
    );
  }

  @override
  List<Object?> get props => [message, data];
}
