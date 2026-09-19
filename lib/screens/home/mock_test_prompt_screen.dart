import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../streak/streak_gamification_screen.dart';

/// DASH-004 — Quick Mock Test Prompt (Home variant shown once the
/// diagnostic period is done and a full mock test is recommended).
class MockTestPromptScreen extends StatelessWidget {
  const MockTestPromptScreen({super.key});

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
                padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _greeting(),
                    const SizedBox(height: 24),
                    _recommendedCard(),
                    const SizedBox(height: 24),
                    _quickAccessSection(),
                  ],
                ),
              ),
            ),
            _bottomNavBar(),
          ],
        ),
      ),
    );
  }

  Widget _header(BuildContext context) {
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
                const Center(
                  child: Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.slateSoft,
                    size: 24,
                  ),
                ),
                Positioned(
                  right: -1,
                  top: -1,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: AppColors.homeNotifBadge,
                      shape: BoxShape.circle,
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

  Widget _greeting() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Flexible(
                    child: Text(
                      'Good morning, John!',
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        height: 28 / 20,
                        color: AppColors.mockTitle,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  const Text('👋', style: TextStyle(fontSize: 20)),
                ],
              ),
              const SizedBox(height: 2),
              Text(
                "Let's continue your preparation",
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: AppColors.slateMuted,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _recommendedCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.mockCardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.mockCardShadow,
            offset: Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
          ),
          BoxShadow(
            color: AppColors.mockCardShadow,
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.75),
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star_rounded,
                  size: 14,
                  color: AppColors.mockTagText,
                ),
                const SizedBox(width: 6),
                Text(
                  'Recommended today',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.mockTagText,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Time for a mock test',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 28 / 20,
              color: AppColors.mockTitle,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            "You've been practising for 12 days. A full mock test shows your real progress.",
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 18 / 13,
              color: AppColors.mockDescription,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _mockBadge(Icons.access_time_rounded, '45 minutes'),
              const SizedBox(width: 8),
              _mockBadge(Icons.grid_view_rounded, 'All 4 skills'),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
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
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryButton,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  shadowColor: Colors.transparent,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'Start Mock Test',
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.white,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Center(
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Remind me tomorrow',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mockSecondaryLink,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _mockBadge(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
        decoration: BoxDecoration(
          color: AppColors.mockBadgeBg,
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
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppColors.mockBadgeIcon),
            const SizedBox(width: 6),
            Flexible(
              child: Text(
                label,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.mockBadgeText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _quickAccessSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Quick access',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                color: AppColors.mockTitle,
              ),
            ),
            const Spacer(),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View all',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryButton,
                  ),
                ),
                const SizedBox(width: 2),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 16,
                  color: AppColors.primaryButton,
                ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _quickCard(
                icon: Icons.menu_book_rounded,
                iconBg: AppColors.quickStudyIconBg,
                iconColor: AppColors.quickStudyIcon,
                title: 'Study',
                subtitle: 'Continue\nlearning your skills',
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _quickCard(
                icon: Icons.verified_user_rounded,
                iconBg: AppColors.quickPracticeIconBg,
                iconColor: AppColors.quickPracticeIcon,
                title: 'Practice',
                subtitle: 'Try questions\nand improve',
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Row(
          children: [
            Expanded(
              child: _quickCard(
                icon: Icons.bar_chart_rounded,
                iconBg: AppColors.quickProgressIconBg,
                iconColor: AppColors.quickProgressIcon,
                title: 'Progress',
                subtitle: 'Track your\nperformance',
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: _quickCard(
                icon: Icons.calendar_today_rounded,
                iconBg: AppColors.quickPlanIconBg,
                iconColor: AppColors.quickPlanIcon,
                title: 'Plan',
                subtitle: 'See your study\nplan',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _quickCard({
    required IconData icon,
    required Color iconBg,
    required Color iconColor,
    required String title,
    required String subtitle,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.quickCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.quickCardBorder),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: iconBg,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: iconColor),
                ),
                alignment: Alignment.center,
                child: Icon(icon, size: 20, color: iconColor),
              ),
              const Icon(
                Icons.chevron_right_rounded,
                size: 16,
                color: AppColors.quickCardChevron,
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            title,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              color: AppColors.quickCardTitle,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            subtitle,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w400,
              height: 15 / 11,
              color: AppColors.quickCardSubtitle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavBar() {
    final items = [
      (Icons.home_rounded, 'Home', true),
      (Icons.menu_book_rounded, 'Learn', false),
      (Icons.fitness_center_rounded, 'Practice', false),
      (Icons.assignment_rounded, 'Mock Test', false),
      (Icons.bar_chart_rounded, 'Progress', false),
      (Icons.person_rounded, 'Account', false),
    ];
    return Container(
      height: 64,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.gray100)),
      ),
      child: Row(
        children: [
          for (final item in items)
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    item.$1,
                    size: 20,
                    color: item.$3
                        ? AppColors.primaryButton
                        : AppColors.homeNavInactive,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.$2,
                    style: GoogleFonts.inter(
                      fontSize: 9,
                      fontWeight: FontWeight.w600,
                      color: item.$3
                          ? AppColors.primaryButton
                          : AppColors.homeNavInactive,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
