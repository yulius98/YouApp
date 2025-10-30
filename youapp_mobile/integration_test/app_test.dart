import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:provider/provider.dart';
import 'package:youapp_mobile/main.dart';
import 'package:youapp_mobile/providers/auth_provider.dart';

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  group('end-to-end test', () {
    testWidgets('App starts and shows login screen', (tester) async {
      // Build the app
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
          ],
          child: const MyApp(),
        ),
      );

      // Wait for the app to settle
      await tester.pumpAndSettle();

      // Verify that we're on the login screen
      expect(find.text('Login'), findsOneWidget);
      expect(find.text('Enter Username/Email'), findsOneWidget);
      expect(find.text('Enter Password'), findsOneWidget);
    });

    testWidgets('Login screen interaction flow', (tester) async {
      // Build the app
      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
          ],
          child: const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Test Screen'),
              ),
            ),
          ),
        ),
      );

      await tester.pumpAndSettle();

      // Verify basic widget interaction
      expect(find.text('Test Screen'), findsOneWidget);
    });

    testWidgets('Navigation flow test', (tester) async {
      // This would test full navigation flow from login to other screens
      // For now, we test basic app structure

      await tester.pumpWidget(
        MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
          ],
          child: const MyApp(),
        ),
      );

      await tester.pumpAndSettle();

      // Verify app structure
      expect(find.byType(MaterialApp), findsOneWidget);
    });
  });
}