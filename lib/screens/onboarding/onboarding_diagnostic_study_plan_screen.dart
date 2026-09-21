import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../home/home_today_screen.dart';

class _DurationOption {
  const _DurationOption({
    required this.label,
    required this.minutes,
    required this.weeks,
  });

  final String label;
  final int minutes;
  final int weeks;
}

class _Lesson {
  const _Lesson({
    required this.number,
    required this.icon,
    required this.background,
    required this.border,
    required this.iconBackground,
    required this.accent,
    required this.title,
    required this.subtitle,
    required this.duration,
  });

  final int number;
  final String icon;
  final Color background;
  final Color border;
  final Color iconBackground;
  final Color accent;
  final String title;
  final String subtitle;
  final String duration;
}

class OnboardingDiagnosticStudyPlanScreen extends StatefulWidget {
  const OnboardingDiagnosticStudyPlanScreen({super.key});

  @override
  State<OnboardingDiagnosticStudyPlanScreen> createState() =>
      _OnboardingDiagnosticStudyPlanScreenState();
}

class _OnboardingDiagnosticStudyPlanScreenState
    extends State<OnboardingDiagnosticStudyPlanScreen> {
  static const _currentStep = 6;
  static const _totalSteps = 7;
  static const _durations = [
    _DurationOption(label: '10 min', minutes: 10, weeks: 16),
    _DurationOption(label: '20 min', minutes: 20, weeks: 12),
    _DurationOption(label: '30 min', minutes: 30, weeks: 8),
  ];

  static const _lessons = [
    _Lesson(
      number: 1,
      icon: 'assets/icons/onboarding/mic.svg',
      background: AppColors.planLessonBlueBg,
      border: AppColors.planLessonBlueBorder,
      iconBackground: AppColors.planLessonBlueIconBg,
      accent: AppColors.diagPrimary,
      title: 'Speaking: Part 1',
      subtitle: 'Introduction & familiar topics',
      duration: '20 min',
    ),
    _Lesson(
      number: 2,
      icon: 'assets/icons/onboarding/headphones.svg',
      background: AppColors.planLessonOrangeBg,
      border: AppColors.planLessonOrangeBorder,
      iconBackground: AppColors.planLessonOrangeIconBg,
      accent: AppColors.planLessonOrangeIcon,
      title: 'Listening: Section 1',
      subtitle: 'Short conversations',
      duration: '25 min',
    ),
    _Lesson(
      number: 3,
      icon: 'assets/icons/onboarding/pencil.svg',
      background: AppColors.planLessonGreenBg,
      border: AppColors.planLessonGreenBorder,
      iconBackground: AppColors.planLessonGreenIconBg,
      accent: AppColors.planLessonGreenIcon,
      title: 'Writing: Task 2 – Essay',
      subtitle: 'Structure & planning',
      duration: '30 min',
    ),
  ];

  int _selectedDuration = 2;

  _DurationOption get _selected => _durations[_selectedDuration];

  void _goHome(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeTodayScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildStepProgress(),
                    const SizedBox(height: 16),
                    Text(
                      'Your personalised plan is ready',
                      style: GoogleFonts.inter(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        height: 36 / 30,
                        letterSpacing: -0.75,
                        color: AppColors.slate,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'A clear, step-by-step path to help you reach your target score.',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        height: 20 / 16,
                        color: AppColors.slateMuted,
                      ),
                    ),
                    const SizedBox(height: 20),
                    _buildPlanCard(),
                    const SizedBox(height: 20),
                    _buildDurationPicker(),
                    const SizedBox(height: 20),
                    Text(
                      'Your first 3 lessons',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 20 / 16,
                        color: AppColors.planLessonTitle,
                      ),
                    ),
                    const SizedBox(height: 10),
                    for (var i = 0; i < _lessons.length; i++) ...[
                      if (i > 0) const SizedBox(height: 8),
                      _buildLessonCard(_lessons[i]),
                    ],
                    const SizedBox(height: 20),
                    _buildBanner(
                      icon: 'assets/icons/onboarding/results_star.svg',
                      background: AppColors.planBannerGreenBg,
                      border: AppColors.planBannerGreenBorder,
                      iconBackground: AppColors.planBannerGreenIconBg,
                      iconColor: AppColors.planLessonGreenIcon,
                      textColor: AppColors.planBannerGreenText,
                      text:
                          'Consistent practice will build your skills across all areas.',
                    ),
                    const SizedBox(height: 8),
                    _buildBanner(
                      icon: 'assets/icons/onboarding/diag_shield_check.svg',
                      background: AppColors.planBannerGreyBg,
                      border: AppColors.planBannerGreyBorder,
                      iconBackground: AppColors.planBannerGreyIconBg,
                      iconColor: AppColors.planBannerGreyIcon,
                      textColor: AppColors.slateMuted,
                      text:
                          'This is an estimate based on average learner progress. Individual results vary.',
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
              child: _buildFooter(context),
            ),
          ],
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
        const SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(top: 4),
          child: Text(
            'Step $_currentStep of $_totalSteps',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              height: 20 / 14,
              color: AppColors.slateMuted,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPlanCard() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.planCardBorder),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.planCardGradientStart,
            AppColors.planCardGradientEnd,
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            top: 8,
            right: 17,
            child: SvgPicture.asset(
              'assets/icons/onboarding/plan_target_deco.svg',
              width: 48,
              height: 48,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(17),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 24,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.planBadgeBg,
                    borderRadius: BorderRadius.circular(9999),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x0D000000),
                        offset: Offset(0, 1),
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/onboarding/plan_badge_star.svg',
                        width: 11,
                        height: 10,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Your Study Plan',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          height: 16 / 12,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 13,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.planStatCardBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.planStatCardBorder),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          icon: 'assets/icons/onboarding/clock.svg',
                          label: 'Daily goal',
                          value: '${_selected.minutes} minutes',
                        ),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          icon: 'assets/icons/onboarding/calendar.svg',
                          label: 'Time to Band 7.0',
                          value: '${_selected.weeks} weeks',
                        ),
                      ),
                      Expanded(
                        child: _buildStatItem(
                          icon: 'assets/icons/onboarding/results_target.svg',
                          label: 'Starting focus',
                          value: 'Speaking',
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                _buildTipBox(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Container(
          width: 28,
          height: 28,
          decoration: const BoxDecoration(
            color: AppColors.planStatIconBg,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            icon,
            width: 14,
            height: 14,
            colorFilter: const ColorFilter.mode(
              AppColors.planStatIcon,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            height: 14 / 10,
            color: AppColors.planStatLabel,
          ),
        ),
        Text(
          value,
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 16 / 12,
            color: AppColors.slate,
          ),
        ),
      ],
    );
  }

  Widget _buildTipBox() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 11),
      decoration: BoxDecoration(
        color: AppColors.planTipBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.planTipBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: const BoxDecoration(
              color: AppColors.planTipIconBg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/onboarding/plan_lightbulb.svg',
              width: 9,
              height: 14,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: 'At ${_selected.minutes} minutes a day, you could reach ',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      height: 14 / 11,
                      color: AppColors.slateBody,
                    ),
                  ),
                  TextSpan(
                    text: 'Band 7.0',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      height: 14 / 11,
                      color: AppColors.slate,
                    ),
                  ),
                  TextSpan(
                    text: ' in approximately ',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w400,
                      height: 14 / 11,
                      color: AppColors.slateBody,
                    ),
                  ),
                  TextSpan(
                    text: '${_selected.weeks} weeks.',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      height: 14 / 11,
                      color: AppColors.slate,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDurationPicker() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'How much time can you study each day?',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 20 / 16,
            color: AppColors.slate,
          ),
        ),
        const SizedBox(height: 12),
        Row(
          children: List.generate(_durations.length, (index) {
            final selected = index == _selectedDuration;
            return Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  right: index == _durations.length - 1 ? 0 : 10,
                ),
                child: GestureDetector(
                  onTap: () => setState(() => _selectedDuration = index),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    height: 38,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.planPillSelectedBg
                          : AppColors.planPillBg,
                      borderRadius: BorderRadius.circular(9999),
                      border: Border.all(
                        color: selected
                            ? AppColors.planPillSelectedBg
                            : AppColors.planPillBorder,
                      ),
                      boxShadow: selected
                          ? const [
                              BoxShadow(
                                color: Color(0xFFBFDBFE),
                                offset: Offset(0, 1),
                                blurRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/onboarding/plan_clock.svg',
                            width: 12,
                            height: 12,
                            colorFilter: ColorFilter.mode(
                              selected
                                  ? AppColors.white.withValues(alpha: 0.8)
                                  : AppColors.planStatLabel,
                              BlendMode.srcIn,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            _durations[index].label,
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                              height: 16 / 12,
                              color: selected
                                  ? AppColors.white
                                  : AppColors.planPillUnselectedText,
                            ),
                          ),
                          if (selected) ...[
                            const SizedBox(width: 6),
                            SvgPicture.asset(
                              'assets/icons/onboarding/check_white.svg',
                              width: 12,
                              height: 12,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ],
    );
  }

  Widget _buildLessonCard(_Lesson lesson) {
    return Container(
      constraints: const BoxConstraints(minHeight: 66),
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
      decoration: BoxDecoration(
        color: lesson.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: lesson.border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: lesson.iconBackground,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: lesson.accent),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              lesson.icon,
              width: 16,
              height: 16,
              colorFilter: ColorFilter.mode(lesson.accent, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: lesson.accent,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${lesson.number}',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w700,
                height: 15 / 10,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  lesson.title,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    height: 16 / 13,
                    color: AppColors.planLessonTitle,
                  ),
                ),
                Text(
                  lesson.subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    height: 17 / 11,
                    color: AppColors.planLessonSubtitle,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            'assets/icons/onboarding/plan_clock.svg',
            width: 10,
            height: 10,
            colorFilter: const ColorFilter.mode(
              AppColors.planLessonMeta,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 4),
          Text(
            lesson.duration,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              height: 17 / 11,
              color: AppColors.planLessonMeta,
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            'assets/icons/onboarding/chevron_right_blue.svg',
            width: 6,
            height: 10.5,
            colorFilter: const ColorFilter.mode(
              AppColors.planLessonSubtitle,
              BlendMode.srcIn,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBanner({
    required String icon,
    required Color background,
    required Color border,
    required Color iconBackground,
    required Color iconColor,
    required Color textColor,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 13),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: iconBackground,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              icon,
              width: 10,
              height: 10,
              colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 16 / 12,
                color: textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 52,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 2),
                blurRadius: 4,
                spreadRadius: -2,
              ),
              BoxShadow(
                color: Color(0x1A000000),
                offset: Offset(0, 4),
                blurRadius: 6,
                spreadRadius: -1,
              ),
            ],
          ),
          child: ElevatedButton(
            onPressed: () => _goHome(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.diagPrimary,
              foregroundColor: AppColors.white,
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              padding: EdgeInsets.zero,
            ),
            child: Text(
              'Start Learning',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 20 / 16,
                color: AppColors.white,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () => _goHome(context),
          child: Text(
            "I'll explore on my own",
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 16 / 14,
              color: AppColors.planExploreLink,
              decoration: TextDecoration.underline,
              decorationColor: AppColors.planExploreLink,
            ),
          ),
        ),
      ],
    );
  }
}
