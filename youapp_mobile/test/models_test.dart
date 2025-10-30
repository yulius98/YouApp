import 'package:flutter_test/flutter_test.dart';
import 'package:youapp_mobile/models/register.dart';
import 'package:youapp_mobile/models/profile.dart';

void main() {
  group('RegisterRequest', () {
    test('should create RegisterRequest with required fields', () {
      const request = RegisterRequest(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
      );

      expect(request.email, 'test@example.com');
      expect(request.username, 'testuser');
      expect(request.password, 'password123');
    });

    test('toJson should return correct map', () {
      const request = RegisterRequest(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
      );

      final json = request.toJson();

      expect(json, {
        'email': 'test@example.com',
        'username': 'testuser',
        'password': 'password123',
      });
    });

    test('copyWith should create new instance with updated fields', () {
      const request = RegisterRequest(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
      );

      final updated = request.copyWith(email: 'new@example.com');

      expect(updated.email, 'new@example.com');
      expect(updated.username, 'testuser');
      expect(updated.password, 'password123');
    });

    test('toString should hide password', () {
      const request = RegisterRequest(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
      );

      final string = request.toString();

      expect(string, 'RegisterRequest(email: test@example.com, username: testuser, password: [HIDDEN])');
    });

    test('equality should work correctly', () {
      const request1 = RegisterRequest(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
      );

      const request2 = RegisterRequest(
        email: 'test@example.com',
        username: 'testuser',
        password: 'password123',
      );

      const request3 = RegisterRequest(
        email: 'different@example.com',
        username: 'testuser',
        password: 'password123',
      );

      expect(request1 == request2, true);
      expect(request1 == request3, false);
    });
  });

  group('UserProfile', () {
    test('should create UserProfile with required fields', () {
      const profile = UserProfile(
        id: '1',
        username: 'testuser',
      );

      expect(profile.id, '1');
      expect(profile.username, 'testuser');
      expect(profile.name, null);
      expect(profile.email, null);
      expect(profile.about, null);
      expect(profile.interests, null);
    });

    test('fromJson should parse JSON correctly', () {
      final json = {
        'id': 1,
        'username': 'testuser',
        'name': 'Test User',
        'email': 'test@example.com',
        'about': 'About me',
        'interest': ['coding', 'reading'],
      };

      final profile = UserProfile.fromJson(json);

      expect(profile.id, '1');
      expect(profile.username, 'testuser');
      expect(profile.name, 'Test User');
      expect(profile.email, 'test@example.com');
      expect(profile.about, 'About me');
      expect(profile.interests, ['coding', 'reading']);
    });

    test('toJson should return correct map', () {
      const profile = UserProfile(
        id: '1',
        username: 'testuser',
        name: 'Test User',
        email: 'test@example.com',
        about: 'About me',
        interests: ['coding', 'reading'],
      );

      final json = profile.toJson();

      expect(json, {
        'id': '1',
        'username': 'testuser',
        'name': 'Test User',
        'email': 'test@example.com',
        'about': 'About me',
        'interest': ['coding', 'reading'],
      });
    });

    test('copyWith should create new instance with updated fields', () {
      const profile = UserProfile(
        id: '1',
        username: 'testuser',
        name: 'Test User',
      );

      final updated = profile.copyWith(name: 'Updated Name');

      expect(updated.id, '1');
      expect(updated.username, 'testuser');
      expect(updated.name, 'Updated Name');
    });

    test('equality should work correctly', () {
      const profile1 = UserProfile(
        id: '1',
        username: 'testuser',
        name: 'Test User',
      );

      const profile2 = UserProfile(
        id: '1',
        username: 'testuser',
        name: 'Test User',
      );

      const profile3 = UserProfile(
        id: '2',
        username: 'testuser',
        name: 'Test User',
      );

      expect(profile1 == profile2, true);
      expect(profile1 == profile3, false);
    });
  });
}