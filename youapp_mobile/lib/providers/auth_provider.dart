import 'package:flutter/material.dart';
import '../services/auth_service.dart';
import '../services/login_service.dart';
import '../models/register.dart';
import '../models/profile.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../constants/app_constants.dart';

/// Provider for authentication state management
class AuthProvider with ChangeNotifier {
  final AuthService _authService = AuthService();
  final LoginService _loginService = LoginService();
  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // State
  bool _isLoading = false;
  String? _errorMessage;
  UserProfile? _userProfile;
  bool _isAuthenticated = false;

  // Getters
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;
  UserProfile? get userProfile => _userProfile;
  bool get isAuthenticated => _isAuthenticated;

  /// Sets loading state and clears error
  void _setLoading(bool loading) {
    _isLoading = loading;
    if (loading) {
      _errorMessage = null;
    }
    notifyListeners();
  }

  /// Sets error message
  void _setError(String? error) {
    _errorMessage = error;
    notifyListeners();
  }

  /// Sets user profile and authentication state
  void _setUserProfile(UserProfile? profile) {
    _userProfile = profile;
    _isAuthenticated = profile != null;
    notifyListeners();
  }

  /// Attempts to login with provided credentials
  Future<bool> login({
    required String email,
    required String username,
    required String password,
  }) async {
    _setLoading(true);

    try {
      final result = await _loginService.login(
        email: email,
        username: username,
        password: password,
      );

      final token = result['access_token'];
      final message = result['message'];

      // Check for successful login
      if (token != null) {
        await _storage.write(key: AppStorageKeys.accessToken, value: token);

        // Store additional user data if available
        final email = result['email'];
        final username = result['username'];
        if (email != null || username != null) {
          await _storage.write(key: AppStorageKeys.userEmail, value: email ?? '');
          await _storage.write(key: AppStorageKeys.userUsername, value: username ?? '');
        }

        return true;
      }

      // Check for success message
      if (message != null && message.toLowerCase().contains('logged in successfully')) {
        // Store user data if available
        final email = result['email'];
        final username = result['username'];
        if (email != null || username != null) {
          await _storage.write(key: AppStorageKeys.userEmail, value: email ?? '');
          await _storage.write(key: AppStorageKeys.userUsername, value: username ?? '');
        }
        return true;
      }

      // No success indicators found
      if (message != null) {
        _setError(message);
      } else {
        _setError('Invalid response from server');
      }
      return false;
    } catch (e) {
      _setError(e.toString().replaceAll('Exception: ', ''));
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Attempts to register a new user
  Future<bool> register(RegisterRequest request) async {
    _setLoading(true);

    try {
      final response = await _authService.register(request);

      if (response.statusCode == 201 || response.statusCode == 200) {
        return true;
      } else {
        _setError('Registration failed: ${response.body}');
        return false;
      }
    } catch (e) {
      _setError('Registration error: $e');
      return false;
    } finally {
      _setLoading(false);
    }
  }

  /// Retrieves stored access token
  Future<String?> getToken() async {
    return await _storage.read(key: AppStorageKeys.accessToken);
  }

  /// Logs out user and clears stored data
  Future<void> logout() async {
    await _storage.delete(key: AppStorageKeys.accessToken);
    await _storage.delete(key: AppStorageKeys.userEmail);
    await _storage.delete(key: AppStorageKeys.userUsername);
    _setUserProfile(null);
    _setError(null);
  }

  /// Checks if user is authenticated by verifying token existence
  Future<bool> checkAuthentication() async {
    final token = await getToken();
    _isAuthenticated = token != null && token.isNotEmpty;
    notifyListeners();
    return _isAuthenticated;
  }
}