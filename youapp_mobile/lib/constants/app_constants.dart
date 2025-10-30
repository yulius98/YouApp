import 'package:flutter/material.dart';

/// Application-wide constants and theme definitions
class AppColors {
  // Primary colors
  static const Color primary = Color(0xFF0066FF);
  static const Color secondary = Color(0xFFFF6600);
  static const Color background = Color(0xFFF5F5F5);
  static const Color error = Color(0xFFB00020);
  static const Color white = Colors.white;
  static const Color black = Colors.black;

  // Login/Register screen colors
  static const Color loginBgStart = Color(0xFF183A4A);
  static const Color loginBgEnd = Color(0xFF1B2B36);
  static const Color inputBg = Color(0xFF223C44);
  static const Color textWhite = Colors.white;
  static const Color textWhite70 = Color(0xB2FFFFFF);
  static const Color accent = Color(0xFFEEDFA2);
  static const Color amberAccent = Color(0xFFE6C17A);

  // Profile screen colors
  static const Color profileBg = Color(0xFF101828);
  static const Color cardBg = Color(0xFF1A2233);
  static const Color textSecondary = Color(0xFF98A2B3);
}

class AppStrings {
  // App info
  static const String appTitle = 'YouApp';

  // Authentication
  static const String login = 'Login';
  static const String register = 'Register';
  static const String enterUsernameEmail = 'Enter Username/Email';
  static const String enterPassword = 'Enter Password';
  static const String createUsername = 'Create Username';
  static const String createPassword = 'Create Password';
  static const String confirmPassword = 'Confirm Password';
  static const String enterEmail = 'Enter Email';
  static const String noAccount = 'No account? ';
  static const String registerHere = 'Register here';
  static const String haveAccount = 'Have an account? ';
  static const String loginHere = 'Login here';
  static const String back = 'Back';
  static const String loggingIn = 'Logging in...';
  static const String registering = 'Registering...';

  // Profile
  static const String about = 'About';
  static const String interest = 'Interest';
  static const String addAboutPlaceholder = 'Add in your about to help others know you better';
  static const String addInterestPlaceholder = 'Add in your interest to find a better match';

  // Error messages
  static const String networkError = 'Network error: Please check your connection';
  static const String invalidResponse = 'Invalid response from server';
  static const String registrationSuccessful = 'Registration successful!';
  static const String retry = 'Retry';
  static const String backToLogin = 'Back to Login';
}

class AppDimensions {
  // Border radius
  static const double borderRadius = 12.0;

  // Button dimensions
  static const double buttonHeight = 60.0;

  // Input dimensions
  static const double inputHeight = 60.0;

  // Spacing
  static const double paddingHorizontal = 24.0;
  static const double paddingVertical = 32.0;
  static const double spacingSmall = 20.0;
  static const double spacingMedium = 32.0;
  static const double spacingLarge = 40.0;

  // Font sizes
  static const double fontSizeLarge = 36.0;
  static const double fontSizeMedium = 18.0;
  static const double fontSizeSmall = 14.0;
  static const double fontSizeExtraSmall = 12.0;
}

class AppApi {
  // Base URL
  static const String baseUrl = 'https://techtest.youapp.ai/api';

  // Endpoints
  static const String login = '/login';
  static const String register = '/register';
  static const String getProfile = '/getprofile';
  static const String updateProfile = '/updateProfile';

  // Headers
  static const String contentTypeJson = 'application/json';
  static const String authorizationBearer = 'Bearer';
  static const String xAccessToken = 'x-access-token';
}

class AppStorageKeys {
  static const String accessToken = 'access_token';
  static const String userEmail = 'user_email';
  static const String userUsername = 'user_username';
}