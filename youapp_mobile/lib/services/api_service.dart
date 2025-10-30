import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constants/app_constants.dart';

/// Utility service for JWT and API operations
class ApiService {
  /// Decode JWT payload and return it as Map
  static Map<String, dynamic> _decodeJwtPayload(String token) {
    try {
      final parts = token.split('.');
      if (parts.length != 3) return {};

      var payload = parts[1];
      // Normalize base64
      payload = base64Url.normalize(payload);
      final decoded = utf8.decode(base64Url.decode(payload));
      final map = json.decode(decoded) as Map<String, dynamic>;
      return map;
    } catch (_) {
      return {};
    }
  }

  /// GET profile using token. If payload contains an id-like key, attach as query param.
  static Future<Map<String, dynamic>> getProfile(String token) async {
    final uri = Uri.parse('${AppApi.baseUrl}${AppApi.getProfile}');

    // try to extract an id from token payload and append as query parameter
    final payload = _decodeJwtPayload(token);
    String? id;
    for (final key in ['id', 'user_id', 'sub', 'uid']) {
      if (payload.containsKey(key)) {
        id = payload[key]?.toString();
        break;
      }
    }

    final uriWithId = (id != null && id.isNotEmpty)
        ? uri.replace(queryParameters: {'id': id})
        : uri;

    final resp = await http.get(
      uriWithId,
      headers: {
        'Accept': AppApi.contentTypeJson,
        AppApi.xAccessToken: token,
        'Content-Type': AppApi.contentTypeJson,
      },
    );

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      try {
        final body = json.decode(resp.body);
        if (body is Map<String, dynamic>) {
          if (body.containsKey('data') && body['data'] is Map<String, dynamic>) {
            return body['data'];
          } else {
            return body;
          }
        }
        return {};
      } catch (e) {
        return {};
      }
    }

    throw Exception('Failed to fetch profile: ${resp.statusCode} ${resp.reasonPhrase}');
  }

  /// PUT update profile using token
  static Future<Map<String, dynamic>> updateProfile(String token, Map<String, dynamic> profileData) async {
    final uri = Uri.parse('${AppApi.baseUrl}${AppApi.updateProfile}');

    final resp = await http.put(
      uri,
      headers: {
        'Accept': AppApi.contentTypeJson,
        AppApi.xAccessToken: token,
        'Content-Type': AppApi.contentTypeJson,
      },
      body: json.encode(profileData),
    );

    if (resp.statusCode >= 200 && resp.statusCode < 300) {
      try {
        final body = json.decode(resp.body);
        if (body is Map<String, dynamic>) {
          return body;
        }
        return {};
      } catch (e) {
        return {};
      }
    }

    throw Exception('Failed to update profile: ${resp.statusCode} ${resp.reasonPhrase}');
  }
}
