import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/profile.dart';
import '../constants/app_constants.dart';

/// Service for handling profile-related API calls
class ProfileService {
  static const String _baseUrl = AppApi.baseUrl;
  final _storage = const FlutterSecureStorage();

  /// Fetches user profile from API
  Future<UserProfile> getProfile() async {
    final token = await _storage.read(key: AppStorageKeys.accessToken);
    if (token == null) throw Exception('No access token found');

    final payload = _parseJwt(token);
    final userId = payload['id'];
    if (userId == null) throw Exception('User ID not found in token');

    final url = Uri.parse('$_baseUrl${AppApi.getProfile}?id=$userId');
    final response = await http.get(
      url,
      headers: {
        AppApi.xAccessToken: token,
        'Content-Type': AppApi.contentTypeJson,
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return UserProfile.fromJson(data['data']);
    } else {
      throw Exception('Failed to load profile: ${response.statusCode}');
    }
  }

  /// Parses JWT token and returns payload
  Map<String, dynamic> _parseJwt(String token) {
    final parts = token.split('.');
    if (parts.length != 3) {
      throw Exception('Invalid token format');
    }

    final payload = _decodeBase64(parts[1]);
    final payloadMap = json.decode(payload);
    if (payloadMap is! Map<String, dynamic>) {
      throw Exception('Invalid payload');
    }
    return payloadMap;
  }

  /// Decodes base64 URL string
  String _decodeBase64(String str) {
    String output = str.replaceAll('-', '+').replaceAll('_', '/');
    switch (output.length % 4) {
      case 0:
        break;
      case 2:
        output += '==';
        break;
      case 3:
        output += '=';
        break;
      default:
        throw Exception('Illegal base64url string!');
    }
    return utf8.decode(base64Url.decode(output));
  }
}
