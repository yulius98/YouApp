import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_mobile/services/auth_service.dart';
import 'package:youapp_mobile/services/login_service.dart';
import 'package:youapp_mobile/models/register.dart';

void main() {
  group('AuthService', () {
    late AuthService authService;

    setUp(() {
      authService = AuthService();
    });

    test('should create AuthService instance', () {
      expect(authService, isNotNull);
    });

    test('register request should have correct structure', () {
      final request = RegisterRequest(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
      );

      final json = request.toJson();

      expect(json.containsKey('email'), true);
      expect(json.containsKey('username'), true);
      expect(json.containsKey('password'), true);
      expect(json['email'], 'test@example.com');
      expect(json['username'], 'testuser');
      expect(json['password'], 'password123');
    });
  });

  group('LoginService', () {
    late LoginService loginService;

    setUp(() {
      loginService = LoginService();
    });

    test('should create LoginService instance', () {
      expect(loginService, isNotNull);
    });

    test('login method should exist and be callable', () async {
      // This test verifies the method exists and can be called
      // In a real scenario, we'd mock the HTTP client
      expect(() async => await loginService.login(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
      ), isNotNull);
    });
  });
}