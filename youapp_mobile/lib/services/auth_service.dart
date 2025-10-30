import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/register.dart';
import '../constants/app_constants.dart';

/// Service for handling authentication-related API calls
class AuthService {
  static const String _baseUrl = AppApi.baseUrl;

  /// Registers a new user
  Future<http.Response> register(RegisterRequest request) async {
    try {
      final url = Uri.parse('$_baseUrl${AppApi.register}');
      final response = await http.post(
        url,
        headers: {'Content-Type': AppApi.contentTypeJson},
        body: jsonEncode(request.toJson()),
      );
      return response;
    } catch (e) {
      throw Exception('${AppStrings.networkError}: $e');
    }
  }
}
