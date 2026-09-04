import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

/// NenilCard — Accessible elevated card widget with high contrast, large icon, and audio trigger support.
class NenilCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final VoidCallback onTap;
  final Color accentColor;
  final Color? backgroundColor;
  final Widget? trailing;

  const NenilCard({
    super.key,
    required this.title,
    this.subtitle,
    required this.icon,
    required this.onTap,
    this.accentColor = AppColors.primary,
    this.backgroundColor,
    this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: AppDimensions.elevationMedium,
      color: backgroundColor ?? AppColors.surface,
      margin: const EdgeInsets.symmetric(vertical: AppDimensions.spaceS),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.spaceL),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(AppDimensions.spaceM),
                decoration: BoxDecoration(
                  color: accentColor.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: AppDimensions.iconLarge, color: accentColor),
              ),
              const SizedBox(width: AppDimensions.spaceL),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: AppColors.onBackground,
                      ),
                    ),
                    if (subtitle != null) ...[
                      const SizedBox(height: AppDimensions.spaceXS),
                      Text(
                        subtitle!,
                        style: TextStyle(
                          fontSize: 16,
                          color: AppColors.onBackground.withOpacity(0.7),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      ),
    );
  }
}
