import 'package:flutter/material.dart';
import '../constants/app_constants.dart';

/// A reusable text field component with consistent styling
class AppTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final int? maxLines;
  final bool enabled;
  final String? labelText;
  final TextCapitalization textCapitalization;
  final void Function(String)? onChanged;

  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.maxLines = 1,
    this.enabled = true,
    this.labelText,
    this.textCapitalization = TextCapitalization.none,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      maxLines: maxLines,
      enabled: enabled,
      textCapitalization: textCapitalization,
      validator: validator,
      onChanged: onChanged,
      style: TextStyle(
        color: enabled ? AppColors.textWhite : AppColors.textWhite70,
        fontSize: 18,
      ),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(
          color: AppColors.textWhite70,
          fontSize: 18,
        ),
        filled: true,
        fillColor: enabled ? AppColors.inputBg : AppColors.inputBg.withValues(alpha: 128),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: const BorderSide(color: AppColors.accent, width: 2),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.borderRadius),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        suffixIcon: suffixIcon,
      ),
    );
  }
}