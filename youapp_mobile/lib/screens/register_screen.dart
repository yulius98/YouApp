
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/app_button.dart';
import '../components/app_text_field.dart';
import '../constants/app_constants.dart';
import '../models/register.dart';
import '../providers/auth_provider.dart';
import 'login_screen.dart';

/// Registration screen for new user sign up
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void initState() {
    super.initState();
    emailController.addListener(_updateForm);
    usernameController.addListener(_updateForm);
    passwordController.addListener(_updateForm);
    confirmPasswordController.addListener(_updateForm);
  }

  @override
  void dispose() {
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  void _updateForm() {
    setState(() {});
  }

  bool get _isFormValid {
    final email = emailController.text.trim();
    final username = usernameController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;
    return email.isNotEmpty &&
           username.isNotEmpty &&
           password.isNotEmpty &&
           confirmPassword.isNotEmpty &&
           password == confirmPassword;
  }

  Future<void> _handleRegister() async {
    final authProvider = context.read<AuthProvider>();
    final request = RegisterRequest(
      email: emailController.text.trim(),
      username: usernameController.text.trim(),
      password: passwordController.text,
    );

    final success = await authProvider.register(request);

    if (success && mounted) {
      _showSuccessSnackBar();
      _navigateToLogin();
    } else if (authProvider.errorMessage != null && mounted) {
      _showErrorSnackBar(authProvider.errorMessage!);
    }
  }

  void _showSuccessSnackBar() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text(AppStrings.registrationSuccessful)),
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _navigateToLogin() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  void _togglePasswordVisibility() {
    setState(() => _obscurePassword = !_obscurePassword);
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() => _obscureConfirmPassword = !_obscureConfirmPassword);
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AuthProvider>(
      builder: (context, authProvider, child) {
        return Scaffold(
          backgroundColor: AppColors.loginBgStart,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingHorizontal,
                  vertical: AppDimensions.paddingVertical,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(
                            Icons.arrow_back_ios_new_rounded,
                            color: AppColors.textWhite,
                            size: 24,
                          ),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                        const SizedBox(width: 4),
                        const Text(
                          AppStrings.back,
                          style: TextStyle(
                            color: AppColors.textWhite,
                            fontSize: AppDimensions.fontSizeMedium,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppDimensions.spacingLarge),
                    const Text(
                      AppStrings.register,
                      style: TextStyle(
                        color: AppColors.textWhite,
                        fontSize: AppDimensions.fontSizeLarge,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingLarge),
                    AppTextField(
                      controller: emailController,
                      hintText: AppStrings.enterEmail,
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: AppDimensions.spacingSmall),
                    AppTextField(
                      controller: usernameController,
                      hintText: AppStrings.createUsername,
                    ),
                    const SizedBox(height: AppDimensions.spacingSmall),
                    AppTextField(
                      controller: passwordController,
                      hintText: AppStrings.createPassword,
                      obscureText: _obscurePassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          color: AppColors.amberAccent,
                        ),
                        onPressed: _togglePasswordVisibility,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingSmall),
                    AppTextField(
                      controller: confirmPasswordController,
                      hintText: AppStrings.confirmPassword,
                      obscureText: _obscureConfirmPassword,
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscureConfirmPassword
                              ? Icons.visibility_off_rounded
                              : Icons.visibility_rounded,
                          color: AppColors.amberAccent,
                        ),
                        onPressed: _toggleConfirmPasswordVisibility,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingLarge),
                    Center(
                      child: AppButton(
                        text: authProvider.isLoading
                            ? AppStrings.registering
                            : AppStrings.register,
                        isLoading: authProvider.isLoading,
                        onPressed: _isFormValid && !authProvider.isLoading
                            ? _handleRegister
                            : null,
                      ),
                    ),
                    const SizedBox(height: AppDimensions.spacingMedium),
                    Center(
                      child: RichText(
                        text: TextSpan(
                          text: AppStrings.haveAccount,
                          style: const TextStyle(
                            color: AppColors.textWhite,
                            fontSize: AppDimensions.fontSizeMedium,
                          ),
                          children: [
                            TextSpan(
                              text: AppStrings.loginHere,
                              style: const TextStyle(
                                color: AppColors.amberAccent,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () => Navigator.of(context).pop(),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
