import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../../widgets/dashboard/daily_goal_complete_dialog.dart';

/// DASH-001 — Home dashboard, with the DASH-002 "Daily goal complete"
/// overlay wired to show once all of today's lessons are marked done.
class DashboardHomeScreen extends StatefulWidget {
  const DashboardHomeScreen({super.key});

  @override
  State<DashboardHomeScreen> createState() => _DashboardHomeScreenState();
}

class _DashboardHomeScreenState extends State<DashboardHomeScreen> {
  final Set<String> _completedLessons = {};
  static const _totalLessons = 3;

  void _completeLesson(String id) {
    if (_completedLessons.contains(id)) return;
    setState(() => _completedLessons.add(id));
    if (_completedLessons.length == _totalLessons) {
      Future.delayed(const Duration(milliseconds: 250), () {
        if (mounted) DailyGoalCompleteDialog.show(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashBg,
      body: SafeArea(
        child: Column(
          children: [
            _mainHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _heroCard(),
                    const SizedBox(height: 24),
                    _sectionHeader("Today's Lessons"),
                    const SizedBox(height: 12),
                    _lessonCard(
                      id: 'reading',
                      icon: Icons.menu_book_rounded,
                      iconColor: AppColors.dashReadingIcon,
                      iconBg: AppColors.dashReadingIconBg,
                      title: 'Reading',
                      subtitle: 'Skimming & scanning · 12 min',
                      minutes: '12 min',
                    ),
                    const SizedBox(height: 12),
                    _lessonCard(
                      id: 'writing',
                      icon: Icons.edit_note_rounded,
                      iconColor: AppColors.dashWritingIcon,
                      iconBg: AppColors.dashWritingIconBg,
                      title: 'Writing',
                      subtitle: 'Task 2 essay structure · 15 min',
                      minutes: '15 min',
                    ),
                    const SizedBox(height: 12),
                    _lessonCard(
                      id: 'listening',
                      icon: Icons.headphones_rounded,
                      iconColor: AppColors.dashListeningIcon,
                      iconBg: AppColors.dashListeningIconBg,
                      title: 'Listening',
                      subtitle: 'Note completion · 10 min',
                      minutes: '10 min',
                    ),
                    const SizedBox(height: 24),
                    _statsSummaryCard(),
                    const SizedBox(height: 24),
                    _sectionHeader('Quick Practice'),
                    const SizedBox(height: 12),
                    _quickPracticeGrid(),
                    const SizedBox(height: 24),
                    _insightBanner(),
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

  Widget _mainHeader() {
    return Container(
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.outline)),
      ),
      child: Row(
        children: [
          const Icon(Icons.bolt_rounded, color: AppColors.primaryButton, size: 24),
          const SizedBox(width: 8),
          Text(
            'Linguatude',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: AppColors.slate,
            ),
          ),
          const Spacer(),
          const Text('🔥', style: TextStyle(fontSize: 16)),
          const SizedBox(width: 4),
          Text(
            '7',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              color: AppColors.slate,
            ),
          ),
          const SizedBox(width: 16),
          Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.notifications_none_rounded, color: AppColors.slateSoft, size: 24),
              Positioned(
                right: -1,
                top: -1,
                child: Container(
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: AppColors.dashBellDot,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _heroCard() {
    final done = _completedLessons.length;
    return Container(
      padding: const EdgeInsets.all(21),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.dashHeroGradientStart, AppColors.dashHeroGradientEnd],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(color: AppColors.dashCardShadow, offset: Offset(0, 8), blurRadius: 20),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Good morning, John!',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 28 / 20,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "Let's make today count.",
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              SizedBox(
                width: 112,
                height: 112,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox.expand(
                      child: CircularProgressIndicator(
                        value: done / _totalLessons,
                        strokeWidth: 8,
                        backgroundColor: AppColors.dashRingTrack,
                        valueColor: const AlwaysStoppedAnimation(AppColors.dashRingProgress),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "TODAY'S GOAL",
                          style: GoogleFonts.inter(
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
                            letterSpacing: 0.5,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$done/$_totalLessons',
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: AppColors.white,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'lessons done',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.white.withValues(alpha: 0.8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(17),
                  decoration: BoxDecoration(
                    color: AppColors.dashCountdownBg,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.event_rounded, size: 14, color: AppColors.white),
                          const SizedBox(width: 6),
                          Text(
                            'Next test date',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: Colors.white.withValues(alpha: 0.85),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        '18 days',
                        style: GoogleFonts.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                      Text(
                        'until your test',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _sectionHeader(String title) {
    return Row(
      children: [
        Text(
          title,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            color: AppColors.slate,
          ),
        ),
        const Spacer(),
        Text(
          'View all',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: AppColors.primaryButton,
          ),
        ),
      ],
    );
  }

  Widget _lessonCard({
    required String id,
    required IconData icon,
    required Color iconColor,
    required Color iconBg,
    required String title,
    required String subtitle,
    required String minutes,
  }) {
    final done = _completedLessons.contains(id);
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.outline),
        boxShadow: const [
          BoxShadow(color: AppColors.dashCardShadow, offset: Offset(0, 2), blurRadius: 8),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(color: iconBg, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Icon(icon, size: 24, color: iconColor),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    color: AppColors.slate,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    color: AppColors.slateMuted,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          if (done)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.dashDoneBadgeBg,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Done',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  color: AppColors.dashDoneBadgeText,
                ),
              ),
            )
          else
            SizedBox(
              height: 32,
              child: ElevatedButton(
                onPressed: () => _completeLesson(id),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryButton,
                  foregroundColor: AppColors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
                child: Text(
                  'Start',
                  style: GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _statsSummaryCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 17),
      decoration: BoxDecoration(
        color: AppColors.statsCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.gray100),
      ),
      child: Row(
        children: [
          Expanded(child: _statColumn('🔥', '7', 'Streak')),
          Container(width: 1, height: 40, color: AppColors.outline),
          Expanded(child: _statColumn('⭐', 'Lv. 4', 'Level')),
          Container(width: 1, height: 40, color: AppColors.outline),
          Expanded(child: _statColumn('📅', '18 days', 'Test countdown')),
        ],
      ),
    );
  }

  Widget _statColumn(String emoji, String value, String label) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 16)),
            const SizedBox(width: 4),
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
        const SizedBox(height: 4),
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w400,
            color: AppColors.slateMuted,
          ),
        ),
      ],
    );
  }

  Widget _quickPracticeGrid() {
    final items = [
      (Icons.mic_rounded, 'Practice\nSpeaking'),
      (Icons.fact_check_rounded, 'Take Mock\nTest'),
      (Icons.article_rounded, 'Write an\nEssay'),
      (Icons.style_rounded, 'Vocab\nFlashcards'),
    ];
    return Row(
      children: [
        for (final item in items) ...[
          Expanded(child: _quickPracticeItem(item.$1, item.$2)),
          if (item != items.last) const SizedBox(width: 8),
        ],
      ],
    );
  }

  Widget _quickPracticeItem(IconData icon, String label) {
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppColors.iconChip,
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Icon(icon, size: 22, color: AppColors.primaryButton),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            height: 14 / 11,
            color: AppColors.slate,
          ),
        ),
      ],
    );
  }

  Widget _insightBanner() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.dashInsightBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.dashInsightBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(color: AppColors.white, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: const Icon(Icons.lightbulb_rounded, size: 20, color: AppColors.dashInsightIcon),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "TODAY'S INSIGHT",
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                    color: AppColors.dashInsightIcon,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Your Writing improved 0.5 bands this week. Focus on coherence today.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 16 / 12,
                    color: AppColors.slateSoft,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'See full report →',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primaryButton,
                  ),
                ),
              ],
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
      (Icons.assignment_rounded, 'Tests', false),
      (Icons.more_horiz_rounded, 'More', false),
    ];
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(top: BorderSide(color: AppColors.outline)),
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
                    color: item.$3 ? AppColors.primaryButton : AppColors.dashNavInactive,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.$2,
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: item.$3 ? AppColors.primaryButton : AppColors.dashNavInactive,
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
