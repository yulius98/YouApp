import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// A reusable button component with gradient background and consistent styling
class AppButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;

  const AppButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.width,
    this.height,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null && !isLoading;

    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? AppDimensions.buttonHeight,
      child: ElevatedButton(
        onPressed: isEnabled ? onPressed : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: padding ?? EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          ),
        ).copyWith(
          backgroundColor: WidgetStateProperty.resolveWith<Color>(
            (Set<WidgetState> states) {
              if (states.contains(WidgetState.disabled)) {
                return AppColors.primary.withValues(alpha: 77);
              }
              return Colors.transparent;
            },
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: const GradientRotation(108.32 * 3.1415926535 / 180),
              colors: const [
                Color(0xFF62CDCB),
                Color(0xFF4599DB),
              ],
              stops: const [0.2488, 0.7849],
            ),
            borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          ),
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: isLoading
                ? const SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
