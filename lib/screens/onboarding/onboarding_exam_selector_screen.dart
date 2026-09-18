import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../../widgets/onboarding/onboarding_continue_button.dart';
import '../../widgets/onboarding/onboarding_header.dart';
import '../../widgets/onboarding/onboarding_option_card.dart';
import 'onboarding_ukvi_variant_screen.dart';

enum ExamType { academic, ukvi }

class OnboardingExamSelectorScreen extends StatefulWidget {
  const OnboardingExamSelectorScreen({super.key});

  @override
  State<OnboardingExamSelectorScreen> createState() =>
      _OnboardingExamSelectorScreenState();
}

class _OnboardingExamSelectorScreenState
    extends State<OnboardingExamSelectorScreen> {
  ExamType _selected = ExamType.academic;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: OnboardingHeader(currentStep: 1),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Let's get you ready",
                      style: GoogleFonts.inter(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        height: 36 / 30,
                        letterSpacing: -0.75,
                        color: AppColors.slate,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      'Which exam are you preparing for?',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 20 / 14,
                        color: AppColors.slateMuted,
                      ),
                    ),
                    const SizedBox(height: 24),
                    OnboardingOptionCard(
                      title: 'IELTS Academic',
                      subtitle:
                          'For university admission and professional registration',
                      iconAsset: 'assets/icons/onboarding/exam_cap.svg',
                      selected: _selected == ExamType.academic,
                      onTap: () =>
                          setState(() => _selected = ExamType.academic),
                    ),
                    const SizedBox(height: 16),
                    OnboardingOptionCard(
                      title: 'IELTS UKVI / Life Skills',
                      subtitle: 'For UK visa applications and immigration',
                      iconAsset: 'assets/icons/onboarding/exam_globe.svg',
                      iconBackground: AppColors.gray50,
                      selected: _selected == ExamType.ukvi,
                      onTap: () => setState(() => _selected = ExamType.ukvi),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: OnboardingContinueButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const OnboardingUkviVariantScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
