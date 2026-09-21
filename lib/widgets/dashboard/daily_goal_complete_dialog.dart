import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: 342,
                maxHeight: MediaQuery.sizeOf(context).height * 0.88,
              ),
              child: Material(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                clipBehavior: Clip.antiAlias,
                elevation: 0,
                shadowColor: Colors.transparent,
                child: Container(
                  width: 342,
                  padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: const [
                      BoxShadow(
                        color: AppColors.goalCardShadow,
                        offset: Offset(0, 25),
                        blurRadius: 50,
                        spreadRadius: -12,
                      ),
                    ],
                  ),
                  child: SingleChildScrollView(
                    child: Stack(
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const SizedBox(height: 8),
                            _header(),
                            const SizedBox(height: 20),
                            _statsRow(),
                            const SizedBox(height: 16),
                            _milestoneBanner(),
                            const SizedBox(height: 12),
                            _keepGoingCard(),
                            const SizedBox(height: 20),
                            _doneButton(),
                            const SizedBox(height: 16),
                            _autoReturnFooter(),
                          ],
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: _dismiss,
                            behavior: HitTestBehavior.opaque,
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: Center(
                                child: SvgPicture.asset(
                                  'assets/icons/home/close.svg',
                                  width: 12,
                                  height: 12,
                                  colorFilter: const ColorFilter.mode(
                                    AppColors.goalClose,
                                    BlendMode.srcIn,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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
            boxShadow: [
              BoxShadow(
                color: Color(0x14000000),
                offset: Offset(0, 4),
                blurRadius: 8,
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Image.asset(
            'assets/icons/home/goal/flame.png',
            width: 36,
            height: 36,
            filterQuality: FilterQuality.high,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Daily goal complete! 🎉',
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
          'You did it! Keep up the amazing work.',
          textAlign: TextAlign.center,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w400,
            height: 18 / 13,
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
            icon: Image.asset(
              'assets/icons/home/goal/flame.png',
              width: 28,
              height: 28,
              filterQuality: FilterQuality.high,
            ),
            value: '${widget.streakDays}-day streak',
            label: '+${widget.streakDays} day streak',
            labelColor: AppColors.goalStreakAccent,
            bg: AppColors.goalStreakCardBg,
            border: AppColors.goalStreakCardBorder,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _statChip(
            icon: SvgPicture.asset(
              'assets/icons/home/goal/star.svg',
              width: 28,
              height: 28,
            ),
            value: '${widget.xpEarned} XP',
            label: '+${widget.xpEarned} XP today',
            labelColor: AppColors.goalXpAccent,
            bg: AppColors.goalXpCardBg,
            border: AppColors.goalXpCardBorder,
          ),
        ),
      ],
    );
  }

  Widget _statChip({
    required Widget icon,
    required String value,
    required String label,
    required Color labelColor,
    required Color bg,
    required Color border,
  }) {
    return Container(
      height: 101,
      padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: border),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 2),
            blurRadius: 4,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          icon,
          const SizedBox(height: 6),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              maxLines: 1,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w700,
                height: 20 / 15,
                color: AppColors.slate,
              ),
            ),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              maxLines: 1,
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w500,
                height: 15 / 11,
                color: labelColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _milestoneBanner() {
    return Container(
      padding: const EdgeInsets.all(14),
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
              color: AppColors.goalFlameBg,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Image.asset(
              'assets/icons/home/goal/trophy.png',
              width: 18,
              height: 18,
              filterQuality: FilterQuality.high,
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
                    color: AppColors.goalMilestoneTitle,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "You're building great habits!",
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    height: 17 / 12,
                    color: AppColors.goalMilestoneSubtitle,
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
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        onTap: _dismiss,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.goalKeepGoingBorder),
            boxShadow: const [
              BoxShadow(
                color: Color(0x0D000000),
                offset: Offset(0, 2),
                blurRadius: 4,
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.goalKeepGoingIconBg,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/home/goal/book.svg',
                  width: 20,
                  height: 20,
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
                    Text(
                      'Practice more today',
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
              Icon(
                Icons.chevron_right_rounded,
                size: 22,
                color: AppColors.goalKeepGoingChevron,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _doneButton() {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: _dismiss,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.diagPrimary,
          foregroundColor: AppColors.white,
          elevation: 0,
          shadowColor: Colors.transparent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          'Done for Today',
          style: GoogleFonts.inter(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            height: 20 / 15,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _autoReturnFooter() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          'assets/icons/home/goal/clock.svg',
          width: 14,
          height: 14,
          colorFilter: const ColorFilter.mode(
            AppColors.goalFooter,
            BlendMode.srcIn,
          ),
        ),
        const SizedBox(width: 6),
        Flexible(
          child: Text(
            "We'll take you back home in a few seconds.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 17 / 12,
              color: AppColors.goalFooter,
            ),
          ),
        ),
      ],
    );
  }
}
