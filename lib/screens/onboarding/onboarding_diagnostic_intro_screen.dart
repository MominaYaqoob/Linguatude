import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../../widgets/onboarding/onboarding_header.dart';
import 'onboarding_diagnostic_active_screen.dart';

class OnboardingDiagnosticIntroScreen extends StatelessWidget {
  const OnboardingDiagnosticIntroScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const OnboardingHeader(currentStep: 5),
              const SizedBox(height: 24),
              Text(
                "Let's find your starting\npoint?",
                style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.w600,
                  height: 36 / 30,
                  letterSpacing: -0.75,
                  color: AppColors.slate,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'A quick 10-minute test tells us exactly where to focus your preparation.',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 22.75 / 14,
                  color: AppColors.slateSoft,
                ),
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(17),
                decoration: BoxDecoration(
                  color: AppColors.statsCard,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.gray100),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: Color(0x0D000000),
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: _statItem(
                        'assets/icons/onboarding/clock.svg',
                        '10–12 minutes',
                      ),
                    ),
                    Expanded(
                      child: _statItem(
                        'assets/icons/onboarding/grid_skills.svg',
                        'All 4 skills\ntested',
                      ),
                    ),
                    Expanded(
                      child: _statItem(
                        'assets/icons/onboarding/sparkle.svg',
                        'Instant AI\nanalysis',
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Text(
                'What to expect',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 20 / 14,
                  color: AppColors.slate,
                ),
              ),
              const SizedBox(height: 12),
              _listItem(
                '1',
                'Short questions in Reading, Listening, and Writing',
                showDivider: true,
              ),
              _listItem(
                '2',
                'Two brief speaking prompts — just 30–60 seconds each',
                showDivider: true,
              ),
              _listItem(
                '3',
                'Personalised score report and study plan',
                showDivider: false,
              ),
              const SizedBox(height: 24),
              Container(
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: AppColors.overallBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: const Color(0xFFE0E7FF)),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x40000000),
                      offset: Offset(0, 4),
                      blurRadius: 4,
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 36,
                      height: 36,
                      decoration: const BoxDecoration(
                        color: Color(0xCCE0E7FF),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: SvgPicture.asset(
                        'assets/icons/onboarding/mic_notice.svg',
                        width: 20,
                        height: 20,
                        fit: BoxFit.contain,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "We'll ask for microphone access when the speaking section begins.",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 15 / 12,
                          color: AppColors.slateSoft,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0x334F46E5),
                      offset: const Offset(0, 10),
                      blurRadius: 15,
                      spreadRadius: -3,
                    ),
                    BoxShadow(
                      color: const Color(0x334F46E5),
                      offset: const Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: -4,
                    ),
                  ],
                ),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) =>
                            const OnboardingDiagnosticActiveScreen(),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryButton,
                    foregroundColor: AppColors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 14,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/onboarding/sparkle_white.svg',
                        width: 16,
                        height: 16,
                        fit: BoxFit.contain,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Start Diagnostic Test',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          height: 20 / 14,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primaryButton,
                    side: const BorderSide(color: AppColors.secondaryBtnBorder),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 17,
                      vertical: 15,
                    ),
                  ),
                  child: Text(
                    "Skip — I'll set up my plan manually",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 20 / 14,
                      color: AppColors.primaryButton,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statItem(String icon, String label) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.iconChip,
            shape: BoxShape.circle,
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                offset: Offset(0, 2),
                blurRadius: 4,
                blurStyle: BlurStyle.inner,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            icon,
            width: 24,
            height: 24,
            fit: BoxFit.contain,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            height: 15 / 12,
            color: AppColors.slate,
          ),
        ),
      ],
    );
  }

  Widget _listItem(String number, String text, {required bool showDivider}) {
    return Container(
      padding: EdgeInsets.only(bottom: showDivider ? 13 : 0),
      margin: const EdgeInsets.only(bottom: 12),
      decoration: showDivider
          ? const BoxDecoration(
              border: Border(
                bottom: BorderSide(color: AppColors.listDivider),
              ),
            )
          : null,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: const BoxDecoration(
              color: AppColors.iconChip,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              number,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 16 / 12,
                color: AppColors.primaryButton,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 16 / 12,
                  color: AppColors.slateBody,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
