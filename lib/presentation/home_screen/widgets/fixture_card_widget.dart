import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class FixtureCardWidget extends StatelessWidget {
  final Map<String, dynamic> fixture;
  final VoidCallback? onTap;
  final VoidCallback? onSetReminder;
  final VoidCallback? onViewTeams;

  const FixtureCardWidget({
    super.key,
    required this.fixture,
    this.onTap,
    this.onSetReminder,
    this.onViewTeams,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isDark ? const Color(0xFF424242) : const Color(0xFFE0E0E0),
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withValues(alpha: 0.2)
                  : Colors.black.withValues(alpha: 0.05),
              blurRadius: 4,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            // Time and competition
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  fixture["time"] as String,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.secondary.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    fixture["competition"] as String,
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Teams
            Row(
              children: [
                // Home team
                Expanded(
                  child: Row(
                    children: [
                      CustomImageWidget(
                        imageUrl: (fixture["homeTeam"]
                            as Map<String, dynamic>)["logo"] as String,
                        width: 10.w,
                        height: 10.w,
                        fit: BoxFit.contain,
                      ),
                      SizedBox(width: 3.w),
                      Expanded(
                        child: Text(
                          (fixture["homeTeam"] as Map<String, dynamic>)["name"]
                              as String,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),

                // VS
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 3.w),
                  padding:
                      EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.outline.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    'VS',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.outline,
                    ),
                  ),
                ),

                // Away team
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          (fixture["awayTeam"] as Map<String, dynamic>)["name"]
                              as String,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.right,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 3.w),
                      CustomImageWidget(
                        imageUrl: (fixture["awayTeam"]
                            as Map<String, dynamic>)["logo"] as String,
                        width: 10.w,
                        height: 10.w,
                        fit: BoxFit.contain,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onSetReminder,
                    icon: CustomIconWidget(
                      iconName: 'notifications_outlined',
                      size: 16,
                      color: theme.colorScheme.primary,
                    ),
                    label: Text(
                      'Remind Me',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      side: BorderSide(
                        color: theme.colorScheme.primary.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onViewTeams,
                    icon: CustomIconWidget(
                      iconName: 'info_outline',
                      size: 16,
                      color: theme.colorScheme.outline,
                    ),
                    label: Text(
                      'View Teams',
                      style: theme.textTheme.labelMedium?.copyWith(
                        color: theme.colorScheme.outline,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 1.h),
                      side: BorderSide(
                        color: theme.colorScheme.outline.withValues(alpha: 0.5),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
