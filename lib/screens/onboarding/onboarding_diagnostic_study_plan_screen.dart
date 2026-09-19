import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../home/home_today_screen.dart';

class _Lesson {
  const _Lesson({
    required this.number,
    required this.icon,
    required this.background,
    required this.border,
    required this.iconColor,
    required this.title,
    required this.subtitle,
  });

  final int number;
  final String icon;
  final Color background;
  final Color border;
  final Color iconColor;
  final String title;
  final String subtitle;
}

class OnboardingDiagnosticStudyPlanScreen extends StatefulWidget {
  const OnboardingDiagnosticStudyPlanScreen({super.key});

  @override
  State<OnboardingDiagnosticStudyPlanScreen> createState() =>
      _OnboardingDiagnosticStudyPlanScreenState();
}

class _OnboardingDiagnosticStudyPlanScreenState
    extends State<OnboardingDiagnosticStudyPlanScreen> {
  static const _currentStep = 7;
  static const _totalSteps = 7;
  static const _durations = ['10 min', '20 min', '30 min'];

  static const _lessons = [
    _Lesson(
      number: 1,
      icon: 'assets/icons/onboarding/book.svg',
      background: AppColors.planLessonBlueBg,
      border: AppColors.planLessonBlueBorder,
      iconColor: AppColors.diagPrimary,
      title: 'Reading Fundamentals',
      subtitle: 'Skimming & scanning techniques',
    ),
    _Lesson(
      number: 2,
      icon: 'assets/icons/onboarding/pencil.svg',
      background: AppColors.planLessonOrangeBg,
      border: AppColors.planLessonOrangeBorder,
      iconColor: AppColors.planLessonOrangeIcon,
      title: 'Writing Task 1 Basics',
      subtitle: 'Describing charts & graphs',
    ),
    _Lesson(
      number: 3,
      icon: 'assets/icons/onboarding/headphones.svg',
      background: AppColors.planLessonGreenBg,
      border: AppColors.planLessonGreenBorder,
      iconColor: AppColors.planLessonGreenIcon,
      title: 'Listening Practice',
      subtitle: 'Note-taking while listening',
    ),
  ];

  int _selectedDuration = 1;

  void _startLearning(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const HomeTodayScreen()),
    );
  }

  void _exploreOnMyOwn() {
    // No dedicated destination yet — user opts out of the guided plan.
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
                'Your personalised plan is ready',
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
                "We've built a study plan based on your diagnostic results.",
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  height: 24 / 16,
                  color: AppColors.slateMuted,
                ),
              ),
              const SizedBox(height: 24),
              _buildPlanCard(),
              const SizedBox(height: 32),
              _buildDurationPicker(),
              const SizedBox(height: 32),
              Text(
                'Your first lessons',
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 24 / 18,
                  color: AppColors.slate,
                ),
              ),
              const SizedBox(height: 16),
              for (var i = 0; i < _lessons.length; i++) ...[
                if (i > 0) const SizedBox(height: 12),
                _buildLessonCard(_lessons[i]),
              ],
              const SizedBox(height: 40),
              _buildStartButton(context),
              const SizedBox(height: 16),
              Center(
                child: GestureDetector(
                  onTap: _exploreOnMyOwn,
                  child: Text(
                    "I'll explore on my own",
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 20 / 14,
                      color: AppColors.planExploreLink,
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

  Widget _buildPlanCard() {
    return Container(
      width: double.infinity,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.planCardBorder),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.planCardGradientStart,
            AppColors.planCardGradientEnd,
          ],
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: -20,
            right: -20,
            child: SvgPicture.asset(
              'assets/icons/onboarding/plan_target_deco.svg',
              width: 80,
              height: 80,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.planBadgeBg,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        'assets/icons/onboarding/plan_badge_star.svg',
                        width: 13,
                        height: 13,
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
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: AppColors.planStatCardBg,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.planStatCardBorder),
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildStatItem(
                          icon: 'assets/icons/onboarding/clock.svg',
                          label: 'Daily Practice',
                          value: '20 min/day',
                        ),
                      ),
                      Container(
                        width: 1,
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 12),
                        color: AppColors.planDivider,
                      ),
                      Expanded(
                        child: _buildStatItem(
                          icon: 'assets/icons/onboarding/calendar.svg',
                          label: 'Target Band',
                          value: 'Band 7.0',
                        ),
                      ),
                    ],
                  ),
                ),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            color: AppColors.planStatIconBg,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(icon, width: 18, height: 18),
        ),
        const SizedBox(width: 10),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  height: 14 / 11,
                  color: AppColors.planStatLabel,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  height: 18 / 14,
                  color: AppColors.slate,
                ),
              ),
            ],
          ),
        ),
      ],
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
            height: 22 / 16,
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
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(
                      color: selected
                          ? AppColors.planPillSelectedBg
                          : AppColors.planPillBg,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: selected
                            ? AppColors.planPillSelectedBg
                            : AppColors.planPillBorder,
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (selected) ...[
                          SvgPicture.asset(
                            'assets/icons/onboarding/check_white.svg',
                            width: 14,
                            height: 14,
                          ),
                          const SizedBox(width: 6),
                        ],
                        Text(
                          _durations[index],
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            height: 20 / 14,
                            color: selected
                                ? AppColors.white
                                : AppColors.slateBody,
                          ),
                        ),
                      ],
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
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: lesson.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: lesson.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              '${lesson.number}',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w700,
                height: 18 / 14,
                color: lesson.iconColor,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              lesson.icon,
              width: 18,
              height: 18,
              colorFilter: ColorFilter.mode(
                lesson.iconColor,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  lesson.title,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    height: 20 / 15,
                    color: AppColors.slate,
                  ),
                ),
                Text(
                  lesson.subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 18 / 13,
                    color: AppColors.slateMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            'assets/icons/onboarding/chevron_right_blue.svg',
            width: 6,
            height: 10.67,
            colorFilter: ColorFilter.mode(lesson.iconColor, BlendMode.srcIn),
          ),
        ],
      ),
    );
  }

  Widget _buildStartButton(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 52,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: Color(0x403B82F6),
            offset: Offset(0, 10),
            blurRadius: 7.5,
            spreadRadius: -3,
          ),
          BoxShadow(
            color: Color(0x403B82F6),
            offset: Offset(0, 4),
            blurRadius: 3,
            spreadRadius: -4,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () => _startLearning(context),
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
            height: 24 / 16,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
