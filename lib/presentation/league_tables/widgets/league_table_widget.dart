import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';
import '../../../widgets/custom_image_widget.dart';

class LeagueTableWidget extends StatelessWidget {
  final Map<String, dynamic> competitionData;
  final Function(Map<String, dynamic>) onTeamTap;
  final Function(Map<String, dynamic>) onTeamLongPress;

  const LeagueTableWidget({
    super.key,
    required this.competitionData,
    required this.onTeamTap,
    required this.onTeamLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final teams = competitionData['teams'] as List<Map<String, dynamic>>;

    return Column(
      children: [
        // Competition header
        Container(
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            border: Border(
              bottom: BorderSide(
                color:
                    isDark ? const Color(0xFF424242) : const Color(0xFFE0E0E0),
                width: 1,
              ),
            ),
          ),
          child: Row(
            children: [
              if (competitionData['logo'] != null) ...[
                CustomImageWidget(
                  imageUrl: competitionData['logo'] as String,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
                SizedBox(width: 3.w),
              ],
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      competitionData['name'] as String,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Matchday ${competitionData['currentMatchday']}',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color:
                            theme.colorScheme.onSurface.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Table header
        Container(
          padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF2E2E2E) : const Color(0xFFF5F5F5),
            border: Border(
              bottom: BorderSide(
                color:
                    isDark ? const Color(0xFF424242) : const Color(0xFFE0E0E0),
                width: 1,
              ),
            ),
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                SizedBox(
                  width: 8.w,
                  child: Text(
                    'Pos',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 2.w),
                SizedBox(
                  width: 40.w,
                  child: Text(
                    'Team',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                  ),
                ),
                SizedBox(width: 2.w),
                SizedBox(
                  width: 8.w,
                  child: Text(
                    'P',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 2.w),
                SizedBox(
                  width: 8.w,
                  child: Text(
                    'W',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 2.w),
                SizedBox(
                  width: 8.w,
                  child: Text(
                    'D',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 2.w),
                SizedBox(
                  width: 8.w,
                  child: Text(
                    'L',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 2.w),
                SizedBox(
                  width: 10.w,
                  child: Text(
                    'GD',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                SizedBox(width: 2.w),
                SizedBox(
                  width: 10.w,
                  child: Text(
                    'Pts',
                    style: theme.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.colorScheme.onSurface.withValues(alpha: 0.8),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),

        // Table rows
        Expanded(
          child: ListView.builder(
            itemCount: teams.length,
            itemBuilder: (context, index) {
              final team = teams[index];
              final position = index + 1;

              return _buildTableRow(
                context,
                team,
                position,
                theme,
                isDark,
                index,
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildTableRow(
    BuildContext context,
    Map<String, dynamic> team,
    int position,
    ThemeData theme,
    bool isDark,
    int index,
  ) {
    Color? positionColor;

    // Position indicators based on league standings
    if (position <= 2) {
      // Champions League qualification
      positionColor = const Color(0xFF4CAF50);
    } else if (position <= 4) {
      // Europa League qualification
      positionColor = const Color(0xFF2196F3);
    } else if (position >= 17) {
      // Relegation zone
      positionColor = const Color(0xFFD32F2F);
    }

    return GestureDetector(
      onTap: () => onTeamTap(team),
      onLongPress: () => onTeamLongPress(team),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 1.5.h),
        decoration: BoxDecoration(
          color: index % 2 == 0
              ? (isDark ? const Color(0xFF1E1E1E) : Colors.white)
              : (isDark ? const Color(0xFF2E2E2E) : const Color(0xFFFAFAFA)),
          border: Border(
            bottom: BorderSide(
              color: isDark
                  ? const Color(0xFF424242).withValues(alpha: 0.3)
                  : const Color(0xFFE0E0E0).withValues(alpha: 0.3),
              width: 0.5,
            ),
          ),
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              // Position with color indicator
              SizedBox(
                width: 8.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (positionColor != null) ...[
                      Container(
                        width: 3,
                        height: 20,
                        decoration: BoxDecoration(
                          color: positionColor,
                          borderRadius: BorderRadius.circular(1.5),
                        ),
                      ),
                      SizedBox(width: 1.w),
                    ],
                    Text(
                      position.toString(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2.w),

              // Team info
              SizedBox(
                width: 40.w,
                child: Row(
                  children: [
                    CustomImageWidget(
                      imageUrl: team['logo'] as String,
                      width: 24,
                      height: 24,
                      fit: BoxFit.contain,
                    ),
                    SizedBox(width: 2.w),
                    Expanded(
                      child: Text(
                        team['name'] as String,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 2.w),

              // Statistics
              SizedBox(
                width: 8.w,
                child: Text(
                  team['played'].toString(),
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 2.w),
              SizedBox(
                width: 8.w,
                child: Text(
                  team['won'].toString(),
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 2.w),
              SizedBox(
                width: 8.w,
                child: Text(
                  team['drawn'].toString(),
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 2.w),
              SizedBox(
                width: 8.w,
                child: Text(
                  team['lost'].toString(),
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 2.w),
              SizedBox(
                width: 10.w,
                child: Text(
                  team['goalDifference'] >= 0
                      ? '+${team['goalDifference']}'
                      : team['goalDifference'].toString(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: team['goalDifference'] >= 0
                        ? const Color(0xFF4CAF50)
                        : const Color(0xFFD32F2F),
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(width: 2.w),
              SizedBox(
                width: 10.w,
                child: Text(
                  team['points'].toString(),
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}