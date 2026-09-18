import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';

class OnboardingDiagnosticReadingScreen extends StatefulWidget {
  const OnboardingDiagnosticReadingScreen({super.key});

  @override
  State<OnboardingDiagnosticReadingScreen> createState() =>
      _OnboardingDiagnosticReadingScreenState();
}

class _OnboardingDiagnosticReadingScreenState
    extends State<OnboardingDiagnosticReadingScreen> {
  static const _initialSeconds = 28;
  static const _passage =
      'Urban air quality monitoring has undergone dramatic '
      'transformation with the widespread adoption of low-cost '
      'sensor networks. These compact devices, once limited to '
      'industrial applications, are now being deployed across '
      'cities to provide real-time data on air pollution levels. By '
      'enabling dense data collection at a fraction of traditional '
      'costs, low-cost sensors empower communities and '
      'policymakers to identify pollution hotspots and take timely '
      'action to protect public health...';
  static const _options = [
    'replaced traditional monitoring entirely',
    'increased data density significantly',
    'reduced overall accuracy',
    'been banned in most cities',
  ];

  int _secondsRemaining = _initialSeconds;
  Timer? _timer;
  bool _passageExpanded = true;
  int? _selectedOption = 1;

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

  void _continue() {
    if (_selectedOption == null) return;
    // ONBD-006 Writing/Speaking sections are not built yet — nothing further to navigate to.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMainHeader(),
              const SizedBox(height: 16),
              _buildInstructionBanner(),
              const SizedBox(height: 16),
              _buildPassageCard(),
              const SizedBox(height: 16),
              _buildQuestionSection(),
              const SizedBox(height: 24),
              _buildContinueButton(),
              const SizedBox(height: 16),
              _buildSecurityFooter(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.diagPrimary,
                borderRadius: BorderRadius.circular(8),
              ),
              alignment: Alignment.center,
              child: const Icon(
                Icons.bolt_rounded,
                size: 20,
                color: AppColors.white,
              ),
            ),
            const SizedBox(width: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Reading',
                  style: GoogleFonts.inter(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    height: 20 / 16,
                    color: AppColors.slate,
                  ),
                ),
                Text(
                  'Section 2 of 4',
                  style: GoogleFonts.inter(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
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
              const Icon(
                Icons.access_time_rounded,
                size: 14,
                color: AppColors.slateBody,
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
    );
  }

  Widget _buildInstructionBanner() {
    return Container(
      padding: const EdgeInsets.all(17),
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
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.all(Radius.circular(12)),
              boxShadow: [
                BoxShadow(
                  color: Color(0x0D000000),
                  offset: Offset(0, 1),
                  blurRadius: 1,
                ),
              ],
            ),
            alignment: Alignment.center,
            child: const Icon(
              Icons.menu_book_rounded,
              size: 20,
              color: AppColors.diagPrimary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Read the passage and answer the questions.',
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: FontWeight.w700,
                height: 16.5 / 12,
                color: AppColors.diagBodyText,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPassageCard() {
    return Container(
      padding: const EdgeInsets.fromLTRB(17, 16, 17, 17),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.diagCardBorderSoft),
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
          Text(
            _passage,
            maxLines: _passageExpanded ? null : 3,
            overflow: _passageExpanded ? null : TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w400,
              height: 19.5 / 12,
              color: AppColors.slateBody,
            ),
          ),
          const SizedBox(height: 12),
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => setState(() => _passageExpanded = !_passageExpanded),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: AppColors.diagChipBg,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _passageExpanded ? 'Read less' : 'Read more',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        height: 16 / 12,
                        color: AppColors.diagPrimary,
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      _passageExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      size: 16,
                      color: AppColors.diagPrimary,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'QUESTION 2 OF 3',
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 16 / 12,
            letterSpacing: 0.6,
            color: AppColors.slateMuted,
          ),
        ),
        const SizedBox(height: 12),
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
              const Icon(
                Icons.info_outline_rounded,
                size: 16,
                color: AppColors.diagStatusText,
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
        const SizedBox(height: 16),
        Text(
          'According to the passage, low-cost sensors have',
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w700,
            height: 22 / 16,
            color: AppColors.slate,
          ),
        ),
        const SizedBox(height: 16),
        for (var i = 0; i < _options.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          _buildOption(i),
        ],
      ],
    );
  }

  Widget _buildOption(int index) {
    final selected = _selectedOption == index;
    return GestureDetector(
      onTap: () => setState(() => _selectedOption = index),
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(selected ? 18 : 17),
        decoration: BoxDecoration(
          color: selected
              ? AppColors.diagOptionSelectedBgSoft
              : AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: selected ? AppColors.diagPrimary : AppColors.diagCardBorderSoft,
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: selected ? AppColors.diagPrimary : AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.diagPrimary : AppColors.radioBorder,
                  width: 2,
                ),
              ),
              alignment: Alignment.center,
              child: selected
                  ? const Icon(Icons.check, size: 12, color: AppColors.white)
                  : null,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                _options[index],
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                  height: 20 / 14,
                  color: selected ? AppColors.slate : AppColors.diagBodyText,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildContinueButton() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: AppColors.diagContinueShadow,
            offset: Offset(0, 10),
            blurRadius: 15,
            spreadRadius: -3,
          ),
          BoxShadow(
            color: AppColors.diagContinueShadow,
            offset: Offset(0, 4),
            blurRadius: 6,
            spreadRadius: -4,
          ),
        ],
      ),
      child: SizedBox(
        height: 56,
        child: ElevatedButton(
          onPressed: _selectedOption != null ? _continue : null,
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Continue',
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  height: 24 / 16,
                  color: AppColors.white,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_rounded,
                size: 20,
                color: AppColors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSecurityFooter() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _footerItem('All answers are saved automatically'),
          _footerItem('Secure & private'),
        ],
      ),
    );
  }

  Widget _footerItem(String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(
          Icons.verified_user_outlined,
          size: 14,
          color: AppColors.slateMuted,
        ),
        const SizedBox(width: 4),
        Text(
          text,
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w600,
            height: 16.5 / 11,
            color: AppColors.slateMuted,
          ),
        ),
      ],
    );
  }
}
