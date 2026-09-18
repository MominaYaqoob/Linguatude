import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import 'onboarding_diagnostic_reading_screen.dart';

class _DiagnosticQuestion {
  const _DiagnosticQuestion({required this.text, required this.options});

  final String text;
  final List<String> options;
}

class OnboardingDiagnosticActiveScreen extends StatefulWidget {
  const OnboardingDiagnosticActiveScreen({super.key});

  @override
  State<OnboardingDiagnosticActiveScreen> createState() =>
      _OnboardingDiagnosticActiveScreenState();
}

class _OnboardingDiagnosticActiveScreenState
    extends State<OnboardingDiagnosticActiveScreen> {
  static const _initialSeconds = 28;
  static const _playbackPosition = Duration(minutes: 1, seconds: 20);
  static const _playbackDuration = Duration(minutes: 3);
  static const _waveformHeights = [
    12.0, 24.0, 16.0, 32.0, 20.0, 40.0, 24.0, 12.0, 28.0, 16.0, 20.0, 8.0,
    24.0, 16.0, 32.0, 16.0, 12.0, 28.0, 40.0, 24.0, 12.0, 32.0, 20.0, 12.0,
    16.0,
  ];
  static const _playedBarCount = 14;

  static const _questions = [
    _DiagnosticQuestion(
      text: 'What is the main purpose of the audio?',
      options: [
        'To announce a new community initiative',
        "To report on last year's financial results",
        'To advertise a new product launch',
        'To explain changes to company policies',
      ],
    ),
    _DiagnosticQuestion(
      text: 'Who is the audio most likely intended for?',
      options: [
        'Company shareholders',
        'New employees',
        'Local residents',
        'Government officials',
      ],
    ),
    _DiagnosticQuestion(
      text: 'What action is the audience encouraged to take?',
      options: [
        'Sign up for the community program',
        'Make a donation',
        'Attend the upcoming town hall',
        'Change their account settings',
      ],
    ),
  ];

  int _secondsRemaining = _initialSeconds;
  Timer? _timer;
  bool _isPlaying = true;
  final List<int?> _selectedAnswers = [0, null, null];

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 0) {
        timer.cancel();
        return;
      }
      setState(() => _secondsRemaining--);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timerLabel {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  String _formatDuration(Duration d) {
    final minutes = d.inMinutes;
    final seconds = d.inSeconds % 60;
    return '$minutes:${seconds.toString().padLeft(2, '0')}';
  }

  bool get _allAnswered => !_selectedAnswers.contains(null);

  void _submit() {
    if (!_allAnswered) return;
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const OnboardingDiagnosticReadingScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final progress =
        _playbackPosition.inMilliseconds / _playbackDuration.inMilliseconds;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildMainHeader(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 20, 24, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildInstructionBanner(),
                    const SizedBox(height: 24),
                    _buildAudioPlayerCard(progress),
                    const SizedBox(height: 24),
                    _buildQuestionsSection(),
                  ],
                ),
              ),
            ),
            _buildStickyFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildMainHeader() {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 17),
      decoration: const BoxDecoration(
        color: AppColors.white,
        border: Border(bottom: BorderSide(color: AppColors.gray100)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.diagPrimary,
                  borderRadius: BorderRadius.circular(12),
                ),
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/onboarding/diag_headphones.svg',
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                ),
              ),
              const SizedBox(width: 12),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Listening',
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      height: 20 / 14,
                      letterSpacing: -0.35,
                      color: AppColors.slate,
                    ),
                  ),
                  Text(
                    'Section 1 of 4',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      height: 16 / 12,
                      color: AppColors.slateMuted,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
            decoration: BoxDecoration(
              color: AppColors.diagTimerPillBg,
              borderRadius: BorderRadius.circular(9999),
              border: Border.all(color: AppColors.diagTimerPillBorder),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  'assets/icons/onboarding/diag_clock.svg',
                  width: 14,
                  height: 14,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 6),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Time remaining: ',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 16 / 12,
                          color: AppColors.slateBody,
                        ),
                      ),
                      TextSpan(
                        text: _timerLabel,
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          height: 16 / 12,
                          color: AppColors.diagTimerAlert,
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
    );
  }

  Widget _buildInstructionBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.diagBannerBg,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.diagBannerBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x40000000),
            offset: Offset(0, 4),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 20,
            height: 20,
            margin: const EdgeInsets.only(top: 2),
            decoration: const BoxDecoration(
              color: AppColors.diagPrimary,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: Text(
              'i',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 16 / 12,
                color: AppColors.white,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Listen to the audio, then answer the questions below.',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 19.5 / 12,
                color: AppColors.label,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAudioPlayerCard(double progress) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(23),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: AppColors.diagCardBorder, width: 3),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 1,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: () => setState(() => _isPlaying = !_isPlaying),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    color: AppColors.diagPrimary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.diagPrimaryShadow,
                        offset: Offset(0, 4),
                        blurRadius: 6,
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: SvgPicture.asset(
                    _isPlaying
                        ? 'assets/icons/onboarding/diag_pause.svg'
                        : 'assets/icons/onboarding/diag_play.svg',
                    width: 20,
                    height: 20,
                    fit: BoxFit.contain,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(child: _buildWaveform()),
            ],
          ),
          const SizedBox(height: 16),
          _buildProgressBar(progress),
          const SizedBox(height: 16),
          _buildStatusNotice(),
        ],
      ),
    );
  }

  Widget _buildWaveform() {
    return SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (var i = 0; i < _waveformHeights.length; i++) ...[
            if (i > 0) const SizedBox(width: 4),
            Container(
              width: 4,
              height: _waveformHeights[i],
              decoration: BoxDecoration(
                color: i < _playedBarCount
                    ? AppColors.diagPrimary
                    : AppColors.diagWaveformInactive,
                borderRadius: BorderRadius.circular(9999),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildProgressBar(double progress) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 14,
          child: Stack(
            alignment: Alignment.centerLeft,
            children: [
              Container(
                height: 6,
                decoration: BoxDecoration(
                  color: AppColors.diagWaveformInactive,
                  borderRadius: BorderRadius.circular(9999),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress.clamp(0, 1),
                child: Container(
                  height: 6,
                  decoration: BoxDecoration(
                    color: AppColors.diagPrimary,
                    borderRadius: BorderRadius.circular(9999),
                  ),
                ),
              ),
              Align(
                alignment: Alignment(2 * progress.clamp(0, 1) - 1, 0),
                child: Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: AppColors.diagPrimary,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1A000000),
                        offset: Offset(0, 1),
                        blurRadius: 3,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _formatDuration(_playbackPosition),
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                height: 16.5 / 11,
                color: AppColors.dateHint,
              ),
            ),
            Text(
              _formatDuration(_playbackDuration),
              style: GoogleFonts.inter(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                height: 16.5 / 11,
                color: AppColors.dateHint,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatusNotice() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
      decoration: BoxDecoration(
        color: AppColors.diagStatusBg,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.diagStatusBorder),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/onboarding/diag_volume.svg',
            width: 16,
            height: 16,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Text(
              _isPlaying
                  ? 'Audio is playing... Questions will appear automatically.'
                  : 'Audio paused.',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 16 / 12,
                color: AppColors.diagStatusText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionsSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            'Questions (${_questions.length})',
            style: GoogleFonts.inter(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 24 / 16,
              color: AppColors.slate,
            ),
          ),
        ),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
          decoration: BoxDecoration(
            color: AppColors.diagNoticeBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.diagNoticeBorder),
          ),
          child: Row(
            children: [
              SvgPicture.asset(
                'assets/icons/onboarding/diag_info_circle.svg',
                width: 16,
                height: 16,
                fit: BoxFit.contain,
              ),
              const SizedBox(width: 8),
              Text(
                'Answer all questions before submitting.',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  height: 16 / 12,
                  color: AppColors.diagStatusText,
                ),
              ),
            ],
          ),
        ),
        for (var i = 0; i < _questions.length; i++) ...[
          const SizedBox(height: 20),
          _buildQuestion(i),
        ],
      ],
    );
  }

  Widget _buildQuestion(int index) {
    final question = _questions[index];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 20,
              height: 20,
              margin: const EdgeInsets.only(top: 2),
              decoration: const BoxDecoration(
                color: AppColors.diagPrimary,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Text(
                '${index + 1}',
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  height: 16 / 12,
                  color: AppColors.white,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                question.text,
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  height: 19.25 / 14,
                  color: AppColors.slate,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.only(left: 28),
          child: Column(
            children: [
              for (var i = 0; i < question.options.length; i++) ...[
                if (i > 0) const SizedBox(height: 8),
                _buildOption(
                  index,
                  i,
                  question.options[i],
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOption(int questionIndex, int optionIndex, String text) {
    final selected = _selectedAnswers[questionIndex] == optionIndex;
    return GestureDetector(
      onTap: () => setState(() => _selectedAnswers[questionIndex] = optionIndex),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          color: selected ? AppColors.diagOptionSelectedBg : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.diagPrimary : AppColors.diagOptionBorder,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: selected ? 18 : 16,
              height: selected ? 18 : 16,
              decoration: BoxDecoration(
                color: selected ? AppColors.diagPrimary : AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.diagPrimary : AppColors.radioBorder,
                ),
              ),
              alignment: Alignment.center,
              child: selected
                  ? SvgPicture.asset(
                      'assets/icons/onboarding/check_white.svg',
                      width: 10,
                      height: 10,
                      fit: BoxFit.contain,
                    )
                  : null,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 12,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                  height: 16 / 12,
                  color: selected ? AppColors.slate : AppColors.diagOptionText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStickyFooter() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, -4),
            blurRadius: 12,
          ),
        ],
      ),
      child: SizedBox(
        height: 52,
        child: ElevatedButton(
          onPressed: _allAnswered ? _submit : null,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.diagPrimary,
            disabledBackgroundColor:
                AppColors.diagPrimary.withValues(alpha: 0.5),
            foregroundColor: AppColors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            'Submit Section',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              height: 20 / 14,
              letterSpacing: 0.35,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }
}
