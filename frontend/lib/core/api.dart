import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String BASE_URL = "http://192.168.1.68:5000/api/";
const Map<String, dynamic> DEFAULT_HEADERS = {
  "Content-Type": "application/json",
};

class Api {
  final Dio _dio = Dio();
  Api() {
    _dio.options.baseUrl = BASE_URL;
    _dio.options.headers = DEFAULT_HEADERS;
    _dio.interceptors.add(PrettyDioLogger(
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
    ));
  }

  Dio get sendRequest => _dio;
}

class ApiResponse {
  bool success;
  dynamic data;
  String? message;
  dynamic error;

  ApiResponse({
    required this.success,
    this.data,
    this.message,
    this.error,
  });
  factory ApiResponse.fromResponse(Response response) {
    final data = response.data;
    return ApiResponse(
      success: data['success'],
      data: data["data"] ?? {"": {}},
      error: data["error"],
      message: data["message"] ?? "Unexpected error",
    );
  }
}
