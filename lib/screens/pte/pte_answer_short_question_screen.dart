import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';

/// PTE-006 — Answer Short Question
/// Figma node 56:246
class PteAnswerShortQuestionScreen extends StatefulWidget {
  const PteAnswerShortQuestionScreen({super.key});

  @override
  State<PteAnswerShortQuestionScreen> createState() =>
      _PteAnswerShortQuestionScreenState();
}

class _PteAnswerShortQuestionScreenState
    extends State<PteAnswerShortQuestionScreen> {
  static const _sessionTotalSeconds = 52 * 60 + 16;
  static const _audioTotalSeconds = 9;
  static const _audioElapsedSeconds = 3;

  late int _sessionRemaining;
  bool _autoAdvance = true;
  Timer? _timer;

  static const _waveHeights = <double>[
    12, 24, 16, 32, 20, 12, 28, 40, 16, 24, 8, 20, 36, 40, 24, 12, 28, 16, 32,
    20, 12, 28, 36, 16, 24, 12, 32, 20, 12, 28, 36, 16, 24, 12, 32, 20, 8, 28,
    16, 24, 12,
  ];

  @override
  void initState() {
    super.initState();
    _sessionRemaining = _sessionTotalSeconds;
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!mounted) return;
      setState(() {
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

  String _fmtAudio(int seconds) {
    final m = (seconds ~/ 60).toString().padLeft(2, '0');
    final s = (seconds % 60).toString().padLeft(2, '0');
    return '$m:$s';
  }

  double get _audioProgress =>
      (_audioElapsedSeconds / _audioTotalSeconds).clamp(0.0, 1.0);

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
                    _audioCard(),
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
              'Answer Short Question',
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
                  label: 'Task 5 of 7',
                  value: 'Answer Short Question',
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
                  value: '5 / 7',
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
              maxLines: underline ? 2 : 1,
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
                        'ASQ',
                        style: GoogleFonts.inter(
                          fontSize: 14,
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
                          border: Border.all(
                            color: AppColors.pte002FooterBorder,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x0D000000),
                              offset: Offset(0, 1),
                              blurRadius: 2,
                            ),
                          ],
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '?',
                          style: GoogleFonts.inter(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            height: 1,
                            color: AppColors.pte002ActiveTask,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  'Answer Short Question',
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

  Widget _audioCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(17, 17, 17, 17),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.pte003AudioBorder),
      ),
      child: Column(
        children: [
          Text(
            'Listen carefully. Audio will play automatically once.',
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 16 / 12,
              color: AppColors.pte003ListenHint,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: const BoxDecoration(
                  color: AppColors.pte003SpeakerBg,
                  shape: BoxShape.circle,
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/onboarding/diag_volume.svg',
                  width: 24,
                  height: 24,
                  colorFilter: const ColorFilter.mode(
                    AppColors.pte002ActiveTask,
                    BlendMode.srcIn,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: SizedBox(
                  height: 40,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      for (final h in _waveHeights)
                        Expanded(
                          child: Align(
                            alignment: Alignment.center,
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 1),
                              height: h,
                              decoration: BoxDecoration(
                                color: AppColors.pte003Wave,
                                borderRadius: BorderRadius.circular(9999),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ClipRRect(
            borderRadius: BorderRadius.circular(9999),
            child: LinearProgressIndicator(
              value: _audioProgress,
              minHeight: 6,
              backgroundColor: AppColors.pte003AudioTrack,
              valueColor: const AlwaysStoppedAnimation<Color>(
                AppColors.pte002ActiveTask,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                _fmtAudio(_audioElapsedSeconds),
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 17 / 12,
                  color: AppColors.pte003TimeMuted,
                ),
              ),
              Text(
                _fmtAudio(_audioTotalSeconds),
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                  height: 17 / 12,
                  color: AppColors.pte003TimeMuted,
                ),
              ),
            ],
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
                'Record Now',
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
            'You have a short time to give your answer. Speak clearly in a normal volume.',
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
          Text.rich(
            TextSpan(
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                height: 17 / 12,
                color: AppColors.pte002MetaLabel,
              ),
              children: [
                const TextSpan(text: 'You will have up to '),
                TextSpan(
                  text: '10 secs',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    height: 17 / 12,
                    color: AppColors.pte002ActiveTask,
                  ),
                ),
                const TextSpan(text: ' to respond.'),
              ],
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _warningBanner() {
    return Container(
      padding: const EdgeInsets.fromLTRB(13, 13, 13, 13),
      decoration: BoxDecoration(
        color: AppColors.pte003WarnBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.pte003WarnBorder),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(
            'assets/icons/onboarding/diag_info_circle.svg',
            width: 16,
            height: 16,
            colorFilter: const ColorFilter.mode(
              AppColors.pte003WarnText,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              'Give a short and direct answer. You will not get a chance to replay the question.',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 16 / 12,
                color: AppColors.pte003WarnText,
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
