import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import 'reset_password_screen.dart';
import 'sign_in_screen.dart';

class CheckYourEmailScreen extends StatefulWidget {
  const CheckYourEmailScreen({
    super.key,
    this.email = 'sarah@example.com',
  });

  final String email;

  @override
  State<CheckYourEmailScreen> createState() => _CheckYourEmailScreenState();
}

class _CheckYourEmailScreenState extends State<CheckYourEmailScreen> {
  static const _initialSeconds = 47;

  late int _secondsRemaining;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _secondsRemaining = _initialSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining <= 0) {
        timer.cancel();
        setState(() {});
        return;
      }
      setState(() => _secondsRemaining--);
    });
  }

  void _resendEmail() {
    setState(() => _secondsRemaining = _initialSeconds);
    _startTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  String get _timerLabel {
    final minutes = _secondsRemaining ~/ 60;
    final seconds = _secondsRemaining % 60;
    return 'Resend in $minutes:${seconds.toString().padLeft(2, '0')}';
  }

  void _goToSignIn() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const SignInScreen()),
      (_) => false,
    );
  }

  void _goBack() {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
      return;
    }
    _goToSignIn();
  }

  @override
  Widget build(BuildContext context) {
    final canResend = _secondsRemaining <= 0;

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 0),
              child: Align(
                alignment: Alignment.centerLeft,
                child: _buildBackHeader(),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    const SizedBox(height: 95),
                    _buildIllustration(),
                    const SizedBox(height: 27),
                    Text(
                      'Check your email',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        height: 32 / 24,
                        letterSpacing: -0.6,
                        color: AppColors.label,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 31),
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'Reset link sent to\n',
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                height: 24 / 16,
                                color: AppColors.terms,
                              ),
                            ),
                            TextSpan(
                              text: widget.email,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                height: 24 / 16,
                                color: AppColors.terms,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildOpenEmailButton(),
                    const SizedBox(height: 16),
                    _buildResendPill(canResend),
                    const SizedBox(height: 40),
                    Opacity(
                      opacity: 0.8,
                      child: Wrap(
                        alignment: WrapAlignment.center,
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Text(
                            "Didn't receive the email? ",
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              height: 16 / 12,
                              letterSpacing: 0.3,
                              color: AppColors.terms,
                            ),
                          ),
                          GestureDetector(
                            onTap: canResend ? _resendEmail : null,
                            child: Text(
                              'Resend Email',
                              style: GoogleFonts.inter(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                height: 16 / 12,
                                letterSpacing: 0.3,
                                color: canResend
                                    ? AppColors.primaryButton
                                    : AppColors.primaryButton.withValues(
                                        alpha: 0.45,
                                      ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Opacity(
                      opacity: 0.8,
                      child: GestureDetector(
                        onTap: _goToSignIn,
                        child: Text(
                          'Back to Sign In',
                          style: GoogleFonts.inter(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            height: 16 / 12,
                            letterSpacing: 0.3,
                            color: AppColors.primaryButton,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBackHeader() {
    return GestureDetector(
      onTap: _goBack,
      behavior: HitTestBehavior.opaque,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/check_email_back.svg',
            width: 13.33,
            height: 13.33,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),
          Text(
            'Check email',
            style: GoogleFonts.manrope(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              height: 25.6 / 16,
              letterSpacing: 0.16,
              color: AppColors.label,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIllustration() {
    return SizedBox(
      width: 108,
      height: 108,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: 100,
            height: 100,
            margin: const EdgeInsets.only(bottom: 8),
            decoration: const BoxDecoration(
              color: Color(0xFFE8EEFB),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0x40000000),
                  offset: Offset(0, 4),
                  blurRadius: 4,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: SvgPicture.asset(
              'assets/icons/email_outline_lg.svg',
              width: 72,
              height: 72,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildOpenEmailButton() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: AppColors.buttonGlow,
            offset: Offset(0, 4),
            blurRadius: 14,
          ),
        ],
      ),
      child: SizedBox(
        height: 52,
        child: ElevatedButton(
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => const ResetPasswordScreen()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryButton,
            foregroundColor: AppColors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 16),
          ),
          child: Text(
            'Open Email App',
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 20 / 14,
              color: AppColors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildResendPill(bool canResend) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 13),
      decoration: BoxDecoration(
        color: AppColors.pill,
        borderRadius: BorderRadius.circular(9999),
        border: Border.all(color: AppColors.pillBorder),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D000000),
            offset: Offset(0, 1),
            blurRadius: 2,
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/email_pill.svg',
            width: 20,
            height: 16,
            fit: BoxFit.contain,
          ),
          const SizedBox(width: 8),
          Text(
            canResend ? 'Ready to resend' : _timerLabel,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w700,
              height: 20 / 14,
              color: AppColors.label,
            ),
          ),
        ],
      ),
    );
  }
}
