import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';

/// DASH-005 — Exam Switcher Screen
/// Figma node 41:30
class ExamSwitcherScreen extends StatefulWidget {
  const ExamSwitcherScreen({super.key});

  @override
  State<ExamSwitcherScreen> createState() => _ExamSwitcherScreenState();
}

enum _AvailableExam { ukvi, lifeSkills }

class _ExamSwitcherScreenState extends State<ExamSwitcherScreen> {
  _AvailableExam _selected = _AvailableExam.ukvi;

  String get _selectedTitle =>
      _selected == _AvailableExam.ukvi ? 'IELTS UKVI' : 'IELTS Life Skills';

  @override
  Widget build(BuildContext context) {
    // Figma 41:30 — StatusBar/MainHeader white; page fill #F1F5F9 (slate-100)
    const pageBg = Color(0xFFF1F5F9);
    return Scaffold(
      backgroundColor: pageBg,
      body: ColoredBox(
        color: pageBg,
        child: Column(
          children: [
            // White header band includes status-bar inset (Figma StatusBar + MainHeader)
            ColoredBox(
              color: AppColors.white,
              child: SafeArea(
                bottom: false,
                child: _header(context),
              ),
            ),
            Expanded(
              child: ColoredBox(
                color: pageBg,
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(24, 16, 24, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionLabel('CURRENT EXAM'),
                      const SizedBox(height: 10),
                      _currentExamCard(),
                      const SizedBox(height: 20),
                      _sectionLabel('AVAILABLE EXAMS'),
                      const SizedBox(height: 10),
                      _availableCard(
                        exam: _AvailableExam.ukvi,
                        iconColor: AppColors.examSwitcherUkviIcon,
                        iconBadgeBg: const Color(0xFFF1E1FF),
                        iconLine2: 'UKVI',
                        iconBadge: Icons.shield_rounded,
                        title: 'IELTS UKVI',
                        description:
                            'For UK Visas and Immigration applications.',
                        pillBg: AppColors.examSwitcherUkviPillBg,
                        pillFg: AppColors.examSwitcherUkviPillText,
                        pillIcon: Icons.menu_book_outlined,
                        pillLabel: '3 lessons completed',
                      ),
                      const SizedBox(height: 12),
                      _availableCard(
                        exam: _AvailableExam.lifeSkills,
                        iconColor: AppColors.examSwitcherLifeIcon,
                        iconBadgeBg: const Color(0xFFFFF2DB),
                        iconLine2: 'Life Skills',
                        iconBadge: Icons.workspace_premium_rounded,
                        title: 'IELTS Life Skills',
                        description:
                            'For UK Visas and Immigration applications (A1 & B1).',
                        pillBg: AppColors.examSwitcherLifePillBg,
                        pillFg: AppColors.examSwitcherLifeIcon,
                        pillIcon: Icons.refresh_rounded,
                        pillLabel: 'Start fresh',
                      ),
                      const SizedBox(height: 12),
                      _pteAcademicCard(),
                      const SizedBox(height: 20),
                      _sectionLabel('COMING SOON'),
                      const SizedBox(height: 10),
                      _comingSoonCard(),
                    ],
                  ),
                ),
              ),
            ),
            ColoredBox(
              color: pageBg,
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 8),
                      child: _infoBanner(),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 8, 24, 0),
                      child: _switchButton(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(24, 10, 24, 16),
                      child: _cancelLink(context),
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
      color: AppColors.white,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: [
          IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(
              Icons.chevron_left,
              size: 28,
              color: AppColors.examSwitcherTitle,
            ),
          ),
          Text(
            'Switch exam',
            style: GoogleFonts.inter(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              height: 28 / 20,
              color: AppColors.examSwitcherTitle,
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Text(
      text,
      style: GoogleFonts.inter(
        fontSize: 12,
        fontWeight: FontWeight.w600,
        height: 16 / 12,
        letterSpacing: 0.6,
        color: AppColors.examSwitcherLabel,
      ),
    );
  }

  Widget _currentExamCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.examSwitcherPrimary, width: 2),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            blurRadius: 2,
            offset: Offset(0, 1),
          ),
        ],
      ),
      child: Stack(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _examLogo(
                color: AppColors.examSwitcherAcademicIcon,
                line2: 'Academic',
                badgeBg: const Color(0xFFE8EFFF),
                badgeIcon: Icons.school_rounded,
                badgeIconColor: AppColors.examSwitcherPrimary,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 2),
                    Text(
                      'IELTS Academic',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        height: 20 / 16,
                        color: AppColors.examSwitcherTitle,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'For study, work and migration to English-speaking countries.',
                      style: GoogleFonts.inter(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        height: 18 / 13,
                        color: AppColors.examSwitcherDesc,
                      ),
                    ),
                    const SizedBox(height: 10),
                    _statusPill(
                      bg: AppColors.examSwitcherAcademicPillBg,
                      fg: AppColors.examSwitcherPrimary,
                      icon: Icons.menu_book_outlined,
                      label: '12 lessons completed',
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.examSwitcherPrimary,
                borderRadius: BorderRadius.circular(9999),
              ),
              child: Text(
                'Current',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  height: 16 / 11,
                  color: AppColors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _availableCard({
    required _AvailableExam exam,
    required Color iconColor,
    required Color iconBadgeBg,
    required String iconLine2,
    required IconData iconBadge,
    required String title,
    required String description,
    required Color pillBg,
    required Color pillFg,
    required IconData pillIcon,
    required String pillLabel,
  }) {
    final selected = _selected == exam;
    return GestureDetector(
      onTap: () => setState(() => _selected = exam),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(17),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.examSwitcherCardBorder),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _examLogo(
              color: iconColor,
              line2: iconLine2,
              badgeBg: iconBadgeBg,
              badgeIcon: iconBadge,
              badgeIconColor: iconColor,
              compactLine2: iconLine2 == 'Life Skills',
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      height: 20 / 16,
                      color: AppColors.examSwitcherTitle,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    description,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      height: 18 / 13,
                      color: AppColors.examSwitcherDesc,
                    ),
                  ),
                  const SizedBox(height: 10),
                  _statusPill(
                    bg: pillBg,
                    fg: pillFg,
                    icon: pillIcon,
                    label: pillLabel,
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            _radio(selected),
          ],
        ),
      ),
    );
  }

  Widget _radio(bool selected) {
    if (selected) {
      return Container(
        width: 22,
        height: 22,
        decoration: const BoxDecoration(
          color: AppColors.examSwitcherPrimary,
          shape: BoxShape.circle,
        ),
        child: Center(
          child: Container(
            width: 8,
            height: 8,
            decoration: const BoxDecoration(
              color: AppColors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      );
    }
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        color: AppColors.white,
        shape: BoxShape.circle,
        border: Border.all(color: AppColors.examSwitcherRadioIdle),
      ),
    );
  }

  Widget _pteAcademicCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
      decoration: BoxDecoration(
        color: AppColors.examSwitcherComingBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.examSwitcherBg),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PTE Academic',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              height: 20 / 16,
              color: AppColors.examSwitcherComingTitle,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            'Pearson Test of English',
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              height: 16 / 13,
              color: AppColors.examSwitcherComingDesc,
            ),
          ),
        ],
      ),
    );
  }

  Widget _comingSoonCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 17),
      decoration: BoxDecoration(
        color: AppColors.examSwitcherComingBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.examSwitcherBg),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              'Cambridge English',
              style: GoogleFonts.inter(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                height: 20 / 16,
                color: AppColors.examSwitcherComingTitle,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.examSwitcherComingBadgeBg,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              'Coming Soon',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                height: 16 / 12,
                color: AppColors.examSwitcherComingBadgeText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(13, 13, 13, 13),
      decoration: BoxDecoration(
        color: AppColors.examSwitcherInfoBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.examSwitcherInfoBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 2),
            child: Icon(
              Icons.access_time_rounded,
              size: 16,
              color: AppColors.examSwitcherPrimary,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Switching to $_selectedTitle. Your IELTS Academic progress is saved and waiting for you.',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w500,
                height: 18 / 13,
                color: AppColors.examSwitcherInfoText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _switchButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).pop(_selectedTitle),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.examSwitcherPrimary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shadowColor: const Color(0x0D000000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'Switch to $_selectedTitle',
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              height: 20 / 15,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _cancelLink(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: Text(
          'Cancel',
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 20 / 15,
            color: AppColors.examSwitcherPrimary,
          ),
        ),
      ),
    );
  }

  Widget _statusPill({
    required Color bg,
    required Color fg,
    required IconData icon,
    required String label,
  }) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 4, 12, 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(9999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: fg),
          const SizedBox(width: 4),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              height: 16 / 12,
              color: fg,
            ),
          ),
        ],
      ),
    );
  }

  Widget _examLogo({
    required Color color,
    required String line2,
    required Color badgeBg,
    required IconData badgeIcon,
    required Color badgeIconColor,
    bool compactLine2 = false,
  }) {
    return SizedBox(
      width: 48,
      height: 48,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: const [
                BoxShadow(
                  color: Color(0x0D000000),
                  blurRadius: 4,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'IELTS',
                  style: GoogleFonts.inter(
                    fontSize: 9,
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                    color: AppColors.white,
                    letterSpacing: 0.2,
                  ),
                ),
                Text(
                  line2,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: compactLine2 ? 6.5 : 8,
                    fontWeight: FontWeight.w600,
                    height: 1.1,
                    color: AppColors.white,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: -2,
            bottom: -2,
            child: Container(
              width: 16,
              height: 16,
              decoration: BoxDecoration(
                color: badgeBg,
                shape: BoxShape.circle,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Icon(badgeIcon, size: 10, color: badgeIconColor),
            ),
          ),
        ],
      ),
    );
  }
}
