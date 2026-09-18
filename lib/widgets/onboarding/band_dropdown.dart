import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../theme/app_colors.dart';

class BandDropdown extends StatelessWidget {
  const BandDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.compact = false,
    this.enabled = true,
  });

  final double? value;
  final ValueChanged<double?> onChanged;
  final bool compact;
  final bool enabled;

  static final List<double> bands = [
    for (var i = 0; i <= 18; i++) i / 2.0,
  ];

  @override
  Widget build(BuildContext context) {
    final label = value == null
        ? 'Select band'
        : value!.toStringAsFixed(value! % 1 == 0 ? 1 : 1);

    if (compact) {
      return Opacity(
        opacity: enabled ? 1 : 0.5,
        child: IgnorePointer(
          ignoring: !enabled,
          child: PopupMenuButton<double>(
            onSelected: onChanged,
            offset: const Offset(0, 36),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            itemBuilder: (context) => [
              for (final band in bands)
                PopupMenuItem(
                  value: band,
                  child: Text(band.toStringAsFixed(1)),
                ),
            ],
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: const Color(0xCCE2E8F0),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      height: 16 / 12,
                      color: value == null
                          ? AppColors.slateSoft
                          : AppColors.slate,
                    ),
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    'assets/icons/onboarding/chevron_down_sm.svg',
                    width: 16.75,
                    height: 5,
                    fit: BoxFit.contain,
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Opacity(
      opacity: enabled ? 1 : 0.5,
      child: IgnorePointer(
        ignoring: !enabled,
        child: PopupMenuButton<double>(
          onSelected: onChanged,
          offset: const Offset(0, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          itemBuilder: (context) => [
            for (final band in bands)
              PopupMenuItem(
                value: band,
                child: Text(band.toStringAsFixed(1)),
              ),
          ],
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 13),
            decoration: BoxDecoration(
              color: AppColors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: AppColors.gray200),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    label,
                    style: GoogleFonts.inter(
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                      height: 20 / 14,
                      color: value == null
                          ? AppColors.muted
                          : AppColors.slate,
                    ),
                  ),
                ),
                SvgPicture.asset(
                  'assets/icons/onboarding/chevron_down.svg',
                  width: 21,
                  height: 21,
                  fit: BoxFit.contain,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
