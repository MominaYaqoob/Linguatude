import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';
import '../../widgets/onboarding/band_dropdown.dart';
import '../../widgets/onboarding/onboarding_continue_button.dart';
import '../../widgets/onboarding/onboarding_header.dart';
import 'onboarding_diagnostic_intro_screen.dart';

class OnboardingTargetScoreScreen extends StatefulWidget {
  const OnboardingTargetScoreScreen({super.key});

  @override
  State<OnboardingTargetScoreScreen> createState() =>
      _OnboardingTargetScoreScreenState();
}

class _OnboardingTargetScoreScreenState
    extends State<OnboardingTargetScoreScreen> {
  bool _notSure = true;
  bool _sameTarget = false;
  bool _noTestDate = false;
  DateTime? _testDate;
  double? _reading;
  double? _writing;
  double? _listening;
  double? _speaking;
  double? _sharedBand;

  bool get _allScoresSet =>
      _reading != null &&
      _writing != null &&
      _listening != null &&
      _speaking != null;

  double? get _overall {
    if (_notSure) return 7.0;
    if (_sameTarget && _sharedBand != null) return _sharedBand;
    if (!_allScoresSet) return null;
    final avg = (_reading! + _writing! + _listening! + _speaking!) / 4;
    return (avg * 2).round() / 2.0;
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final tomorrow = DateTime(now.year, now.month, now.day).add(
      const Duration(days: 1),
    );
    final latest = DateTime(now.year + 2, now.month, now.day);
    final picked = await showDatePicker(
      context: context,
      initialDate: _testDate ?? tomorrow,
      firstDate: tomorrow,
      lastDate: latest,
    );
    if (picked != null) {
      setState(() {
        _testDate = picked;
        _noTestDate = false;
      });
    }
  }

  void _applySharedBand(double? band) {
    setState(() {
      _sharedBand = band;
      _reading = band;
      _writing = band;
      _listening = band;
      _speaking = band;
      _notSure = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final dateLabel = _testDate == null
        ? 'Select date'
        : '${_testDate!.day} ${_monthName(_testDate!.month)} ${_testDate!.year}';

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: OnboardingHeader(currentStep: 4),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'What are you aiming\nfor?',
                      style: GoogleFonts.inter(
                        fontSize: 30,
                        fontWeight: FontWeight.w600,
                        height: 36 / 30,
                        letterSpacing: -0.75,
                        color: AppColors.slate,
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Your target band scores',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 20 / 14,
                        color: AppColors.slate,
                      ),
                    ),
                    const SizedBox(height: 12),
                    GestureDetector(
                      onTap: () => setState(() {
                        _notSure = true;
                        _sameTarget = false;
                      }),
                      child: Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: AppColors.infoCardBg,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: AppColors.infoCardBorder),
                        ),
                        child: Row(
                          children: [
                            if (_notSure)
                              SvgPicture.asset(
                                'assets/icons/onboarding/radio_selected.svg',
                                width: 18,
                                height: 28,
                                fit: BoxFit.contain,
                              )
                            else
                              Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: AppColors.radioBorder,
                                  ),
                                ),
                              ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                "Not sure? We'll aim for Band 7.0 overall.",
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  height: 20 / 14,
                                  color: AppColors.slateBody,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    _toggleCard(
                      icon: 'assets/icons/onboarding/people.svg',
                      iconW: 15,
                      iconH: 12,
                      label: 'Set the same target for all skills',
                      value: _sameTarget,
                      onChanged: (v) => setState(() {
                        _sameTarget = v;
                        if (v) {
                          _notSure = false;
                          if (_sharedBand != null) {
                            _applySharedBand(_sharedBand);
                          }
                        }
                      }),
                      trailing: _sameTarget
                          ? BandDropdown(
                              value: _sharedBand,
                              compact: true,
                              onChanged: _applySharedBand,
                            )
                          : null,
                    ),
                    const SizedBox(height: 12),
                    _skillTargetCard(
                      'Reading',
                      'assets/icons/onboarding/book.svg',
                      13.5,
                      10.33,
                      _reading,
                      (v) => setState(() {
                        _reading = v;
                        _notSure = false;
                      }),
                    ),
                    const SizedBox(height: 12),
                    _skillTargetCard(
                      'Writing',
                      'assets/icons/onboarding/pencil.svg',
                      11.98,
                      11.98,
                      _writing,
                      (v) => setState(() {
                        _writing = v;
                        _notSure = false;
                      }),
                    ),
                    const SizedBox(height: 12),
                    _skillTargetCard(
                      'Listening',
                      'assets/icons/onboarding/headphones.svg',
                      12,
                      10.5,
                      _listening,
                      (v) => setState(() {
                        _listening = v;
                        _notSure = false;
                      }),
                    ),
                    const SizedBox(height: 12),
                    _skillTargetCard(
                      'Speaking',
                      'assets/icons/onboarding/mic.svg',
                      8.25,
                      12,
                      _speaking,
                      (v) => setState(() {
                        _speaking = v;
                        _notSure = false;
                      }),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.gray50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: const Color(0xFFB3C0CD)),
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
                                Text(
                                  _overall == null
                                      ? 'Overall target (calculated)'
                                      : 'Overall target (calculated): ${_overall!.toStringAsFixed(1)}',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    height: 16 / 14,
                                    color: AppColors.slate,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Average of four skills, rounded to nearest 0.5',
                                  style: GoogleFonts.inter(
                                    fontSize: 11,
                                    fontWeight: FontWeight.w400,
                                    height: 15 / 11,
                                    color: AppColors.slateMuted,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SvgPicture.asset(
                            'assets/icons/onboarding/document_percent_2.svg',
                            width: 32,
                            height: 32,
                            fit: BoxFit.contain,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.warningBg,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.warningBorder),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/onboarding/warning_triangle.svg',
                            width: 14,
                            height: 20.25,
                            fit: BoxFit.contain,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Your target score is lower than your previous result.This is fine we'll still build a plan to help you Tap Continue to proceed.",
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                                height: 17.88 / 12,
                                color: AppColors.warningText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'When is your test?',
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        height: 20 / 14,
                        color: AppColors.slate,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _toggleCard(
                      icon: 'assets/icons/onboarding/calendar.svg',
                      iconW: 10.5,
                      iconH: 12,
                      label: "I don't have a test date yet",
                      labelSize: 12,
                      value: _noTestDate,
                      onChanged: (v) => setState(() {
                        _noTestDate = v;
                        if (v) _testDate = null;
                      }),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: AppColors.gray50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: AppColors.targetBorder),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 32,
                            height: 32,
                            decoration: const BoxDecoration(
                              color: AppColors.iconChipSoft,
                              shape: BoxShape.circle,
                            ),
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              'assets/icons/onboarding/calendar.svg',
                              width: 10.5,
                              height: 12,
                              fit: BoxFit.contain,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Test date',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                height: 16 / 12,
                                color: AppColors.slate,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: _noTestDate ? null : _pickDate,
                            child: Opacity(
                              opacity: _noTestDate ? 0.5 : 1,
                              child: Container(
                                width: 144,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 13,
                                  vertical: 7,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: const Color(0xCCE2E8F0),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        dateLabel,
                                        style: GoogleFonts.inter(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w400,
                                          height: 16 / 12,
                                          color: _testDate == null
                                              ? AppColors.dateHint
                                              : AppColors.slate,
                                        ),
                                      ),
                                    ),
                                    SvgPicture.asset(
                                      'assets/icons/onboarding/calendar_sm.svg',
                                      width: 10.5,
                                      height: 12,
                                      fit: BoxFit.contain,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      child: Text(
                        'Earliest: Tomorrow — Latest: 2 years from today',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w400,
                          height: 15 / 11,
                          color: AppColors.dateSubtext,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
              child: OnboardingContinueButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => const OnboardingDiagnosticIntroScreen(),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _monthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
    ];
    return months[month - 1];
  }

  Widget _toggleCard({
    required String icon,
    required double iconW,
    required double iconH,
    required String label,
    required bool value,
    required ValueChanged<bool> onChanged,
    double labelSize = 13,
    Widget? trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.targetBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.iconChipSoft,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              icon,
              width: iconW,
              height: iconH,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: labelSize,
                fontWeight: FontWeight.w600,
                height: 16 / labelSize,
                color: AppColors.slate,
              ),
            ),
          ),
          if (trailing != null) ...[
            trailing,
            const SizedBox(width: 8),
          ],
          Switch.adaptive(
            value: value,
            activeThumbColor: AppColors.white,
            activeTrackColor: AppColors.primaryButton,
            inactiveThumbColor: AppColors.white,
            inactiveTrackColor: AppColors.toggleOff,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  Widget _skillTargetCard(
    String label,
    String icon,
    double iconW,
    double iconH,
    double? value,
    ValueChanged<double?> onChanged,
  ) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.gray50,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.targetBorder),
      ),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: const BoxDecoration(
              color: AppColors.iconChipSoft,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: SvgPicture.asset(
              icon,
              width: iconW,
              height: iconH,
              fit: BoxFit.contain,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                height: 16 / 13,
                color: AppColors.slate,
              ),
            ),
          ),
          BandDropdown(
            value: value,
            compact: true,
            enabled: !_notSure && !_sameTarget,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }
}
