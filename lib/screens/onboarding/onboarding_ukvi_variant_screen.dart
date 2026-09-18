import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../../widgets/onboarding/onboarding_continue_button.dart';
import '../../widgets/onboarding/onboarding_header.dart';
import '../../widgets/onboarding/onboarding_option_card.dart';
import 'onboarding_previous_score_screen.dart';

enum UkviLevel { a1, a2, b1 }

class OnboardingUkviVariantScreen extends StatefulWidget {
  const OnboardingUkviVariantScreen({super.key});

  @override
  State<OnboardingUkviVariantScreen> createState() =>
      _OnboardingUkviVariantScreenState();
}

class _OnboardingUkviVariantScreenState
    extends State<OnboardingUkviVariantScreen> {
  UkviLevel _selected = UkviLevel.a1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: OnboardingHeader(currentStep: 2),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Which level do you\nneed?',
                      style: GoogleFonts.inter(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        height: 36 / 30,
                        letterSpacing: -0.75,
                        color: AppColors.slate,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Your level is set by UK Visas and Immigration — check your visa requirements if unsure.',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        height: 22.75 / 14,
                        color: AppColors.slateMuted,
                      ),
                    ),
                    const SizedBox(height: 24),
                    OnboardingOptionCard(
                      title: 'A1 Life Skills',
                      subtitle:
                          'Speaking only · For spouse / family visa applicants',
                      iconAsset: 'assets/icons/onboarding/chat_bubble.svg',
                      iconCircle: true,
                      selected: _selected == UkviLevel.a1,
                      onTap: () => setState(() => _selected = UkviLevel.a1),
                    ),
                    const SizedBox(height: 12),
                    OnboardingOptionCard(
                      title: 'A2 Life Skills',
                      subtitle:
                          'Speaking and Listening · For family route extension',
                      iconAsset: 'assets/icons/onboarding/headset.svg',
                      iconCircle: true,
                      uncheckedRadioSize: 20,
                      selected: _selected == UkviLevel.a2,
                      onTap: () => setState(() => _selected = UkviLevel.a2),
                    ),
                    const SizedBox(height: 12),
                    OnboardingOptionCard(
                      title: 'B1 Life Skills',
                      subtitle:
                          'Speaking and Listening · For Indefinite Leave to Remain or citizenship',
                      iconAsset: 'assets/icons/onboarding/user_globe.svg',
                      iconCircle: true,
                      uncheckedRadioSize: 20,
                      selected: _selected == UkviLevel.b1,
                      onTap: () => setState(() => _selected = UkviLevel.b1),
                    ),
                    const SizedBox(height: 32),
                    GestureDetector(
                      onTap: () {},
                      child: Row(
                        children: [
                          Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(
                                color: AppColors.primaryButton,
                              ),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              '?',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w400,
                                height: 16 / 12,
                                color: AppColors.primaryButton,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Not sure which level you need?',
                            style: GoogleFonts.inter(
                              fontSize: 14,
                              fontWeight: FontWeight.w400,
                              height: 20 / 14,
                              color: AppColors.primaryButton,
                            ),
                          ),
                          const SizedBox(width: 8),
                          SvgPicture.asset(
                            'assets/icons/onboarding/chevron_right_blue.svg',
                            width: 16,
                            height: 16,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
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
                      builder: (_) => const OnboardingPreviousScoreScreen(),
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
