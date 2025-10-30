import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_button.dart';
import '../components/app_text_field.dart';
import '../constants/app_constants.dart';
import '../providers/auth_provider.dart';
import 'register_screen.dart';
import 'package:flutter/gestures.dart';
import 'initial_state_screen.dart';

/// Login screen for user authentication
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_updateForm);
    _passwordController.addListener(_updateForm);
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _updateForm() {
    setState(() {});
  }

  bool get _isFormValid =>
      _emailController.text.trim().isNotEmpty &&
      _passwordController.text.isNotEmpty;

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) return;

    final authProvider = context.read<AuthProvider>();
    final text = _emailController.text.trim();
    String email = '';
    String username = '';

    if (text.contains('@')) {
      email = text;
      final localPart = text.split('@')[0];
      final parts = localPart.split('.');
      if (parts.length >= 2) {
        username = parts[0] + parts[1].substring(parts[1].length - 2);
      } else {
        username = localPart;
      }
    } else {
      username = text;
    }

    final success = await authProvider.login(
      email: email,
      username: username,
      password: _passwordController.text,
    );

    if (success && mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const InitialStateScreen()),
      );
    } else if (authProvider.errorMessage != null && mounted) {
      _showErrorSnackBar(authProvider.errorMessage!);
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: AppColors.textWhite),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
          ),
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.loginBgStart, AppColors.loginBgEnd],
              ),
            ),
            child: SafeArea(
              child: Column(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppDimensions.paddingHorizontal,
                        vertical: AppDimensions.paddingVertical,
                      ),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: AppDimensions.spacingLarge),
                            const Text(
                              AppStrings.login,
                              style: TextStyle(
                                color: AppColors.textWhite,
                                fontSize: AppDimensions.fontSizeLarge,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: AppDimensions.spacingLarge),
                            AppTextField(
                              controller: _emailController,
                              hintText: AppStrings.enterUsernameEmail,
                            ),
                            const SizedBox(height: AppDimensions.spacingSmall),
                            AppTextField(
                              controller: _passwordController,
                              hintText: AppStrings.enterPassword,
                              obscureText: _obscurePassword,
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off
                                      : Icons.visibility,
                                  color: AppColors.amberAccent,
                                ),
                                onPressed: _togglePasswordVisibility,
                              ),
                            ),
                            const SizedBox(height: AppDimensions.spacingMedium),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        AppButton(
                          text: authProvider.isLoading
                              ? AppStrings.loggingIn
                              : AppStrings.login,
                          isLoading: authProvider.isLoading,
                          onPressed: _isFormValid && !authProvider.isLoading
                              ? _handleLogin
                              : null,
                        ),
                        const SizedBox(height: 24),
                        RichText(
                          text: TextSpan(
                            text: AppStrings.noAccount,
                            style: const TextStyle(
                              color: AppColors.textWhite70,
                              fontSize: AppDimensions.fontSizeMedium,
                            ),
                            children: [
                              TextSpan(
                                text: AppStrings.registerHere,
                                style: const TextStyle(
                                  color: AppColors.accent,
                                  decoration: TextDecoration.underline,
                                  fontWeight: FontWeight.w500,
                                ),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = _navigateToRegister,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}