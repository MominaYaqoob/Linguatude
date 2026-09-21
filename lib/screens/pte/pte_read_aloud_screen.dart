import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';

/// PTE-002 — Read Aloud (prep state)
/// Figma node 51:804
class PteReadAloudScreen extends StatefulWidget {
  const PteReadAloudScreen({super.key});

  static const passage =
      'Urban rooftop farming has expanded rapidly across Australian cities, '
      'cutting cooling costs and boosting food security.';

  @override
  State<PteReadAloudScreen> createState() => _PteReadAloudScreenState();
}

class _PteReadAloudScreenState extends State<PteReadAloudScreen> {
  static const _prepTotalSeconds = 20;
  static const _sessionTotalSeconds = 52 * 60 + 16;

  late int _prepRemaining;
  late int _sessionRemaining;
  bool _autoAdvance = true;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _prepRemaining = 8;
    _sessionRemaining = _sessionTotalSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
        if (_prepRemaining > 0) _prepRemaining--;
        if (_sessionRemaining > 0) _sessionRemaining--;
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String _fmt(int totalSeconds) {
    final m = (totalSeconds ~/ 60).toString().padLeft(2, '0');
    final s = (totalSeconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  double get _prepProgress {
    final elapsed = _prepTotalSeconds - _prepRemaining;
    return (elapsed / _prepTotalSeconds).clamp(0.0, 1.0);
  }

  int get _wordCount => 59;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pte002Bg,
      body: SafeArea(
        child: Column(
          children: [
            _appHeader(context),
            _metaTabs(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                child: Column(
                  children: [
                    _taskBanner(),
                    const SizedBox(height: 14),
                    _prepCard(),
                    const SizedBox(height: 14),
                    _passageCard(),
                    const SizedBox(height: 14),
                    _micCard(),
                    const SizedBox(height: 14),
                    _warningBanner(),
                  ],
                ),
              ),
            ),
            _footer(),
          ],
        ),
      ),
    );
  }

  Widget _appHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 12, 24, 8),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.of(context).maybePop(),
            behavior: HitTestBehavior.opaque,
            child: SizedBox(
              width: 24,
              height: 24,
              child: SvgPicture.asset(
                'assets/icons/chevron_left.svg',
                width: 10,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  AppColors.pte002Header,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Read Aloud',
              style: GoogleFonts.inter(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                height: 28 / 20,
                color: AppColors.pte002Header,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.pte002BadgeBg,
              borderRadius: BorderRadius.circular(9999),
            ),
            child: Text(
              'PTE 64',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 16 / 12,
                color: AppColors.pte002BadgeText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _metaTabs() {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(
          bottom: BorderSide(color: AppColors.pte002MetaDivider),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0x05000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 360;
          return Row(
            children: [
              Expanded(
                child: _metaCell(
                  label: 'Part 1 of 3',
                  value: 'S&W',
                  valueColor: AppColors.pte002MetaValue,
                  showRightBorder: true,
                  compact: compact,
                ),
              ),
              Expanded(
                child: _metaCell(
                  label: 'Task 1 of 7',
                  value: 'Read Aloud',
                  labelColor: AppColors.pte002ActiveTask,
                  valueColor: AppColors.pte002ActiveTaskSub,
                  underline: true,
                  showRightBorder: true,
                  compact: compact,
                ),
              ),
              Expanded(
                child: _metaCell(
                  label: 'Time remaining',
                  value: _fmt(_sessionRemaining),
                  valueColor: AppColors.pte002TimeGreen,
                  showRightBorder: true,
                  compact: compact,
                ),
              ),
              Expanded(
                child: _metaCell(
                  label: 'Progress',
                  value: '1 / 7',
                  valueColor: AppColors.pte002MetaValue,
                  compact: compact,
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _metaCell({
    required String label,
    required String value,
    Color? labelColor,
    required Color valueColor,
    bool underline = false,
    bool showRightBorder = false,
    bool compact = false,
  }) {
    return Container(
      padding: const EdgeInsets.only(bottom: 6),
      decoration: BoxDecoration(
        border: showRightBorder
            ? const Border(
                right: BorderSide(color: AppColors.pte002MetaDivider),
              )
            : null,
      ),
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: GoogleFonts.inter(
                fontSize: compact ? 9 : 10,
                fontWeight: FontWeight.w500,
                height: 1.2,
                color: labelColor ?? AppColors.pte002MetaLabel,
              ),
            ),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              maxLines: 1,
              style: GoogleFonts.inter(
                fontSize: compact ? 11 : 12,
                fontWeight: FontWeight.w700,
                height: 1.2,
                color: valueColor,
              ),
            ),
          ),
          const SizedBox(height: 4),
          if (underline)
            Container(
              height: 3,
              width: compact ? 48 : 74,
              decoration: BoxDecoration(
                color: AppColors.pte002ActiveTask,
                borderRadius: BorderRadius.circular(9999),
              ),
            )
          else
            const SizedBox(height: 3),
        ],
      ),
    );
  }

  Widget _taskBanner() {
    return Container(
      padding: const EdgeInsets.fromLTRB(17, 8, 17, 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.pte002CardBorder),
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(
                width: 48,
                height: 48,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.pte002ActiveTask,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x1A000000),
                            offset: Offset(0, 2),
                            blurRadius: 4,
                            spreadRadius: -2,
                          ),
                        ],
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        'RA',
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    Positioned(
                      right: -2,
                      bottom: -2,
                      child: Container(
                        width: 20,
                        height: 20,
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          shape: BoxShape.circle,
                          border: Border.all(color: AppColors.pte002FooterBorder),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              offset: Offset(0, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: const Icon(
                          Icons.volume_up_rounded,
                          size: 11,
                          color: AppColors.pte002ActiveTask,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Read Aloud',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 20 / 16,
                    color: AppColors.pte002Header,
                  ),
                ),
              ),
              Container(
                height: 30,
                padding: const EdgeInsets.symmetric(horizontal: 13),
                decoration: BoxDecoration(
                  color: AppColors.pte002ExampleBg,
                  borderRadius: BorderRadius.circular(9999),
                  border: Border.all(color: AppColors.pte002ExampleBorder),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 16,
                      height: 16,
                      decoration: const BoxDecoration(
                        color: AppColors.pte002ActiveTask,
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.play_arrow_rounded,
                        size: 12,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      'Example',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        height: 16 / 12,
                        color: AppColors.pte002ActiveTask,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'View task instructions',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 16 / 12,
                  color: AppColors.pte002ActiveTask,
                ),
              ),
              const SizedBox(width: 4),
              SvgPicture.asset(
                'assets/icons/onboarding/diag_info_circle.svg',
                width: 14,
                height: 14,
                colorFilter: const ColorFilter.mode(
                  AppColors.pte002ActiveTask,
                  BlendMode.srcIn,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _prepCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(17, 17, 17, 17),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.pte002PrepBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Prepare to speak',
                      style: GoogleFonts.inter(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        height: 20 / 15,
                        color: AppColors.pte002Header,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      'You will have up to 30–40 seconds to read the text aloud.',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        height: 16 / 12,
                        color: AppColors.pte002BodyMuted,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'Prep time',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 17 / 12,
                      color: AppColors.pte002MetaLabel,
                    ),
                  ),
                  Text(
                    _fmt(_prepRemaining),
                    style: GoogleFonts.inter(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 24 / 20,
                      color: AppColors.pte002ActiveTask,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: _prepProgress,
              minHeight: 8,
              backgroundColor: AppColors.pte002PrepTrack,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.pte002ActiveTask,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _passageCard() {
    return Container(
      padding: const EdgeInsets.all(17),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.pte002TextBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              const Icon(
                Icons.description_outlined,
                size: 16,
                color: AppColors.pte002MetaValue,
              ),
              const SizedBox(width: 6),
              Expanded(
                child: Text(
                  'Read the text below',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    height: 16 / 13,
                    color: AppColors.pte002TextBody,
                  ),
                ),
              ),
              Text(
                'Word count: $_wordCount',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  height: 16 / 12,
                  color: AppColors.pte002ActiveTask,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.open_in_full_rounded,
                size: 14,
                color: AppColors.pte002MetaLabel,
              ),
            ],
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 16),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.pte002PassageBorder),
            ),
            child: Text(
              PteReadAloudScreen.passage,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                height: 22 / 15,
                color: AppColors.pte002TextBody,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _micCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(16, 21, 16, 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.pte002MicCardBorder),
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            AppColors.pte002MicCardBg,
            AppColors.white,
          ],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                'assets/icons/onboarding/mic.svg',
                width: 16,
                height: 16,
                colorFilter: const ColorFilter.mode(
                  AppColors.pte002ActiveTask,
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 6),
              Text(
                'Get ready to speak',
                style: GoogleFonts.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  height: 16 / 13,
                  color: AppColors.pte002ActiveTask,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'When the recording starts, read the text aloud clearly and naturally.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 16 / 12,
              color: AppColors.pte002MicHint,
            ),
          ),
          const SizedBox(height: 12),
          Image.asset(
            'assets/icons/pte/mic_glow.png',
            width: 96,
            height: 96,
            filterQuality: FilterQuality.high,
          ),
          const SizedBox(height: 12),
          Text(
            'Recording starts automatically',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w700,
              height: 16 / 13,
              color: AppColors.pte002ActiveTask,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Speak clearly in a normal volume.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 17 / 12,
              color: AppColors.pte002MetaLabel,
            ),
          ),
        ],
      ),
    );
  }

  Widget _warningBanner() {
    return Container(
      padding: const EdgeInsets.fromLTRB(13, 13, 13, 13),
      decoration: BoxDecoration(
        color: AppColors.pte002WarnBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.pte002WarnBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/onboarding/diag_info_circle.svg',
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(
              AppColors.pte002ActiveTask,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'You cannot pause or replay in the real test. Read carefully during preparation.',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 16 / 12,
                color: AppColors.pte002ActiveTask,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _footer() {
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        decoration: const BoxDecoration(
          color: AppColors.white,
          border: Border(
            top: BorderSide(color: AppColors.pte002FooterBorder),
          ),
        ),
        child: Row(
          children: [
            GestureDetector(
              onTap: () => Navigator.of(context).maybePop(),
              child: Container(
                height: 32,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.pte002ExampleBorder),
                ),
                child: Text(
                  'Skip Task',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    height: 16 / 12,
                    color: AppColors.pte002ActiveTask,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      'Auto-advance',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        height: 16 / 12,
                        color: AppColors.pte002MetaValue,
                      ),
                    ),
                  ),
                  const SizedBox(width: 4),
                  SizedBox(
                    width: 36,
                    height: 20,
                    child: FittedBox(
                      fit: BoxFit.contain,
                      child: Switch(
                        value: _autoAdvance,
                        onChanged: (v) => setState(() => _autoAdvance = v),
                        activeThumbColor: AppColors.white,
                        activeTrackColor: AppColors.pte002ActiveTask,
                        inactiveThumbColor: AppColors.white,
                        inactiveTrackColor: AppColors.pte002NextDisabled,
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Container(
              height: 32,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: AppColors.pte002NextDisabled,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Next Task',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                      height: 16 / 12,
                      color: AppColors.white,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 14,
                    color: AppColors.white,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
