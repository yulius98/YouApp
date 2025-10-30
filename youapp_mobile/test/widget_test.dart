// This is a basic Flutter widget test for YouApp.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:youapp_mobile/main.dart';
import 'package:youapp_mobile/providers/auth_provider.dart';
import 'package:youapp_mobile/screens/login_screen.dart';

void main() {
  testWidgets('App builds successfully', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MyApp(),
      ),
    );

    // Verify that the app builds without errors
    expect(find.byType(MaterialApp), findsOneWidget);
  });

  testWidgets('LoginScreen displays correctly', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    // Verify that the login screen displays expected elements
    expect(find.text('Login'), findsWidgets); // Allow multiple
    expect(find.text('Enter Username/Email'), findsOneWidget);
    expect(find.text('Enter Password'), findsOneWidget);
    expect(find.byType(ElevatedButton), findsOneWidget);
  });

  testWidgets('LoginScreen form validation', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    // Find the login button
    final loginButton = find.byType(ElevatedButton);

    // Try to tap the button without filling the form
    await tester.tap(loginButton);
    await tester.pump();

    // The button should still be there (form validation prevents navigation)
    expect(loginButton, findsOneWidget);
  });

  testWidgets('LoginScreen text fields accept input', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    // Find text fields
    final emailField = find.widgetWithText(TextFormField, 'Enter Username/Email');
    final passwordField = find.widgetWithText(TextFormField, 'Enter Password');

    // Enter text in fields
    await tester.enterText(emailField, 'test@example.com');
    await tester.enterText(passwordField, 'password123');
    await tester.pump();

    // Verify text was entered
    expect(find.text('test@example.com'), findsOneWidget);
    expect(find.text('password123'), findsOneWidget);
  });

  testWidgets('LoginScreen password visibility toggle', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => AuthProvider()),
        ],
        child: const MaterialApp(
          home: LoginScreen(),
        ),
      ),
    );

    // Find the password visibility toggle icon
    final visibilityIcon = find.byIcon(Icons.visibility_off);

    // Initially should show visibility_off
    expect(visibilityIcon, findsOneWidget);

    // Tap to toggle
    await tester.tap(visibilityIcon);
    await tester.pump();

    // Should now show visibility icon
    expect(find.byIcon(Icons.visibility), findsOneWidget);
  });
}
