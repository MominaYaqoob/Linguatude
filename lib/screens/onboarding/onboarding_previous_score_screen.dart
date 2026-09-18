import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../../widgets/onboarding/band_dropdown.dart';
import '../../widgets/onboarding/onboarding_continue_button.dart';
import '../../widgets/onboarding/onboarding_header.dart';
import 'onboarding_target_score_screen.dart';

class OnboardingPreviousScoreScreen extends StatefulWidget {
  const OnboardingPreviousScoreScreen({super.key});

  @override
  State<OnboardingPreviousScoreScreen> createState() =>
      _OnboardingPreviousScoreScreenState();
}

class _OnboardingPreviousScoreScreenState
    extends State<OnboardingPreviousScoreScreen> {
  bool _firstTime = false;
  bool _showValidation = false;
  double? _reading;
  double? _writing;
  double? _listening;
  double? _speaking;

  bool get _allScoresSet =>
      _reading != null &&
      _writing != null &&
      _listening != null &&
      _speaking != null;

  double? get _overall {
    if (!_allScoresSet) return null;
    final avg = (_reading! + _writing! + _listening! + _speaking!) / 4;
    return (avg * 2).round() / 2.0;
  }

  void _continue() {
    if (!_firstTime && !_allScoresSet) {
      setState(() => _showValidation = true);
      return;
    }
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const OnboardingTargetScoreScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scoresEnabled = !_firstTime;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: OnboardingHeader(currentStep: 3),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Have you taken IELTS\nbefore?',
                      style: GoogleFonts.inter(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        height: 36 / 30,
                        letterSpacing: -0.75,
                        color: AppColors.slate,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      padding: const EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFDBDCDE)),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                          BoxShadow(
                            color: Color(0x0D000000),
                            offset: Offset(0, 1),
                            blurRadius: 2,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              'This is my first time taking IELTS',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                height: 20 / 14,
                                color: AppColors.gray800,
                              ),
                            ),
                          ),
                          Switch.adaptive(
                            value: _firstTime,
                            activeThumbColor: AppColors.white,
                            activeTrackColor: AppColors.primaryButton,
                            inactiveThumbColor: AppColors.white,
                            inactiveTrackColor: AppColors.gray200,
                            onChanged: (v) => setState(() {
                              _firstTime = v;
                              _showValidation = false;
                            }),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        'Use the 0–9 IELTS band scale. Select your most recent result.',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w400,
                          height: 16 / 12,
                          color: AppColors.muted,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Enter your most recent scores',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 20 / 14,
                        color: AppColors.heading,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _skillField('Reading', _reading, (v) {
                      setState(() {
                        _reading = v;
                        _showValidation = false;
                      });
                    }, scoresEnabled),
                    const SizedBox(height: 12),
                    _skillField('Writing', _writing, (v) {
                      setState(() {
                        _writing = v;
                        _showValidation = false;
                      });
                    }, scoresEnabled),
                    const SizedBox(height: 12),
                    _skillField('Listening', _listening, (v) {
                      setState(() {
                        _listening = v;
                        _showValidation = false;
                      });
                    }, scoresEnabled),
                    const SizedBox(height: 12),
                    _skillField('Speaking', _speaking, (v) {
                      setState(() {
                        _speaking = v;
                        _showValidation = false;
                      });
                    }, scoresEnabled),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(17),
                      decoration: BoxDecoration(
                        color: AppColors.overallBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.overallBorder),
                        boxShadow: const [
                          BoxShadow(
                            color: Color(0x40000000),
                            offset: Offset(0, 4),
                            blurRadius: 4,
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text.rich(
                                  TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Overall ',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700,
                                          height: 16 / 12,
                                          color: AppColors.heading,
                                        ),
                                      ),
                                      TextSpan(
                                        text: _overall == null
                                            ? '(calculated)'
                                            : '(calculated): ${_overall!.toStringAsFixed(1)}',
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 16 / 12,
                                          color: AppColors.muted,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Average of four skills, rounded to nearest 0.5',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    height: 16.5 / 11,
                                    color: AppColors.muted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/onboarding/document_percent.svg',
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                    if (_showValidation) ...[
                      const SizedBox(height: 16),
                      Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          color: AppColors.errorBg,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: AppColors.errorBorder),
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset(
                              'assets/icons/onboarding/error_alert.svg',
                              width: 16,
                              height: 16,
                              fit: BoxFit.contain,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'Please select a score for all four skills to continue.',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400,
                                  height: 16 / 12,
                                  color: AppColors.errorText,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: OnboardingContinueButton(onPressed: _continue),
            ),
          ],
        ),
      ),
    );
  }

  Widget _skillField(
    String label,
    double? value,
    ValueChanged<double?> onChanged,
    bool enabled,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            height: 16 / 12,
            color: AppColors.gray700,
          ),
        ),
        const SizedBox(height: 4),
        BandDropdown(
          value: value,
          onChanged: onChanged,
          enabled: enabled,
        ),
      ],
    );
  }
}
