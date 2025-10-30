import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/auth_provider.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
      ],
      child: MaterialApp(
        title: 'YouApp',
        theme: ThemeData(
          primaryColor: const Color(0xFF0066FF),
          colorScheme: ColorScheme.fromSwatch().copyWith(
            secondary: const Color(0xFFFF6600),
            surface: const Color(0xFFF5F5F5),
            error: const Color(0xFFB00020),
          ),
          scaffoldBackgroundColor: const Color(0xFFF5F5F5),
          textTheme: const TextTheme(
            headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w700),
            headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w700),
            headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
            bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            labelLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0066FF),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.all(16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
          ),
          inputDecorationTheme: InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
          cardTheme: CardThemeData(
            color: Colors.white,
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
