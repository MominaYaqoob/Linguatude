import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../../widgets/app_bottom_nav.dart';
import '../home/home_today_screen.dart';
import '../home/mock_test_prompt_screen.dart';
import '../streak/streak_gamification_screen.dart';
import 'pte_answer_short_question_screen.dart';
import 'pte_describe_image_screen.dart';
import 'pte_read_aloud_screen.dart';
import 'pte_repeat_sentence_screen.dart';
import 'pte_retell_lecture_screen.dart';

/// PTE-001 — PTE Academic Practice Hub
/// Figma node 48:30
class PtePracticeScreen extends StatefulWidget {
  const PtePracticeScreen({super.key});

  @override
  State<PtePracticeScreen> createState() => _PtePracticeScreenState();
}

enum _PtePart { speakingWriting, reading, listening }

class _PteTask {
  const _PteTask({
    required this.code,
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.icon,
  });

  final String code;
  final String title;
  final String subtitle;
  final double progress;
  final IconData icon;
}

class _PtePracticeScreenState extends State<PtePracticeScreen> {
  static const _mockIcons = 'assets/icons/home/mock';

  _PtePart _part = _PtePart.speakingWriting;

  static const _swTasks = <_PteTask>[
    _PteTask(
      code: 'RA',
      title: 'Read Aloud',
      subtitle: 'Speak a written text (~60 words), 30–40 s',
      progress: 0.72,
      icon: Icons.volume_up_rounded,
    ),
    _PteTask(
      code: 'RS',
      title: 'Repeat Sentence',
      subtitle: 'Hear 3–9 s sentence, repeat verbatim',
      progress: 0.55,
      icon: Icons.sync_rounded,
    ),
    _PteTask(
      code: 'DI',
      title: 'Describe Image',
      subtitle: 'Describe chart/graph/map, 25 s prep',
      progress: 0.61,
      icon: Icons.image_outlined,
    ),
    _PteTask(
      code: 'RL',
      title: 'Re-tell Lecture',
      subtitle: 'Hear ~90 s lecture, 10 s prep, 40 s retell',
      progress: 0.63,
      icon: Icons.present_to_all_rounded,
    ),
    _PteTask(
      code: 'ASQ',
      title: 'Answer Short Question',
      subtitle: 'One-word/short answer to spoken question',
      progress: 0.80,
      icon: Icons.help_outline_rounded,
    ),
    _PteTask(
      code: 'SWT',
      title: 'Summarize Written Text',
      subtitle: 'One sentence, 5–75 words, 10 min',
      progress: 0.42,
      icon: Icons.description_outlined,
    ),
  ];

  static const _readingTasks = <_PteTask>[
    _PteTask(
      code: 'RWFB',
      title: 'R&W: Fill in the Blanks',
      subtitle: 'Drag words into a passage',
      progress: 0.48,
      icon: Icons.edit_note_rounded,
    ),
    _PteTask(
      code: 'MCMA',
      title: 'Multiple Choice (Multi)',
      subtitle: 'Select all correct options',
      progress: 0.35,
      icon: Icons.checklist_rounded,
    ),
    _PteTask(
      code: 'RO',
      title: 'Re-order Paragraphs',
      subtitle: 'Put text boxes in the right order',
      progress: 0.52,
      icon: Icons.reorder_rounded,
    ),
    _PteTask(
      code: 'RFB',
      title: 'Reading: Fill in the Blanks',
      subtitle: 'Choose the best word for each blank',
      progress: 0.67,
      icon: Icons.menu_book_outlined,
    ),
    _PteTask(
      code: 'MCSA',
      title: 'Multiple Choice (Single)',
      subtitle: 'Pick one correct answer',
      progress: 0.41,
      icon: Icons.radio_button_checked_rounded,
    ),
  ];

  static const _listeningTasks = <_PteTask>[
    _PteTask(
      code: 'SST',
      title: 'Summarize Spoken Text',
      subtitle: '50–70 words summary, 10 min',
      progress: 0.38,
      icon: Icons.headphones_rounded,
    ),
    _PteTask(
      code: 'MCMA',
      title: 'Multiple Choice (Multi)',
      subtitle: 'Select all correct options after audio',
      progress: 0.44,
      icon: Icons.checklist_rounded,
    ),
    _PteTask(
      code: 'FIB',
      title: 'Fill in the Blanks',
      subtitle: 'Type missing words while listening',
      progress: 0.58,
      icon: Icons.hearing_rounded,
    ),
    _PteTask(
      code: 'HCS',
      title: 'Highlight Correct Summary',
      subtitle: 'Choose the best summary of the talk',
      progress: 0.50,
      icon: Icons.highlight_alt_rounded,
    ),
    _PteTask(
      code: 'SMW',
      title: 'Select Missing Word',
      subtitle: 'Predict the last word of the recording',
      progress: 0.33,
      icon: Icons.graphic_eq_rounded,
    ),
  ];

  List<_PteTask> get _tasks {
    switch (_part) {
      case _PtePart.speakingWriting:
        return _swTasks;
      case _PtePart.reading:
        return _readingTasks;
      case _PtePart.listening:
        return _listeningTasks;
    }
  }

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
                padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _hero(),
                    const SizedBox(height: 20),
                    _partTabs(),
                    const SizedBox(height: 16),
                    ..._tasks.map(
                      (task) => Padding(
                        padding: const EdgeInsets.only(bottom: 16),
                        child: _taskCard(task),
                      ),
                    ),
                    _quickMockCard(context),
                    const SizedBox(height: 16),
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
              padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 5),
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
          const SizedBox(width: 8),
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

  Widget _hero() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'PTE Academic',
                style: GoogleFonts.inter(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 32 / 24,
                  color: AppColors.pteTitle,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Practice every task. Master every score.',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 16 / 12,
                  color: AppColors.pteSubtitle,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.pteScoreBadgeBg,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Text(
            'PTE 64',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              height: 16 / 12,
              color: AppColors.pteScoreBadgeText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _partTabs() {
    return LayoutBuilder(
      builder: (context, constraints) {
        final tight = constraints.maxWidth < 340;
        return Container(
          padding: EdgeInsets.symmetric(
            vertical: 8,
            horizontal: tight ? 0 : 2,
          ),
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: const [
              BoxShadow(
                color: Color(0x40D4D4D4),
                blurRadius: 4,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: _partTab(
                  part: _PtePart.speakingWriting,
                  iconAsset: 'assets/icons/onboarding/mic.svg',
                  fallbackIcon: Icons.mic_none_rounded,
                  title: 'S&W',
                  partLabel: 'PART 1',
                  useSvg: true,
                  compact: tight,
                ),
              ),
              SizedBox(width: tight ? 4 : 6),
              Expanded(
                child: _partTab(
                  part: _PtePart.reading,
                  iconAsset: 'assets/icons/onboarding/book.svg',
                  fallbackIcon: Icons.menu_book_outlined,
                  title: 'Reading',
                  partLabel: 'PART 2',
                  useSvg: true,
                  compact: tight,
                ),
              ),
              SizedBox(width: tight ? 4 : 6),
              Expanded(
                child: _partTab(
                  part: _PtePart.listening,
                  iconAsset: 'assets/icons/onboarding/headphones.svg',
                  fallbackIcon: Icons.headphones_rounded,
                  title: 'Listening',
                  partLabel: 'PART 3',
                  useSvg: true,
                  compact: tight,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _partTab({
    required _PtePart part,
    required String iconAsset,
    required IconData fallbackIcon,
    required String title,
    required String partLabel,
    required bool useSvg,
    bool compact = false,
  }) {
    final active = _part == part;
    final fg = active ? AppColors.white : AppColors.pteTabInactiveTitle;
    final partFg = active ? AppColors.white : AppColors.pteTabInactivePart;
    final iconColor = active ? AppColors.white : AppColors.pteTabInactivePart;

    return GestureDetector(
      onTap: () => setState(() => _part = part),
      child: Container(
        height: 54,
        padding: EdgeInsets.symmetric(horizontal: compact ? 4 : 8),
        decoration: BoxDecoration(
          color: active ? AppColors.pteTabActive : AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.pteTabBorder),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0D000000),
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (useSvg)
              SvgPicture.asset(
                iconAsset,
                width: part == _PtePart.speakingWriting
                    ? (compact ? 11 : 12.5)
                    : (compact ? 14 : 18),
                height: part == _PtePart.speakingWriting
                    ? (compact ? 14 : 18)
                    : (compact ? 13 : 16),
                colorFilter: ColorFilter.mode(iconColor, BlendMode.srcIn),
              )
            else
              Icon(fallbackIcon, size: compact ? 14 : 16, color: iconColor),
            SizedBox(width: compact ? 4 : 8),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    alignment: Alignment.centerLeft,
                    child: Text(
                      title,
                      maxLines: 1,
                      style: GoogleFonts.inter(
                        fontSize: compact ? 11 : 13,
                        fontWeight: FontWeight.w700,
                        height: 1.2,
                        color: fg,
                      ),
                    ),
                  ),
                  Text(
                    partLabel,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.inter(
                      fontSize: compact ? 9 : 10,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                      color: partFg,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _taskCard(_PteTask task) {
    final high = task.progress >= 0.70;
    final barColor =
        high ? AppColors.pteProgressGreen : AppColors.pteProgressBlue;
    final pct = (task.progress * 100).round();

    return GestureDetector(
      onTap: task.code == 'RA'
          ? () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const PteReadAloudScreen(),
                ),
              );
            }
          : task.code == 'RS'
              ? () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const PteRepeatSentenceScreen(),
                    ),
                  );
                }
              : task.code == 'DI'
                  ? () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const PteDescribeImageScreen(),
                        ),
                      );
                    }
                  : task.code == 'RL'
                      ? () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const PteRetellLectureScreen(),
                            ),
                          );
                        }
                      : task.code == 'ASQ'
                          ? () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) =>
                                      const PteAnswerShortQuestionScreen(),
                                ),
                              );
                            }
                          : null,
      child: Container(
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.pteCardBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.pteTaskIconBg,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  task.code,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    height: 14 / 11,
                    color: AppColors.pteScoreBadgeText,
                  ),
                ),
                const SizedBox(height: 2),
                Icon(
                  task.icon,
                  size: 12,
                  color: AppColors.pteScoreBadgeText,
                ),
              ],
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  task.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                    height: 20 / 14,
                    color: AppColors.pteTitle,
                  ),
                ),
                Text(
                  task.subtitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.inter(
                    fontSize: 11,
                    fontWeight: FontWeight.w400,
                    height: 16 / 11,
                    color: AppColors.pteTaskDesc,
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(9999),
                        child: LinearProgressIndicator(
                          value: task.progress,
                          minHeight: 6,
                          backgroundColor: AppColors.pteProgressTrack,
                          valueColor: AlwaysStoppedAnimation<Color>(barColor),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '$pct%',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        height: 17 / 12,
                        color: barColor,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    ),
    );
  }

  Widget _quickMockCard(BuildContext context) {
    return Container(
      height: 97,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.pteQuickMockBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.pteQuickMockIconBg,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppColors.pteQuickMockIconBorder),
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              'assets/icons/home/clipboard.svg',
              width: 24,
              height: 24,
              colorFilter: const ColorFilter.mode(
                AppColors.pteTabActive,
                BlendMode.srcIn,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Quick Mock',
                  style: GoogleFonts.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    height: 28 / 18,
                    color: AppColors.slate,
                  ),
                ),
                Text(
                  'Full-length mock test',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 20 / 12,
                    color: AppColors.pteQuickMockMeta,
                  ),
                ),
                Row(
                  children: [
                    SvgPicture.asset(
                      '$_mockIcons/clock.svg',
                      width: 14,
                      height: 14,
                      colorFilter: const ColorFilter.mode(
                        AppColors.pteQuickMockMeta,
                        BlendMode.srcIn,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Text(
                      '~2 hours',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 20 / 12,
                        color: AppColors.pteQuickMockMeta,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => const MockTestPromptScreen(),
                ),
              );
            },
            child: Container(
              height: 38,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: AppColors.pteTabActive,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Start Mock',
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 24 / 13,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.chevron_right_rounded,
                    size: 18,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bottomNav(BuildContext context) {
    return AppBottomNav(
      activeColor: AppColors.pteTabActive,
      borderColor: AppColors.pteNavBorder,
      items: [
        AppBottomNavItem(
          icon: '$_mockIcons/home_nav.svg',
          label: 'Home',
          onTap: () {
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(
                builder: (_) => const HomeTodayScreen(),
              ),
              (route) => false,
            );
          },
        ),
        const AppBottomNavItem(
          icon: '$_mockIcons/learn_nav.svg',
          label: 'Learn',
        ),
        const AppBottomNavItem(
          icon: '$_mockIcons/practice_nav.svg',
          label: 'Practice',
          active: true,
        ),
        AppBottomNavItem(
          icon: '$_mockIcons/mock_nav.svg',
          label: 'Mock Test',
          iconSize: 22,
          onTap: () {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => const MockTestPromptScreen(),
              ),
            );
          },
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
}
