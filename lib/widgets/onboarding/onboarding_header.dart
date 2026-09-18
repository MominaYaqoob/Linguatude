import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';

class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({
    super.key,
    required this.currentStep,
    this.totalSteps = 7,
  });

  final int currentStep;
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            SvgPicture.asset(
              'assets/icons/logo.svg',
              width: 29.33,
              height: 24,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 9.67),
            Text(
              'Linguatude',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 32 / 24,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        Row(
          children: List.generate(totalSteps, (index) {
            final active = index < currentStep;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == totalSteps - 1 ? 0 : 6,
                ),
                child: Container(
                  height: 14,
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.primaryButton
                        : AppColors.progressInactive,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        Text(
          'Step $currentStep of $totalSteps',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            height: 20 / 14,
            color: AppColors.slateMuted,
          ),
        ),
      ],
    );
  }
}
