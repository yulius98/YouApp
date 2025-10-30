import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';

/// Service for handling login-related API calls
class LoginService {
  static const String _baseUrl = AppApi.baseUrl;

  /// Authenticates user with email/username and password
  Future<Map<String, dynamic>> login({
    required String email,
    required String username,
    required String password,
  }) async {
    try {
      final url = Uri.parse('$_baseUrl${AppApi.login}');
      final Map<String, dynamic> data = {
        'email': email,
        'username': username,
        'password': password,
      };
      // Use correct header name for content type
      final response = await http.post(
        url,
        headers: {'Content-Type': AppApi.contentTypeJson},
        body: jsonEncode(data),
      ).timeout(const Duration(seconds: 10));

      // Try to decode a JSON response. If decoding fails, return a map
      // with the raw body under the 'message' key so callers can show
      // a helpful error instead of triggering a FormatException.
      if (response.statusCode >= 200 && response.statusCode < 300) {
        try {
          return jsonDecode(response.body) as Map<String, dynamic>;
        } catch (_) {
          if (kDebugMode) {
            // Helpful debug log when response isn't JSON
            // ignore: avoid_print
            print('[LoginService] Non-JSON success response: ${response.body}');
          }
          return {'message': response.body};
        }
      } else {
        try {
          final errorData = jsonDecode(response.body);
          throw Exception(errorData['message'] ?? 'Login failed');
        } catch (_) {
          if (kDebugMode) {
            // ignore: avoid_print
            print('[LoginService] Non-JSON error response (status ${response.statusCode}): ${response.body}');
          }
          // If the error body isn't valid JSON, include it in the exception
          throw Exception(response.body.isNotEmpty ? response.body : 'Login failed');
        }
      }
    } catch (e) {
      if (e is http.ClientException) {
        throw Exception(AppStrings.networkError);
      } else if (e is FormatException) {
        throw Exception(AppStrings.invalidResponse);
      } else {
        rethrow;
      }
    }
  }
}
