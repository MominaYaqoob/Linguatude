import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../theme/app_colors.dart';

class AppBottomNavItem {
  const AppBottomNavItem({
    required this.icon,
    required this.label,
    this.active = false,
    this.iconSize = 20,
    this.onTap,
  });

  final String icon;
  final String label;
  final bool active;
  final double iconSize;
  final VoidCallback? onTap;
}

/// Shared bottom navigation — SafeArea-safe, overflow-proof on narrow views.
class AppBottomNav extends StatelessWidget {
  const AppBottomNav({
    super.key,
    required this.items,
    this.activeColor = AppColors.diagPrimary,
    this.inactiveColor = AppColors.homeNavInactive,
    this.borderColor = AppColors.homeLessonBorder,
  });

  final List<AppBottomNavItem> items;
  final Color activeColor;
  final Color inactiveColor;
  final Color borderColor;

  static const _contentHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: AppColors.white,
          border: Border(top: BorderSide(color: borderColor)),
        ),
        child: SafeArea(
          top: false,
          minimum: EdgeInsets.zero,
          child: SizedBox(
            height: _contentHeight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: Row(
                children: [
                  for (final item in items)
                    Expanded(
                      child: _NavTile(
                        item: item,
                        activeColor: activeColor,
                        inactiveColor: inactiveColor,
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavTile extends StatelessWidget {
  const _NavTile({
    required this.item,
    required this.activeColor,
    required this.inactiveColor,
  });

  final AppBottomNavItem item;
  final Color activeColor;
  final Color inactiveColor;

  @override
  Widget build(BuildContext context) {
    final color = item.active ? activeColor : inactiveColor;
    return InkWell(
      onTap: item.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              item.icon,
              width: item.iconSize,
              height: item.iconSize,
              fit: BoxFit.contain,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            const SizedBox(height: 2),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                item.label,
                maxLines: 1,
                softWrap: false,
                style: GoogleFonts.inter(
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                  height: 1.2,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
