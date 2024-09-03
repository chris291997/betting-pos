// Temporary class to handle errors from Dio
import 'package:dio/dio.dart';

class DioErrorParser {
  // General method to handle errors
  static String handleError(DioException error) {
    String errorDescription = "";
    if (error.response != null && error.response?.data != null) {
      // Assuming the error response is in JSON format
      final data = error.response?.data;
      if (data is Map<String, dynamic> && data.containsKey('message')) {
        errorDescription = data['message'];
      } else {
        errorDescription = "Unknown error occurred";
      }
    } else {
      errorDescription = error.message ?? "Unknown error occurred";
    }
    return errorDescription;
  }
}