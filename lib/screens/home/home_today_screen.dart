import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../../widgets/dashboard/daily_goal_complete_dialog.dart';
import '../streak/streak_gamification_screen.dart';

class _Lesson {
  const _Lesson({
    required this.number,
    required this.icon,
    required this.gradientStart,
    required this.gradientEnd,
    required this.title,
    required this.subtitle,
    required this.time,
    required this.levelLabel,
    required this.levelBg,
    required this.levelBorder,
    required this.levelText,
    required this.highlighted,
    required this.actionLabel,
    required this.actionFilled,
  });

  final int number;
  final String icon;
  final Color gradientStart;
  final Color gradientEnd;
  final String title;
  final String subtitle;
  final String time;
  final String levelLabel;
  final Color levelBg;
  final Color levelBorder;
  final Color levelText;
  final bool highlighted;
  final String actionLabel;
  final bool actionFilled;
}

class _QuickAction {
  const _QuickAction({
    required this.icon,
    required this.label,
    required this.background,
    required this.iconBackground,
    required this.iconColor,
  });

  final String icon;
  final String label;
  final Color background;
  final Color iconBackground;
  final Color iconColor;
}

class HomeTodayScreen extends StatelessWidget {
  const HomeTodayScreen({super.key});

  static const _lessons = [
    _Lesson(
      number: 1,
      icon: 'assets/icons/onboarding/diag_book.svg',
      gradientStart: AppColors.homeGradBlueStart,
      gradientEnd: AppColors.homeGradBlueEnd,
      title: 'Reading',
      subtitle: 'Main Idea & Details',
      time: '10 min',
      levelLabel: 'Intermediate',
      levelBg: AppColors.homeBadgeIntermediateBg,
      levelBorder: AppColors.homeBadgeIntermediateBorder,
      levelText: AppColors.homeBadgeIntermediateText,
      highlighted: true,
      actionLabel: 'Start',
      actionFilled: true,
    ),
    _Lesson(
      number: 2,
      icon: 'assets/icons/onboarding/pencil.svg',
      gradientStart: AppColors.homeGradOrangeStart,
      gradientEnd: AppColors.homeGradOrangeEnd,
      title: 'Writing',
      subtitle: 'Task 2: Essay Structure',
      time: '15 min',
      levelLabel: 'Intermediate',
      levelBg: AppColors.homeBadgeIntermediateBg,
      levelBorder: AppColors.homeBadgeIntermediateBorder,
      levelText: AppColors.homeBadgeIntermediateText,
      highlighted: false,
      actionLabel: 'Up next',
      actionFilled: false,
    ),
    _Lesson(
      number: 3,
      icon: 'assets/icons/onboarding/diag_headphones.svg',
      gradientStart: AppColors.homeGradPurpleStart,
      gradientEnd: AppColors.homeGradPurpleEnd,
      title: 'Listening',
      subtitle: 'Section 2: Practice',
      time: '15 min',
      levelLabel: 'Beginner',
      levelBg: AppColors.homeBadgeBeginnerBg,
      levelBorder: AppColors.homeBadgeBeginnerBorder,
      levelText: AppColors.homeBadgeBeginnerText,
      highlighted: false,
      actionLabel: 'Up next',
      actionFilled: false,
    ),
  ];

  static const _quickActions = [
    _QuickAction(
      icon: 'assets/icons/home/mic_outline.svg',
      label: 'Practice Speaking',
      background: AppColors.homeQuickBlueBg,
      iconBackground: AppColors.homeQuickBlueIconBg,
      iconColor: AppColors.diagPrimary,
    ),
    _QuickAction(
      icon: 'assets/icons/home/clipboard.svg',
      label: 'Take Mock test',
      background: AppColors.homeQuickPurpleBg,
      iconBackground: AppColors.homeQuickPurpleIconBg,
      iconColor: Color(0xFF9333EA),
    ),
    _QuickAction(
      icon: 'assets/icons/onboarding/pencil.svg',
      label: 'Write an Essay',
      background: AppColors.homeQuickOrangeBg,
      iconBackground: AppColors.homeQuickOrangeIconBg,
      iconColor: AppColors.homeStreakText,
    ),
    _QuickAction(
      icon: 'assets/icons/home/chart_up.svg',
      label: 'Write an Essay',
      background: AppColors.homeQuickGreenBg,
      iconBackground: AppColors.homeQuickGreenIconBg,
      iconColor: AppColors.homeBadgeBeginnerText,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _buildHeader(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _buildEmailBanner(),
                    const SizedBox(height: 20),
                    _buildDailyGoalCard(context),
                    const SizedBox(height: 20),
                    _buildLessonsSection(),
                    const SizedBox(height: 20),
                    _buildStatsCard(),
                    const SizedBox(height: 20),
                    _buildQuickPracticeSection(),
                    const SizedBox(height: 20),
                    _buildInsightBanner(),
                  ],
                ),
              ),
            ),
            _buildBottomNav(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      color: AppColors.white,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/logo.svg',
            width: 29.33,
            height: 24,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Linguatude',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 32 / 24,
                color: AppColors.primary,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const StreakGamificationScreen(),
                ),
              );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.homeStreakBg,
                borderRadius: BorderRadius.circular(9999),
                border: Border.all(color: AppColors.homeStreakBorder),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('🔥', style: TextStyle(fontSize: 14)),
                  const SizedBox(width: 4),
                  Text(
                    '7',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 20 / 14,
                      color: AppColors.homeStreakText,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          SizedBox(
            width: 32,
            height: 32,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Center(
                  child: SvgPicture.asset(
                    'assets/icons/home/bell.svg',
                    width: 16,
                    height: 18,
                  ),
                ),
                Positioned(
                  right: 2,
                  top: 2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.homeNotifBadge,
                      shape: BoxShape.circle,
                      border: Border.fromBorderSide(
                        BorderSide(color: AppColors.white, width: 2),
                      ),
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

  Widget _buildEmailBanner() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.homeBannerBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.homeBannerBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.homeBannerIconBg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/home/mail.svg',
              width: 16,
              height: 12.4,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Please verify your email address.',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 20 / 14,
                    color: AppColors.homeBannerHeading,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Resend verification email',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 20 / 14,
                    color: AppColors.diagPrimary,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          SvgPicture.asset(
            'assets/icons/home/close.svg',
            width: 12,
            height: 12,
          ),
        ],
      ),
    );
  }

  Widget _buildDailyGoalCard(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.homeHeroBorder),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFEEF4FF), Color(0xFFEFF6FF), AppColors.white],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Container(
              width: 128,
              height: 128,
              decoration: const BoxDecoration(
                color: AppColors.homeHeroDecor,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(21),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Good morning, John!',
                  style: GoogleFonts.inter(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    height: 28 / 20,
                    color: AppColors.slate,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Let's make today count.",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 20 / 14,
                    color: AppColors.slateMuted,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    _buildGoalRing(context),
                    const SizedBox(width: 16),
                    Expanded(child: _buildCountdownCard()),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGoalRing(BuildContext context) {
    return GestureDetector(
      onTap: () => DailyGoalCompleteDialog.show(context),
      child: SizedBox(
        width: 140,
        height: 140,
        child: CustomPaint(
          painter: _RingPainter(progress: 2 / 3),
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "TODAY'S GOAL",
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                    height: 15 / 11,
                    letterSpacing: 0.5,
                    color: AppColors.dateHint,
                  ),
                ),
                const SizedBox(height: 4),
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '2',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.slate,
                        ),
                      ),
                      TextSpan(
                        text: ' of ',
                        style: GoogleFonts.inter(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: AppColors.dateHint,
                        ),
                      ),
                      TextSpan(
                        text: '3',
                        style: GoogleFonts.inter(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.slate,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'lessons done',
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                    height: 15 / 11,
                    color: AppColors.slateMuted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildCountdownCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.homeCountdownCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.homeCountdownCardBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/onboarding/calendar_sm.svg',
                width: 12,
                height: 14,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  '24 Aug, 2026',
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 16 / 12,
                    color: AppColors.dateHint,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '12 days',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 23 / 16,
                        color: AppColors.diagPrimary,
                      ),
                    ),
                    Text(
                      'to your test',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 17 / 12,
                        color: AppColors.slateMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 32,
                height: 32,
                decoration: const BoxDecoration(
                  color: AppColors.homeStatIconBg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/onboarding/chevron_right_blue.svg',
                  width: 5,
                  height: 9,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLessonsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                "Today's lessons",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 24 / 18,
                  color: AppColors.slate,
                ),
              ),
            ),
            Text(
              'View all',
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                height: 20 / 14,
                color: AppColors.diagPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < _lessons.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          _buildLessonCard(_lessons[i]),
        ],
      ],
    );
  }

  Widget _buildLessonCard(_Lesson lesson) {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: lesson.highlighted
              ? AppColors.homeLessonReadingBorder
              : AppColors.homeLessonBorder,
          width: lesson.highlighted ? 1.5 : 1,
        ),
        boxShadow: lesson.highlighted
            ? const [
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
              ]
            : const [
                BoxShadow(
                  color: Color(0x0D000000),
                  offset: Offset(0, 1),
                  blurRadius: 2,
                ),
              ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [lesson.gradientStart, lesson.gradientEnd],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: lesson.gradientEnd.withValues(alpha: 0.2),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                    BoxShadow(
                      color: lesson.gradientEnd.withValues(alpha: 0.15),
                      offset: const Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: -1,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  lesson.icon,
                  width: 22,
                  height: 22,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              Positioned(
                left: -4,
                top: -4,
                child: Container(
                  width: 16,
                  height: 16,
                  decoration: const BoxDecoration(
                    color: AppColors.diagPrimary,
                    shape: BoxShape.circle,
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    '${lesson.number}',
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  lesson.title,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 20 / 16,
                    color: AppColors.slate,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  lesson.subtitle,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 16 / 13,
                    color: AppColors.slateMuted,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/onboarding/diag_clock.svg',
                      width: 12,
                      height: 12,
                      colorFilter: const ColorFilter.mode(
                        AppColors.dateHint,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      lesson.time,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 17 / 12,
                        color: AppColors.dateHint,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 9,
                        vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color: lesson.levelBg,
                        borderRadius: BorderRadius.circular(9999),
                        border: Border.all(color: lesson.levelBorder),
                      ),
                      child: Text(
                        lesson.levelLabel,
                        style: GoogleFonts.inter(
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                          height: 15 / 10,
                          color: lesson.levelText,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          lesson.actionFilled
              ? Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: AppColors.diagPrimary,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.diagPrimary.withValues(alpha: 0.2),
                        offset: const Offset(0, 2),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    lesson.actionLabel,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 16 / 14,
                      color: AppColors.white,
                    ),
                  ),
                )
              : Container(
                  height: 32,
                  padding: const EdgeInsets.symmetric(horizontal: 13),
                  decoration: BoxDecoration(
                    color: AppColors.homeUpNextBg,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.homeUpNextBorder),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    lesson.actionLabel,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 16 / 14,
                      color: AppColors.diagPrimary,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.homeStatsCardBorder),
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
          Expanded(child: _buildStreakStat()),
          Container(width: 1, height: 43, color: AppColors.homeLessonBorder),
          Expanded(child: _buildLevelStat()),
          Container(width: 1, height: 43, color: AppColors.homeLessonBorder),
          Expanded(child: _buildCountdownStat()),
        ],
      ),
    );
  }

  Widget _buildStatLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        height: 15 / 12,
        color: AppColors.slateMuted,
      ),
    );
  }

  Widget _buildStreakStat() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('🔥', style: TextStyle(fontSize: 16)),
            const SizedBox(width: 6),
            Text(
              '7',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 23 / 16,
                color: AppColors.slate,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        _buildStatLabel('day streak'),
      ],
    );
  }

  Widget _buildLevelStat() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: const BoxDecoration(
                color: AppColors.diagPrimary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '3',
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Level 3',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 23 / 16,
                color: AppColors.slate,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        _buildStatLabel('420 XP'),
      ],
    );
  }

  Widget _buildCountdownStat() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              'assets/icons/onboarding/calendar_sm.svg',
              width: 12,
              height: 14,
            ),
            const SizedBox(width: 6),
            Text(
              '12 days',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 23 / 16,
                color: AppColors.diagPrimary,
              ),
            ),
          ],
        ),
        const SizedBox(height: 4),
        _buildStatLabel('to your test'),
      ],
    );
  }

  Widget _buildQuickPracticeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                'Quick practice',
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  height: 24 / 18,
                  color: AppColors.slate,
                ),
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View all',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 16 / 14,
                    color: AppColors.diagPrimary,
                  ),
                ),
                const SizedBox(width: 2),
                SvgPicture.asset(
                  'assets/icons/onboarding/chevron_right_blue.svg',
                  width: 4.9,
                  height: 8.75,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            for (var i = 0; i < _quickActions.length; i++) ...[
              if (i > 0) const SizedBox(width: 10),
              Expanded(child: _buildQuickActionCard(_quickActions[i])),
            ],
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActionCard(_QuickAction action) {
    return Container(
      clipBehavior: Clip.none,
      padding: const EdgeInsets.symmetric(vertical: 17, horizontal: 8),
      decoration: BoxDecoration(
        color: action.background,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.homeHeroBorder),
        boxShadow: [
          BoxShadow(
            color: action.iconColor.withValues(alpha: 0.16),
            offset: const Offset(0, 4),
            blurRadius: 4,
          ),
          BoxShadow(
            color: action.iconColor.withValues(alpha: 0.1),
            offset: const Offset(0, 6),
            blurRadius: 8,
            spreadRadius: -2,
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: action.iconBackground,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: action.iconColor.withValues(alpha: 0.25),
                      offset: const Offset(0, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  action.icon,
                  width: 18,
                  height: 18,
                  colorFilter: ColorFilter.mode(
                    action.iconColor,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      action.label,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 15 / 12,
                        color: AppColors.slate,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          Positioned(
            right: -4,
            top: -4,
            child: Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: action.iconColor.withValues(alpha: 0.2),
                    offset: const Offset(0, 1),
                    blurRadius: 3,
                  ),
                ],
              ),
              alignment: Alignment.center,
              child: SvgPicture.asset(
                'assets/icons/onboarding/chevron_right_blue.svg',
                width: 4,
                height: 7,
                colorFilter: ColorFilter.mode(
                  action.iconColor,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightBanner() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.homeBannerBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.homeBannerBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.homeInsightIconBg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/onboarding/results_star.svg',
              width: 15,
              height: 15,
              colorFilter: const ColorFilter.mode(
                AppColors.homeStreakText,
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
                  "TODAY'S INSIGHT",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 16 / 12,
                    letterSpacing: 0.6,
                    color: AppColors.resultsFocusText,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Your Writing improved 0.5 bands this week. Focus on '
                  'coherence today.',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                    height: 19 / 13,
                    color: AppColors.slateBody,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'See full progress',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 20 / 14,
                        color: AppColors.diagPrimary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset(
                      'assets/icons/onboarding/chevron_right_blue.svg',
                      width: 5,
                      height: 8.75,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.homeLessonBorder)),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _buildNavItem('assets/icons/home/home_nav.svg', 'Home', true),
            _buildNavItem(
              'assets/icons/onboarding/diag_book.svg',
              'Learn',
              false,
            ),
            _buildNavItem(
              'assets/icons/home/practice_nav.svg',
              'Practice',
              false,
            ),
            _buildNavItem(
              'assets/icons/home/mock_test_nav.svg',
              'Mock Test',
              false,
            ),
            _buildNavItem('assets/icons/home/person_nav.svg', 'Account', false),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(String icon, String label, bool active) {
    final color = active ? AppColors.diagPrimary : AppColors.homeNavInactive;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          icon,
          width: 20,
          height: 20,
          colorFilter: active ? null : ColorFilter.mode(color, BlendMode.srcIn),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            height: 15 / 11,
            color: color,
          ),
        ),
      ],
    );
  }
}

class _RingPainter extends CustomPainter {
  const _RingPainter({required this.progress});

  final double progress;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - 14) / 2;
    final trackPaint = Paint()
      ..color = AppColors.homeRingTrack
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14;
    canvas.drawCircle(center, radius, trackPaint);

    final progressPaint = Paint()
      ..color = AppColors.diagPrimary
      ..style = PaintingStyle.stroke
      ..strokeWidth = 14
      ..strokeCap = StrokeCap.round;
    final rect = Rect.fromCircle(center: center, radius: radius);
    canvas.drawArc(
      rect,
      -math.pi / 2,
      2 * math.pi * progress,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter oldDelegate) =>
      oldDelegate.progress != progress;
}
