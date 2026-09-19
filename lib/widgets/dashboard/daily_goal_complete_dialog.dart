import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';

/// DASH-002 — Daily Goal Complete overlay.
///
/// Shown on top of the Home dashboard once the user finishes all of
/// today's lessons. Auto-dismisses back to Home after a few seconds,
/// or immediately when the user taps close / "Done for Today".
class DailyGoalCompleteDialog extends StatefulWidget {
  const DailyGoalCompleteDialog({
    super.key,
    this.streakDays = 7,
    this.xpEarned = 65,
    this.autoDismiss = const Duration(seconds: 4),
  });

  final int streakDays;
  final int xpEarned;
  final Duration autoDismiss;

  static Future<void> show(
    BuildContext context, {
    int streakDays = 7,
    int xpEarned = 65,
  }) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.transparent,
      transitionDuration: const Duration(milliseconds: 220),
      pageBuilder: (context, animation, secondaryAnimation) {
        return DailyGoalCompleteDialog(
          streakDays: streakDays,
          xpEarned: xpEarned,
        );
      },
      transitionBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: Curves.easeOutCubic,
        );
        return FadeTransition(
          opacity: curved,
          child: ScaleTransition(
            scale: Tween<double>(begin: 0.94, end: 1).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  @override
  State<DailyGoalCompleteDialog> createState() =>
      _DailyGoalCompleteDialogState();
}

class _DailyGoalCompleteDialogState extends State<DailyGoalCompleteDialog> {
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _timer = Timer(widget.autoDismiss, _dismiss);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _dismiss() {
    if (!mounted) return;
    Navigator.of(context).maybePop();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(color: AppColors.goalOverlayScrim),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              width: 342,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                boxShadow: const [
                  BoxShadow(
                    color: AppColors.goalCardShadow,
                    offset: Offset(0, 20),
                    blurRadius: 40,
                    spreadRadius: -8,
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Align(
                    alignment: Alignment.topRight,
                    child: GestureDetector(
                      onTap: _dismiss,
                      child: const Icon(
                        Icons.close_rounded,
                        size: 24,
                        color: AppColors.slateMuted,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  _header(),
                  const SizedBox(height: 24),
                  _statsRow(),
                  const SizedBox(height: 16),
                  _milestoneBanner(),
                  const SizedBox(height: 16),
                  _keepGoingCard(),
                  const SizedBox(height: 24),
                  _doneButton(),
                  const SizedBox(height: 16),
                  _autoReturnFooter(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _header() {
    return Column(
      children: [
        Container(
          width: 64,
          height: 64,
          decoration: const BoxDecoration(
            color: AppColors.goalFlameBg,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: const Text('🔥', style: TextStyle(fontSize: 32)),
        ),
        const SizedBox(height: 16),
        Text(
          'Daily goal complete!',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            height: 28 / 20,
            color: AppColors.slate,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "You've finished every lesson for today. Amazing work!",
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            height: 16 / 13,
            color: AppColors.slateMuted,
          ),
        ),
      ],
    );
  }

  Widget _statsRow() {
    return Row(
      children: [
        Expanded(
          child: _statChip(
            emoji: '🔥',
            value: '${widget.streakDays}-day streak',
            label: 'Current streak',
            bg: AppColors.goalStreakCardBg,
            border: AppColors.goalStreakCardBorder,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statChip(
            icon: Icons.star_rounded,
            iconColor: const Color(0xFF2563EB),
            value: '${widget.xpEarned} XP',
            label: 'Earned today',
            bg: AppColors.goalXpCardBg,
            border: AppColors.goalXpCardBorder,
          ),
        ),
      ],
    );
  }

  Widget _statChip({
    String? emoji,
    IconData? icon,
    Color? iconColor,
    required String value,
    required String label,
    required Color bg,
    required Color border,
  }) {
    return Container(
      height: 101,
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (emoji != null)
            Text(emoji, style: const TextStyle(fontSize: 24))
          else
            Icon(icon, size: 24, color: iconColor),
          const SizedBox(height: 4),
          Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: AppColors.slate,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: GoogleFonts.inter(
              fontSize: 11,
              fontWeight: FontWeight.w500,
              color: AppColors.slateMuted,
            ),
          ),
        ],
      ),
    );
  }

  Widget _milestoneBanner() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.goalMilestoneBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.goalMilestoneBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.goalMilestoneIconBg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.emoji_events_rounded,
              size: 18,
              color: Color(0xFFB45309),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${widget.streakDays}-day streak milestone!',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    height: 16 / 13,
                    color: AppColors.slate,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "You're on fire — keep the streak alive.",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 15 / 12,
                    color: AppColors.slateMuted,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _keepGoingCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.goalKeepGoingBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.goalKeepGoingBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.goalKeepGoingIconBg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.trending_up_rounded,
              size: 20,
              color: AppColors.primaryButton,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Keep going',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    height: 16 / 13,
                    color: AppColors.slate,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Come back tomorrow to grow your streak.',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 15 / 12,
                    color: AppColors.slateMuted,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            size: 18,
            color: AppColors.slateMuted,
          ),
        ],
      ),
    );
  }

  Widget _doneButton() {
    return SizedBox(
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: AppColors.goalButtonShadow,
              offset: Offset(0, 10),
              blurRadius: 15,
              spreadRadius: -3,
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _dismiss,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryButton,
            foregroundColor: AppColors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            padding: const EdgeInsets.symmetric(vertical: 14),
          ),
          child: Text(
            'Done for Today',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 16 / 14,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _autoReturnFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.info_outline_rounded, size: 14, color: AppColors.slateMuted),
        const SizedBox(width: 8),
        Flexible(
          child: Text(
            "We'll take you back home in a few seconds",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 17 / 12,
              color: AppColors.slateMuted,
            ),
          ),
        ),
      ],
    );
  }
}
