import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.prefixAsset,
    required this.prefixWidth,
    required this.prefixHeight,
    this.hintText,
    this.obscureText = false,
    this.keyboardType,
    this.suffixAsset,
    this.suffixWidth,
    this.suffixHeight,
    this.onSuffixTap,
    this.helperText,
  });

  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String prefixAsset;
  final double prefixWidth;
  final double prefixHeight;
  final String? hintText;
  final bool obscureText;
  final TextInputType? keyboardType;
  final String? suffixAsset;
  final double? suffixWidth;
  final double? suffixHeight;
  final VoidCallback? onSuffixTap;
  final String? helperText;

  @override
  Widget build(BuildContext context) {
    final focused = focusNode.hasFocus;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 20 / 14,
            color: AppColors.label,
          ),
        ),
        const SizedBox(height: 8),
        AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          height: 57,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: focused ? AppColors.primary : AppColors.inputBorder,
              width: 1,
            ),
            boxShadow: focused
                ? const [
                    BoxShadow(
                      color: AppColors.focusShadow,
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ]
                : null,
          ),
          child: Stack(
            children: [
              Positioned(
                left: 16,
                top: 0,
                bottom: 0,
                child: Center(
                  child: SvgPicture.asset(
                    prefixAsset,
                    width: prefixWidth,
                    height: prefixHeight,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              Positioned.fill(
                child: TextField(
                  controller: controller,
                  focusNode: focusNode,
                  obscureText: obscureText,
                  keyboardType: keyboardType,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.placeholder,
                  ),
                  decoration: InputDecoration(
                    isDense: true,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.fromLTRB(
                      48,
                      18,
                      suffixAsset != null ? 48 : 16,
                      18,
                    ),
                    hintText: hintText,
                    hintStyle: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: AppColors.placeholder,
                    ),
                  ),
                ),
              ),
              if (suffixAsset != null)
                Positioned(
                  right: 16,
                  top: 0,
                  bottom: 0,
                  child: GestureDetector(
                    onTap: onSuffixTap,
                    behavior: HitTestBehavior.opaque,
                    child: Center(
                      child: SvgPicture.asset(
                        suffixAsset!,
                        width: suffixWidth ?? 18.33,
                        height: suffixHeight ?? 12.5,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        if (helperText != null) ...[
          const SizedBox(height: 8),
          Text(
            helperText!,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 16 / 12,
              color: AppColors.helper,
            ),
          ),
        ],
      ],
    );
  }
}
