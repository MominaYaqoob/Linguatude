import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';

/// DASH-003 — Streak & Gamification screen.
class StreakGamificationScreen extends StatelessWidget {
  const StreakGamificationScreen({super.key});

  static const _weeks = 12;
  // 0 = future, 1 = missed, 2 = completed, 3 = today.
  static final List<List<int>> _heatmap = List.generate(7, (day) {
    return List.generate(_weeks, (week) {
      if (week == _weeks - 1) {
        if (day < 4) return 2;
        if (day == 4) return 3;
        return 0;
      }
      final seed = (day * 13 + week * 7) % 10;
      return seed < 2 ? 1 : 2;
    });
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _header(context),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _streakHeroCard(),
                    const SizedBox(height: 24),
                    _yourProgressCard(),
                    const SizedBox(height: 24),
                    _activityHeatmapCard(),
                    const SizedBox(height: 24),
                    _achievementsSection(),
                    const SizedBox(height: 16),
                    _statRow(
                      icon: Icons.menu_book_rounded,
                      iconColor: AppColors.streakStatBlue,
                      iconBg: AppColors.streakStatIconBlueBg,
                      value: '48',
                      label: 'Lessons complete',
                    ),
                    const SizedBox(height: 12),
                    _statRow(
                      icon: Icons.workspace_premium_rounded,
                      iconColor: AppColors.streakStatPurple,
                      iconBg: AppColors.streakStatIconPurpleBg,
                      value: '6',
                      label: 'Skills mastered',
                    ),
                    const SizedBox(height: 12),
                    _statRow(
                      icon: Icons.assignment_turned_in_rounded,
                      iconColor: AppColors.streakStatAmber,
                      iconBg: AppColors.streakStatIconAmberBg,
                      value: '3',
                      label: 'Mock tests done',
                    ),
                    const SizedBox(height: 12),
                    _statRow(
                      icon: Icons.access_time_filled_rounded,
                      iconColor: AppColors.streakStatGreen,
                      iconBg: AppColors.streakStatIconGreenBg,
                      value: '24h 35m',
                      label: 'Total Study time',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
    return Container(
      height: 72,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).maybePop(),
            icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
            color: AppColors.slate,
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
          const SizedBox(width: 40),
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
            blurRadius: 25,
            spreadRadius: -5,
          ),
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: 64,
                height: 64,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      AppColors.streakFlameEnd,
                      AppColors.streakFlameStart,
                    ],
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Color(0x33F97316),
                      offset: Offset(0, 4),
                      blurRadius: 10,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Text('🔥', style: TextStyle(fontSize: 32)),
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
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.5,
                        color: AppColors.slateMuted,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: '7 ',
                            style: GoogleFonts.inter(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: AppColors.slate,
                            ),
                          ),
                          TextSpan(
                            text: 'days',
                            style: GoogleFonts.inter(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              color: AppColors.streakFlameStart,
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
          const SizedBox(height: 24),
          Container(height: 1, color: AppColors.streakDivider),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: _heroStat(
                  child: SvgPicture.asset(
                    'assets/icons/streak/star_gold.svg',
                    width: 17,
                    height: 16,
                  ),
                  bg: const Color(0xFFFFEDD0),
                  title: 'Personal best',
                  value: '14 days',
                ),
              ),
              Expanded(
                child: _heroStat(
                  child: const Icon(
                    Icons.ac_unit_rounded,
                    size: 18,
                    color: Color(0xFF38BDF8),
                  ),
                  bg: AppColors.white,
                  title: 'Streak Freezes',
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
    required Widget child,
    required Color bg,
    required String title,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          width: 36,
          height: 36,
          decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
          alignment: Alignment.center,
          child: child,
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
                  fontWeight: FontWeight.w400,
                  color: AppColors.slateMuted,
                ),
              ),
              Text(
                value,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: AppColors.slate,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _yourProgressCard() {
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
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.streakLevelBadgeBg,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: const [
                    BoxShadow(
                      color: AppColors.streakLevelBadgeShadow,
                      offset: Offset(0, 4),
                      blurRadius: 6,
                      spreadRadius: -1,
                    ),
                  ],
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.star_rounded,
                  color: AppColors.white,
                  size: 24,
                ),
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
                        const SizedBox(width: 6),
                        Icon(
                          Icons.chevron_right_rounded,
                          size: 16,
                          color: AppColors.slateMuted.withValues(alpha: 0.6),
                        ),
                        const SizedBox(width: 2),
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
                        fontWeight: FontWeight.w400,
                        color: AppColors.slateMuted,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.streakLockedBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: const Color(0xFFC3CBD8)),
                ),
                alignment: Alignment.center,
                child: const Icon(
                  Icons.lock_rounded,
                  size: 18,
                  color: AppColors.streakLockedIcon,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: 0.65,
              minHeight: 12,
              backgroundColor: const Color(0xFFF1F5F9),
              valueColor: const AlwaysStoppedAnimation(
                AppColors.streakLevelBadgeBg,
              ),
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () {},
              icon: const Icon(
                Icons.north_east_rounded,
                size: 16,
                color: AppColors.streakLevelBadgeBg,
              ),
              label: Text(
                'Next: Adventurer at 1,000 XP',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.streakLevelBadgeBg,
                ),
              ),
              style: OutlinedButton.styleFrom(
                backgroundColor: AppColors.streakHeroBg,
                side: const BorderSide(color: AppColors.streakHeroBorder),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _activityHeatmapCard() {
    const dayLabels = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
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
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(left: 22),
            child: Row(
              children: const [
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
          ),
          const SizedBox(height: 8),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: 22,
                child: Column(
                  children: [
                    for (var d = 0; d < dayLabels.length; d++)
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4),
                        child: SizedBox(
                          height: 10,
                          child: Text(
                            d.isEven ? dayLabels[d] : '',
                            style: GoogleFonts.inter(
                              fontSize: 9,
                              color: AppColors.slateMuted,
                            ),
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
        color = AppColors.white;
        child = const Icon(
          Icons.star_rounded,
          size: 6,
          color: AppColors.streakLevelBadgeBg,
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
            border: state == 3
                ? Border.all(color: AppColors.streakLevelBadgeBg, width: 1)
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
          child: const Icon(
            Icons.star_rounded,
            size: 8,
            color: AppColors.white,
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
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 14,
                  color: AppColors.streakLevelBadgeBg,
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
                '🔥',
                'Streak',
                '7-Day Streak',
                AppColors.streakBadgeOrangeStart,
                AppColors.streakBadgeOrangeEnd,
              ),
              const SizedBox(width: 12),
              _badgeCard(
                '⏱',
                'Streak',
                'Dedicated 10',
                AppColors.streakBadgeTealStart,
                AppColors.streakBadgeTealEnd,
              ),
              const SizedBox(width: 12),
              _badgeCard(
                '✓',
                'Streak',
                'Time Master',
                AppColors.streakBadgePurpleStart,
                AppColors.streakBadgePurpleEnd,
              ),
              const SizedBox(width: 12),
              _badgeCard(
                '📖',
                'Streak',
                'Lesson Lover',
                AppColors.streakBadgeBlueStart,
                AppColors.streakBadgeBlueEnd,
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

  Widget _badgeCard(
    String emoji,
    String kicker,
    String title,
    Color start,
    Color end,
  ) {
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
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [start, end],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: end.withValues(alpha: 0.3),
                  offset: const Offset(0, 4),
                  blurRadius: 6,
                  spreadRadius: -1,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: Text(emoji, style: const TextStyle(fontSize: 24)),
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
            decoration: const BoxDecoration(
              color: AppColors.streakLockedBg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.lock_rounded,
              size: 24,
              color: AppColors.streakLockedIcon,
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
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String value,
    required String label,
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
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(icon, size: 20, color: iconColor),
          ),
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
              color: iconColor,
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
