import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:linguatude/theme/app_colors.dart';
import 'package:linguatude/widgets/app_bottom_nav.dart';

class StreakGamificationScreen extends StatelessWidget {
  const StreakGamificationScreen({super.key});

  static const _mockIcons = 'assets/icons/home/mock';
  static const int _weeks = 12;
  static const List<String> _dayLabels = [
    'Mon',
    'Tue',
    'Wed',
    'Thu',
    'Fri',
    'Sat',
    'Sun',
  ];

  /// 0 = missed, 1 = future, 2 = completed, 3 = today
  static const List<List<int>> _heatmap = [
    [2, 0, 2, 0, 2, 2, 2, 0, 2, 2, 2, 2],
    [2, 0, 2, 2, 2, 2, 2, 0, 2, 2, 2, 1],
    [2, 2, 2, 2, 2, 2, 2, 0, 2, 2, 0, 1],
    [2, 2, 2, 2, 2, 2, 2, 0, 2, 2, 2, 1],
    [2, 2, 2, 2, 2, 0, 0, 0, 2, 2, 2, 3],
    [2, 2, 2, 2, 2, 2, 0, 0, 2, 2, 2, 1],
    [2, 2, 2, 2, 2, 2, 2, 0, 2, 2, 2, 1],
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            _header(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _streakHeroCard(),
                    const SizedBox(height: 24),
                    _progressCard(),
                    const SizedBox(height: 24),
                    _activityCard(),
                    const SizedBox(height: 24),
                    _achievementsSection(),
                    const SizedBox(height: 24),
                    Text(
                      'Learning Statistics',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color: AppColors.slate,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _statRow(
                      iconAsset: 'assets/icons/streak/stat_lessons.svg',
                      value: '48',
                      label: 'Lessons complete',
                      valueColor: AppColors.streakLevelBadgeBg,
                    ),
                    const SizedBox(height: 8),
                    _statRow(
                      iconAsset: 'assets/icons/streak/stat_skills.svg',
                      value: '6',
                      label: 'Skills mastered',
                      valueColor: AppColors.streakBadgePurpleEnd,
                    ),
                    const SizedBox(height: 8),
                    _statRow(
                      iconAsset: 'assets/icons/streak/stat_mock.svg',
                      value: '3',
                      label: 'Mock tests done',
                      valueColor: const Color(0xFFD97706),
                    ),
                    const SizedBox(height: 8),
                    _statRow(
                      iconAsset: 'assets/icons/streak/stat_time.svg',
                      value: '24h 35m',
                      label: 'Total Study time',
                      valueColor: AppColors.streakBadgeTealEnd,
                    ),
                  ],
                ),
              ),
            ),
            _bottomNav(context),
          ],
        ),
      ),
    );
  }

  Widget _bottomNav(BuildContext context) {
    return AppBottomNav(
      items: [
        AppBottomNavItem(
          icon: '$_mockIcons/home_nav.svg',
          label: 'Home',
          active: true,
          onTap: () => Navigator.of(context).maybePop(),
        ),
        const AppBottomNavItem(
          icon: '$_mockIcons/learn_nav.svg',
          label: 'Learn',
        ),
        const AppBottomNavItem(
          icon: '$_mockIcons/practice_nav.svg',
          label: 'Practice',
        ),
        const AppBottomNavItem(
          icon: '$_mockIcons/mock_nav.svg',
          label: 'Mock Test',
          iconSize: 22,
        ),
        const AppBottomNavItem(
          icon: '$_mockIcons/progress_nav.svg',
          label: 'Progress',
        ),
        const AppBottomNavItem(
          icon: '$_mockIcons/account_nav.svg',
          label: 'Account',
        ),
      ],
    );
  }

  Widget _header(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 8, 16, 16),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: SvgPicture.asset(
              'assets/icons/streak/back.svg',
              width: 24,
              height: 24,
            ),
          ),
          Expanded(
            child: Text(
              'Streak & Gamification',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: AppColors.slate,
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }

  Widget _streakHeroCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.streakHeroBg,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.streakHeroBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 8),
            blurRadius: 10,
            spreadRadius: -6,
          ),
          BoxShadow(
            color: Color(0x1A000000),
            offset: Offset(0, 20),
            blurRadius: 25,
            spreadRadius: -5,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/streak/flame.svg',
                width: 64,
                height: 64,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'CURRENT STREAK',
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.8,
                        color: AppColors.black,
                      ),
                    ),
                    const SizedBox(height: 4),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: '7',
                            style: GoogleFonts.inter(
                              fontSize: 36,
                              fontWeight: FontWeight.w800,
                              color: AppColors.black,
                              height: 1.1,
                            ),
                          ),
                          TextSpan(
                            text: ' days',
                            style: GoogleFonts.inter(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: AppColors.streakFlameOrange,
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
          const SizedBox(height: 16),
          const Divider(height: 1, color: Color(0x99334155)),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _heroStat(
                  iconAsset: 'assets/icons/streak/personal_best.svg',
                  label: 'Personal best',
                  value: '14 days',
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _heroStat(
                  iconAsset: 'assets/icons/streak/streak_freeze.svg',
                  label: 'Streak Freezes',
                  value: '2 available',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroStat({
    required String iconAsset,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        SvgPicture.asset(iconAsset, width: 36, height: 36),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  color: AppColors.black,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: AppColors.streakHeroValue,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _progressCard() {
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.streakCardBorder, width: 2),
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
          Text(
            'Your Progress',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.slate,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/streak/level_badge.svg',
                width: 48,
                height: 48,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          'Level 3',
                          style: GoogleFonts.inter(
                            fontSize: 16,
                            fontWeight: FontWeight.w700,
                            color: AppColors.slate,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 6),
                          child: Container(
                            width: 16,
                            height: 1.5,
                            color: AppColors.streakDivider,
                          ),
                        ),
                        Text(
                          'Explorer',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.streakLevelBadgeBg,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '650 / 1,000 XP',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.slateMuted,
                      ),
                    ),
                  ],
                ),
              ),
              SvgPicture.asset(
                'assets/icons/streak/lock_badge.svg',
                width: 40,
                height: 40,
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(999),
            child: const LinearProgressIndicator(
              value: 0.65,
              minHeight: 12,
              backgroundColor: AppColors.gray100,
              valueColor: AlwaysStoppedAnimation(AppColors.streakLevelBadgeBg),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            width: double.infinity,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.streakHeroBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.streakLevelBadgeBg),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/icons/streak/chart_up.svg',
                  width: 16,
                  height: 16,
                ),
                const SizedBox(width: 8),
                Text(
                  'Next: Adventurer at 1,000 XP',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.streakLevelBadgeBg,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.streakCardBorder, width: 2),
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
          Text(
            'Your activity — last 12 weeks',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: AppColors.slate,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: const [
              SizedBox(width: 28),
              Expanded(child: _MonthLabel('Jun')),
              Expanded(child: _MonthLabel('Jul')),
              Expanded(child: _MonthLabel('Aug')),
              Expanded(
                child: _MonthLabel(
                  'This week',
                  color: AppColors.streakLevelBadgeBg,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 28,
                child: Column(
                  children: [
                    for (final day in _dayLabels)
                      SizedBox(
                        height: 15,
                        child: Text(
                          day,
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: AppColors.slateMuted,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    for (var day = 0; day < 7; day++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: Row(
                          children: [
                            for (var week = 0; week < _weeks; week++)
                              Expanded(child: _heatCell(_heatmap[day][week])),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 18,
            runSpacing: 8,
            children: [
              _legendItem(AppColors.streakHeatmapFilled, 'Completed'),
              _legendItem(AppColors.streakHeatmapMissed, 'Missed'),
              _legendItem(
                AppColors.white,
                'Future',
                border: AppColors.streakHeatmapMissed,
              ),
              _legendStar(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heatCell(int state) {
    Color color;
    Widget? child;
    switch (state) {
      case 2:
        color = AppColors.streakHeatmapFilled;
        break;
      case 3:
        color = AppColors.streakHeatmapFilled;
        child = SvgPicture.asset(
          'assets/icons/home/goal/star.svg',
          width: 7,
          height: 7,
          colorFilter: const ColorFilter.mode(
            AppColors.white,
            BlendMode.srcIn,
          ),
        );
        break;
      case 1:
        color = AppColors.streakHeatmapFuture;
        break;
      default:
        color = AppColors.streakHeatmapMissed;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(2),
            border: state == 1
                ? Border.all(color: AppColors.streakHeatmapMissed)
                : null,
          ),
          alignment: Alignment.center,
          child: child,
        ),
      ),
    );
  }

  Widget _legendItem(Color color, String label, {Color? border}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            border: border != null ? Border.all(color: border) : null,
          ),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 12, color: AppColors.slateSoft),
        ),
      ],
    );
  }

  Widget _legendStar() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: const BoxDecoration(color: AppColors.streakLevelBadgeBg),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'assets/icons/home/goal/star.svg',
            width: 8,
            height: 8,
            colorFilter: const ColorFilter.mode(
              AppColors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
        const SizedBox(width: 6),
        Text(
          'Today',
          style: GoogleFonts.inter(fontSize: 12, color: AppColors.slateSoft),
        ),
      ],
    );
  }

  Widget _achievementsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Achievements',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.slate,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'See all',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.streakLevelBadgeBg,
                  ),
                ),
                const SizedBox(width: 2),
                SvgPicture.asset(
                  'assets/icons/streak/chevron_right.svg',
                  width: 16,
                  height: 16,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 135,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _badgeCard(
                child: Text(
                  '7',
                  style: GoogleFonts.inter(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                title: '7-Day Streak',
                start: AppColors.streakBadgeOrangeStart,
                end: AppColors.streakBadgeOrangeEnd,
              ),
              const SizedBox(width: 12),
              _badgeCard(
                child: Text(
                  '10',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    color: AppColors.white,
                  ),
                ),
                title: 'Dedicated 10',
                start: AppColors.streakBadgeTealStart,
                end: AppColors.streakBadgeTealEnd,
              ),
              const SizedBox(width: 12),
              _badgeCard(
                child: SvgPicture.asset(
                  'assets/icons/home/goal/clock.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
                title: 'Time Master',
                start: AppColors.streakBadgePurpleStart,
                end: AppColors.streakBadgePurpleEnd,
              ),
              const SizedBox(width: 12),
              _badgeCard(
                child: SvgPicture.asset(
                  'assets/icons/home/goal/book.svg',
                  width: 28,
                  height: 28,
                  colorFilter: const ColorFilter.mode(
                    AppColors.white,
                    BlendMode.srcIn,
                  ),
                ),
                title: 'Lesson Lover',
                start: AppColors.streakBadgeBlueStart,
                end: AppColors.streakBadgeBlueEnd,
              ),
              const SizedBox(width: 12),
              _lockedBadgeCard('30-Day Streak'),
              const SizedBox(width: 12),
              _lockedBadgeCard('Perfectionist'),
            ],
          ),
        ),
      ],
    );
  }

  Widget _badgeCard({
    required Widget child,
    required String title,
    required Color start,
    required Color end,
  }) {
    return Container(
      width: 144,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.streakBadgeCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.streakBadgeCardBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                colors: [start, end],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
              boxShadow: [
                BoxShadow(
                  color: end.withValues(alpha: 0.2),
                  offset: const Offset(0, 2),
                  blurRadius: 4,
                  spreadRadius: -2,
                ),
                BoxShadow(
                  color: end.withValues(alpha: 0.2),
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: -1,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: child,
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.slate,
            ),
          ),
        ],
      ),
    );
  }

  Widget _lockedBadgeCard(String title) {
    return Container(
      width: 144,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray100),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: AppColors.streakLockedBg,
              borderRadius: BorderRadius.circular(16),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/streak/lock.svg',
              width: 24,
              height: 24,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.slate,
            ),
          ),
        ],
      ),
    );
  }

  Widget _statRow({
    required String iconAsset,
    required String value,
    required String label,
    required Color valueColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray100),
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
      child: Row(
        children: [
          SvgPicture.asset(iconAsset, width: 40, height: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: AppColors.slateSoft,
              ),
            ),
          ),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: valueColor,
            ),
          ),
        ],
      ),
    );
  }
}

class _MonthLabel extends StatelessWidget {
  const _MonthLabel(this.text, {this.color});

  final String text;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: color ?? AppColors.slateMuted,
      ),
    );
  }
}
