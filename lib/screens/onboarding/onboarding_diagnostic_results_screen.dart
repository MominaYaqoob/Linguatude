import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../../widgets/onboarding/onboarding_continue_button.dart';

class _BandScore {
  const _BandScore({
    required this.label,
    required this.icon,
    required this.iconBackground,
    required this.score,
    required this.progress,
    required this.progressColor,
    required this.scoreColor,
  });

  final String label;
  final String icon;
  final Color iconBackground;
  final String score;
  final double progress;
  final Color progressColor;
  final Color scoreColor;
}

class OnboardingDiagnosticResultsScreen extends StatelessWidget {
  const OnboardingDiagnosticResultsScreen({super.key});

  static const _currentStep = 6;
  static const _totalSteps = 7;

  static const _scores = [
    _BandScore(
      label: 'Reading',
      icon: 'assets/icons/onboarding/results_book.svg',
      iconBackground: AppColors.resultsIconBgBlue,
      score: '7.0',
      progress: 0.75,
      progressColor: AppColors.resultsProgressGreen,
      scoreColor: AppColors.resultsScoreGreen,
    ),
    _BandScore(
      label: 'Writing',
      icon: 'assets/icons/onboarding/results_pencil.svg',
      iconBackground: AppColors.resultsIconBgAmber,
      score: '5.5',
      progress: 0.55,
      progressColor: AppColors.resultsAmber,
      scoreColor: AppColors.resultsAmber,
    ),
    _BandScore(
      label: 'Listening',
      icon: 'assets/icons/onboarding/results_headphones.svg',
      iconBackground: AppColors.resultsIconBgBlue,
      score: '6.5',
      progress: 0.65,
      progressColor: AppColors.resultsProgressGreen,
      scoreColor: AppColors.resultsScoreGreen,
    ),
    _BandScore(
      label: 'Speaking',
      icon: 'assets/icons/onboarding/results_mic.svg',
      iconBackground: AppColors.resultsIconBgRose,
      score: '4.5',
      progress: 0.45,
      progressColor: AppColors.resultsRose,
      scoreColor: AppColors.resultsRose,
    ),
  ];

  void _continue(BuildContext context) {
    // Study plan screen is not built yet — nothing further to navigate to.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildStepProgress(),
              const SizedBox(height: 24),
              Text(
                "Here's where you stand",
                style: GoogleFonts.inter(
                  fontSize: 30,
                  fontWeight: FontWeight.w700,
                  height: 36 / 30,
                  letterSpacing: -0.75,
                  color: AppColors.slate,
                ),
              ),
              const SizedBox(height: 16),
              _buildInfoBanner(),
              const SizedBox(height: 16),
              for (var i = 0; i < _scores.length; i++) ...[
                if (i > 0) const SizedBox(height: 16),
                _buildScoreCard(_scores[i]),
              ],
              const SizedBox(height: 40),
              _buildStrengthCard(),
              const SizedBox(height: 12),
              _buildFocusCard(),
              const SizedBox(height: 12),
              _buildDisclaimerCard(),
              const SizedBox(height: 40),
              OnboardingContinueButton(
                label: 'See My Study Plan',
                onPressed: () => _continue(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStepProgress() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(_totalSteps, (index) {
            final active = index < _currentStep;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == _totalSteps - 1 ? 0 : 6,
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
          'Step $_currentStep of $_totalSteps',
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

  Widget _buildInfoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.diagBannerBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.diagBannerBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/onboarding/diag_info_circle.svg',
            width: 17,
            height: 17,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Based on your diagnostic test, here are your estimated band scores.',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 19 / 13,
                color: AppColors.slateBody,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreCard(_BandScore item) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.targetBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: item.iconBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(item.icon, fit: BoxFit.contain),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.label,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 20 / 16,
                        color: AppColors.slate,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          item.score,
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            height: 24 / 20,
                            color: item.scoreColor,
                          ),
                        ),
                        Text(
                          '(estimated)',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                            height: 14 / 11,
                            color: AppColors.dateHint,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: SizedBox(
                    height: 8,
                    child: Stack(
                      children: [
                        Container(color: AppColors.resultsTrackBg),
                        FractionallySizedBox(
                          widthFactor: item.progress.clamp(0, 1),
                          child: Container(color: item.progressColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard({
    required String icon,
    required Color background,
    required Color border,
    required Color iconBackground,
    required Color textColor,
    required String title,
    required String body,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(icon, fit: BoxFit.contain),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 16 / 12,
                    letterSpacing: 0.6,
                    color: textColor,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 19 / 13,
                    color: textColor,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStrengthCard() {
    return _buildInsightCard(
      icon: 'assets/icons/onboarding/results_star.svg',
      background: AppColors.resultsStrengthBg,
      border: AppColors.resultsStrengthBorder,
      iconBackground: AppColors.resultsStrengthIconBg,
      textColor: AppColors.resultsStrengthText,
      title: 'YOUR STRENGTH',
      body:
          'Your reading skills are strong — you understand main ideas and '
          'details well.',
    );
  }

  Widget _buildFocusCard() {
    return _buildInsightCard(
      icon: 'assets/icons/onboarding/results_target.svg',
      background: AppColors.resultsFocusBg,
      border: AppColors.resultsFocusBorder,
      iconBackground: AppColors.resultsFocusIconBg,
      textColor: AppColors.resultsFocusText,
      title: 'FOCUS AREA',
      body:
          "Speaking is your lowest area right now — let's work on "
          'confidence and fluency.',
    );
  }

  Widget _buildDisclaimerCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.resultsNoticeBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.resultsNoticeIconBg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/onboarding/results_sparkle.svg',
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'These scores are AI-estimated for self-assessment purposes '
              'only. They are not official IELTS results',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w400,
                height: 19 / 13,
                color: AppColors.diagOptionText,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
