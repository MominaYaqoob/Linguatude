import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';
import '../widgets/auth_text_field.dart';
import 'onboarding/onboarding_exam_selector_screen.dart';
import 'sign_in_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({super.key});

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen> {
  final _nameController = TextEditingController(text: 'Sarah Ahmed');
  final _emailController = TextEditingController(text: 'sarah@example.com');
  final _passwordController = TextEditingController(text: 'password');
  final _confirmController = TextEditingController(text: 'password');

  final _nameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmFocus = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirm = false;
  bool _agreedToTerms = false;

  @override
  void initState() {
    super.initState();
    for (final node in [
      _nameFocus,
      _emailFocus,
      _passwordFocus,
      _confirmFocus,
    ]) {
      node.addListener(_refresh);
    }
    // Match Figma: Full Name field shown focused.
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _nameFocus.requestFocus();
    });
  }

  void _refresh() => setState(() {});

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmController.dispose();
    _nameFocus.dispose();
    _emailFocus.dispose();
    _passwordFocus.dispose();
    _confirmFocus.dispose();
    super.dispose();
  }

  void _goToSignIn() {
    final navigator = Navigator.of(context);
    if (navigator.canPop()) {
      navigator.pop();
      return;
    }
    navigator.pushReplacement(
      MaterialPageRoute(builder: (_) => const SignInScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 46, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildBrand(),
              const SizedBox(height: 32),
              Text(
                'Create your account',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  height: 42 / 24,
                  color: AppColors.heading,
                ),
              ),
              const SizedBox(height: 8),
              AuthTextField(
                label: 'Full Name',
                controller: _nameController,
                focusNode: _nameFocus,
                prefixAsset: 'assets/icons/user.svg',
                prefixWidth: 13.33,
                prefixHeight: 13.33,
                hintText: 'Sarah Ahmed',
              ),
              const SizedBox(height: 16),
              AuthTextField(
                label: 'Email',
                controller: _emailController,
                focusNode: _emailFocus,
                prefixAsset: 'assets/icons/email.svg',
                prefixWidth: 16.67,
                prefixHeight: 13.33,
                hintText: 'sarah@example.com',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),
              AuthTextField(
                label: 'Password',
                controller: _passwordController,
                focusNode: _passwordFocus,
                prefixAsset: 'assets/icons/lock.svg',
                prefixWidth: 13.33,
                prefixHeight: 17.5,
                hintText: '••••••••',
                obscureText: _obscurePassword,
                suffixAsset: 'assets/icons/eye.svg',
                suffixWidth: 18.33,
                suffixHeight: 12.5,
                onSuffixTap: () =>
                    setState(() => _obscurePassword = !_obscurePassword),
                helperText: 'Use at least 8 characters.',
              ),
              const SizedBox(height: 16),
              AuthTextField(
                label: 'Confirm Password',
                controller: _confirmController,
                focusNode: _confirmFocus,
                prefixAsset: 'assets/icons/lock.svg',
                prefixWidth: 13.33,
                prefixHeight: 17.5,
                hintText: '••••••••',
                obscureText: _obscureConfirm,
                suffixAsset: _obscureConfirm
                    ? 'assets/icons/eye.svg'
                    : 'assets/icons/eye_off.svg',
                suffixWidth: 18.33,
                suffixHeight: _obscureConfirm ? 12.5 : 16.5,
                onSuffixTap: () =>
                    setState(() => _obscureConfirm = !_obscureConfirm),
              ),
              const SizedBox(height: 8),
              _buildTermsRow(),
              const SizedBox(height: 16),
              _buildCreateAccountButton(),
              const SizedBox(height: 31),
              _buildSignInLink(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBrand() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/logo.svg',
              width: 29.33,
              height: 24,
              fit: BoxFit.contain,
            ),
            const SizedBox(width: 9.67),
            Text(
              'Linguatude',
              style: GoogleFonts.inter(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                height: 32 / 24,
                color: AppColors.primary,
              ),
            ),
          ],
        ),
        Text(
          'Start your IELTS journey today — free',
          textAlign: TextAlign.center,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            height: 24 / 16,
            color: AppColors.muted,
          ),
        ),
      ],
    );
  }

  Widget _buildTermsRow() {
    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: _agreedToTerms ? AppColors.primary : AppColors.white,
                borderRadius: BorderRadius.circular(4),
                border: Border.all(color: AppColors.primary, width: 1),
              ),
              child: _agreedToTerms
                  ? const Icon(Icons.check, size: 14, color: AppColors.white)
                  : null,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 1),
              child: Text(
                'I agree to the Terms & Privacy Policy',
                style: GoogleFonts.inter(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  height: 17.5 / 14,
                  color: AppColors.terms,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCreateAccountButton() {
    return SizedBox(
      height: 54,
      child: ElevatedButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (_) => const OnboardingExamSelectorScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryButton,
          foregroundColor: AppColors.white,
          elevation: 1,
          shadowColor: const Color(0x0D000000),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.all(17),
        ),
        child: Text(
          'Create Account',
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            height: 20 / 14,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildSignInLink() {
    return Center(
      child: GestureDetector(
        onTap: _goToSignIn,
        child: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Already have an account? ',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                  height: 22.5 / 15,
                  color: AppColors.placeholder,
                ),
              ),
              TextSpan(
                text: 'Sign In',
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w700,
                  height: 22.5 / 15,
                  color: AppColors.primaryButton,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
