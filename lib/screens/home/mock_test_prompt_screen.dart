import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../streak/streak_gamification_screen.dart';

/// DASH-004 — Quick Mock Test Prompt
/// Figma node 38:716 — pixel-faithful reset using attached SVG assets.
class MockTestPromptScreen extends StatelessWidget {
  const MockTestPromptScreen({super.key});

  static const _mockIcons = 'assets/icons/home/mock';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.mockScreenBg,
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
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      color: AppColors.white,
      child: Row(
        children: [
          SvgPicture.asset(
            'assets/icons/logo.svg',
            width: 29.33,
            height: 24,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 9.67),
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
              height: 30,
              padding: const EdgeInsets.symmetric(horizontal: 11),
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
                      height: 16 / 14,
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
                  right: 4,
                  top: 4,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: AppColors.homeNotifBadge,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 2),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Good morning John',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 28 / 24,
                color: AppColors.mockTitle,
              ),
            ),
            const SizedBox(width: 2),
            const Text('👋', style: TextStyle(fontSize: 22)),
          ],
        ),
        const SizedBox(height: 2),
        Text(
          "Let's continue your preparation",
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w400,
            height: 16 / 12,
            color: AppColors.slateMuted,
          ),
        ),
      ],
    );
  }

  Widget _recommendedCard() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.mockCardBg,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.mockCardShadow,
            blurRadius: 6,
            offset: Offset(0, 4),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: AppColors.mockCardShadow,
            blurRadius: 15,
            offset: Offset(0, 10),
            spreadRadius: -3,
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned(
            right: -24,
            bottom: -24,
            child: Opacity(
              opacity: 0.15,
              child: SvgPicture.asset(
                '$_mockIcons/target_deco.svg',
                width: 160,
                height: 160,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SvgPicture.asset(
                        '$_mockIcons/star.svg',
                        width: 10,
                        height: 10,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Recommended today',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          height: 16 / 12,
                          color: AppColors.mockTagText,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Time for a mock test',
                  style: GoogleFonts.inter(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    height: 28 / 22,
                    color: AppColors.mockTitle,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "You've been practising for 12 days. A full mock test shows your real progress.",
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                    height: 20 / 14,
                    color: AppColors.mockDescription,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _metaBadge(
                      icon: '$_mockIcons/clock.svg',
                      label: '45 minutes',
                    ),
                    const SizedBox(width: 8),
                    _metaBadge(
                      icon: '$_mockIcons/skills_grid.svg',
                      label: 'All 4 skills',
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  height: 44,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mockButton,
                      foregroundColor: AppColors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      'Start Mock Test',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        height: 20 / 14,
                        color: AppColors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Center(
                  child: Text(
                    'Remind me tomorrow',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 16 / 12,
                      color: AppColors.mockSecondaryLink,
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

  Widget _metaBadge({required String icon, required String label}) {
    return Container(
      height: 28,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppColors.mockBadgeBg,
        borderRadius: BorderRadius.circular(9999),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon, width: 14, height: 14),
          const SizedBox(width: 6),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 16 / 12,
              color: AppColors.mockBadgeText,
            ),
          ),
        ],
      ),
    );
  }

  Widget _quickAccessSection() {
    return Column(
      children: [
        Row(
          children: [
            Text(
              'Quick access',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w700,
                height: 20 / 16,
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
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    height: 16 / 12,
                    color: AppColors.mockButton,
                  ),
                ),
                const SizedBox(width: 2),
                SvgPicture.asset(
                  '$_mockIcons/chevron_right.svg',
                  width: 12,
                  height: 12,
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
                icon: '$_mockIcons/study_icon.svg',
                title: 'Study',
                subtitle: 'Continue learning your skills',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _quickCard(
                icon: '$_mockIcons/practice_icon.svg',
                title: 'Practice',
                subtitle: 'Try questions and improve',
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(
              child: _quickCard(
                icon: '$_mockIcons/progress_icon.svg',
                title: 'Progress',
                subtitle: 'Track your performance',
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: _quickCard(
                icon: '$_mockIcons/plan_icon.svg',
                title: 'Plan',
                subtitle: 'See your study plan',
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _quickCard({
    required String icon,
    required String title,
    required String subtitle,
  }) {
    return Container(
      constraints: const BoxConstraints(minHeight: 73),
      padding: const EdgeInsets.fromLTRB(15, 15, 12, 15),
      decoration: BoxDecoration(
        color: AppColors.quickCardBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.quickCardBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SvgPicture.asset(icon, width: 40, height: 40),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    height: 16 / 14,
                    color: AppColors.mockTitle,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    height: 14 / 11,
                    color: AppColors.quickCardSubtitle,
                  ),
                ),
              ],
            ),
          ),
          Text(
            '>',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: AppColors.quickCardChevron,
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNavBar() {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          top: BorderSide(color: AppColors.mockNavBorder),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _navItem(
            icon: '$_mockIcons/home_nav.svg',
            label: 'Home',
            active: true,
          ),
          _navItem(
            icon: '$_mockIcons/learn_nav.svg',
            label: 'Learn',
            active: false,
          ),
          _navItem(
            icon: '$_mockIcons/practice_nav.svg',
            label: 'Practice',
            active: false,
          ),
          _navItem(
            icon: '$_mockIcons/mock_nav.svg',
            label: 'Mock Test',
            active: false,
            iconSize: 24,
          ),
          _navItem(
            icon: '$_mockIcons/progress_nav.svg',
            label: 'Progress',
            active: false,
          ),
          _navItem(
            icon: '$_mockIcons/account_nav.svg',
            label: 'Account',
            active: false,
          ),
        ],
      ),
    );
  }

  Widget _navItem({
    required String icon,
    required String label,
    required bool active,
    double iconSize = 20,
  }) {
    final color =
        active ? AppColors.mockButton : AppColors.homeNavInactive;
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            icon,
            width: iconSize,
            height: iconSize,
            colorFilter:
                active ? null : ColorFilter.mode(color, BlendMode.srcIn),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 10,
              fontWeight: FontWeight.w500,
              height: 15 / 10,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
