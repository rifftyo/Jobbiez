import 'dart:convert';
import 'dart:io';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:jobbiez/common/exception.dart';
import 'package:jobbiez/data/models/application_response.dart';
import 'package:jobbiez/data/models/message.dart';
import 'package:jobbiez/data/models/auth_response.dart';
import 'package:http/http.dart' as http;
import 'package:jobbiez/data/models/category_response.dart';
import 'package:jobbiez/data/models/detail_response.dart';
import 'package:jobbiez/data/models/job_response.dart';
import 'package:jobbiez/data/models/user_response.dart';

abstract class RemoteDataSource {
  Future<AuthResponse> login(String email, String password);
  Future<AuthResponse> register(
    String username,
    String email,
    String noHp,
    String password,
  );
  Future<UserResponse> getProfile();
  Future<JobResponse> getTopJobs();
  Future<JobResponse> getLastJobs(String type);
  Future<JobResponse> getSearchJob(
    String? jobTitle,
    String? jobCategory,
    String? jobType,
  );
  Future<CategoryResponse> getCategories();
  Future<DetailResponse> getJobDetail(String id);
  Future<MessageResponse> addReview(String jobId, int rating, String review);
  Future<MessageResponse> postApplyJob(
    String jobId,
    String firstname,
    String lastname,
    String email,
    String phone,
    String country,
    String expectedSalary,
    String shortMessage,
    File cvFile,
  );
  Future<ApplicationsResponse> getApplications();
  Future<MessageResponse> updateProfile(String? username, File? fotoProfile);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  // ignore: constant_identifier_names
  static const BASE_URL = 'https://jobbiez.up.railway.app/api';
  static const tokenKey = 'access_token';

  final http.Client client;
  final FlutterSecureStorage storage;

  RemoteDataSourceImpl({required this.client, required this.storage});

  Future<Map<String, String>> _getHeaders({bool withAuth = false}) async {
    final headers = {'Content-Type': 'application/json'};
    if (withAuth) {
      final token = await storage.read(key: 'access_token');
      if (token != null) {
        headers['Authorization'] = 'Bearer $token';
      }
    }
    return headers;
  }

  Future<Map<String, dynamic>> _handleResponse(http.Response response) async {
    final jsonMap = jsonDecode(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonMap;
    } else {
      final errorMessage = jsonMap['message'] ?? 'Unknown Error';
      throw ServerException(errorMessage);
    }
  }

  @override
  Future<AuthResponse> login(String email, String password) async {
    final response = await client.post(
      Uri.parse('$BASE_URL/auth/login'),
      headers: await _getHeaders(),
      body: jsonEncode({'email': email, 'password': password}),
    );
    final jsonMap = await _handleResponse(response);
    return AuthResponse.fromJson(jsonMap);
  }

  @override
  Future<AuthResponse> register(
    String username,
    String email,
    String noHp,
    String password,
  ) async {
    final response = await client.post(
      Uri.parse('$BASE_URL/auth/register'),
      headers: await _getHeaders(),
      body: jsonEncode({
        'username': username,
        'email': email,
        'no_telepon': noHp,
        'password': password,
      }),
    );
    final jsonMap = await _handleResponse(response);
    return AuthResponse.fromJson(jsonMap);
  }

  @override
  Future<UserResponse> getProfile() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/user/profile'),
      headers: await _getHeaders(withAuth: true),
    );
    final jsonMap = await _handleResponse(response);
    return UserResponse.fromJson(jsonMap);
  }

  @override
  Future<JobResponse> getTopJobs() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/jobs/top-jobs'),
      headers: await _getHeaders(withAuth: true),
    );
    final jsonMap = await _handleResponse(response);
    return JobResponse.fromJson(jsonMap);
  }

  @override
  Future<JobResponse> getLastJobs(String type) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/jobs/last-jobs?type=$type'),
      headers: await _getHeaders(withAuth: true),
    );
    final jsonMap = await _handleResponse(response);
    return JobResponse.fromJson(jsonMap);
  }

  @override
  Future<JobResponse> getSearchJob(
    String? jobTitle,
    String? jobCategory,
    String? jobType,
  ) async {
    final response = await client.get(
      Uri.parse(
        '$BASE_URL/jobs/search-jobs?title=$jobTitle&job_category=$jobCategory&job_type=$jobType',
      ),
      headers: await _getHeaders(withAuth: true),
    );
    final jsonMap = await _handleResponse(response);
    return JobResponse.fromJson(jsonMap);
  }

  @override
  Future<CategoryResponse> getCategories() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/jobs/categories'),
      headers: await _getHeaders(withAuth: true),
    );
    final jsonMap = await _handleResponse(response);
    return CategoryResponse.fromJson(jsonMap);
  }

  @override
  Future<DetailResponse> getJobDetail(String id) async {
    final response = await client.get(
      Uri.parse('$BASE_URL/jobs/$id'),
      headers: await _getHeaders(withAuth: true),
    );
    final jsonMap = await _handleResponse(response);
    return DetailResponse.fromJson(jsonMap);
  }

  @override
  Future<MessageResponse> addReview(
    String jobId,
    int rating,
    String review,
  ) async {
    final response = await client.post(
      Uri.parse('$BASE_URL/jobs/reviews'),
      headers: await _getHeaders(withAuth: true),
      body: jsonEncode({'job_id': jobId, 'rating': rating, 'review': review}),
    );
    final jsonMap = await _handleResponse(response);
    return MessageResponse.fromJson(jsonMap);
  }

  @override
  Future<MessageResponse> postApplyJob(
    String jobId,
    String firstname,
    String lastname,
    String email,
    String phone,
    String country,
    String expectedSalary,
    String shortMessage,
    File cvFile,
  ) async {
    final uri = Uri.parse('$BASE_URL/jobs/$jobId/apply');

    var request = http.MultipartRequest('POST', uri);

    final headers = await _getHeaders(withAuth: true);
    request.headers.addAll(headers);

    request.fields.addAll({
      'firstname': firstname,
      'lastname': lastname,
      'email': email,
      'phone': phone,
      'country': country,
      'expectedsalary': expectedSalary,
      'short_message': shortMessage,
    });

    request.files.add(
      await http.MultipartFile.fromPath(
        'cv',
        cvFile.path,
        filename: cvFile.path.split('/').last,
      ),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    final jsonMap = await _handleResponse(response);
    return MessageResponse.fromJson(jsonMap);
  }

  @override
  Future<ApplicationsResponse> getApplications() async {
    final response = await client.get(
      Uri.parse('$BASE_URL/jobs/myapplications'),
      headers: await _getHeaders(withAuth: true),
    );
    final jsonMap = await _handleResponse(response);
    return ApplicationsResponse.fromJson(jsonMap);
  }

  @override
  Future<MessageResponse> updateProfile(
    String? username,
    File? fotoProfile,
  ) async {
    final uri = Uri.parse('$BASE_URL/user/profile');

    var request = http.MultipartRequest('PUT', uri);

    final headers = await _getHeaders(withAuth: true);
    request.headers.addAll(headers);

    if (username != null && username.isNotEmpty) {
      request.fields['username'] = username;
    }

    if (fotoProfile != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'fotoprofile',
          fotoProfile.path,
          filename: fotoProfile.path.split('/').last,
        ),
      );
    }

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    final jsonMap = await _handleResponse(response);
    return MessageResponse.fromJson(jsonMap);
  }
}
