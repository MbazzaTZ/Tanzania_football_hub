import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TeamOverviewWidget extends StatelessWidget {
  final Map<String, dynamic> teamData;

  const TeamOverviewWidget({
    super.key,
    required this.teamData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Team Information Card
          _buildInfoCard(context),

          SizedBox(height: 3.h),

          // Recent Form
          _buildRecentForm(context),

          SizedBox(height: 3.h),

          // Next Fixture
          _buildNextFixture(context),

          SizedBox(height: 3.h),

          // Quick Stats
          _buildQuickStats(context),
        ],
      ),
    );
  }

  Widget _buildInfoCard(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Team Information',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            _buildInfoRow(
              context,
              'Founded',
              teamData["founded"]?.toString() ?? "1960",
              'calendar_today',
            ),
            _buildInfoRow(
              context,
              'Stadium',
              teamData["stadium"] as String? ?? "National Stadium",
              'stadium',
            ),
            _buildInfoRow(
              context,
              'Manager',
              teamData["manager"] as String? ?? "John Doe",
              'person',
            ),
            _buildInfoRow(
              context,
              'League',
              teamData["league"] as String? ?? "NBC Premier League",
              'emoji_events',
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(
      BuildContext context, String label, String value, String iconName) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 1.h),
      child: Row(
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: theme.colorScheme.primary,
            size: 20,
          ),
          SizedBox(width: 3.w),
          Expanded(
            flex: 2,
            child: Text(
              label,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(
              value,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.end,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentForm(BuildContext context) {
    final theme = Theme.of(context);
    final formResults =
        teamData["recentForm"] as List? ?? ['W', 'L', 'D', 'W', 'W'];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Recent Form',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: formResults.map((result) {
                Color resultColor;
                switch (result.toString().toUpperCase()) {
                  case 'W':
                    resultColor = AppTheme.successLight;
                    break;
                  case 'L':
                    resultColor = AppTheme.errorLight;
                    break;
                  case 'D':
                    resultColor = AppTheme.warningLight;
                    break;
                  default:
                    resultColor = theme.colorScheme.onSurfaceVariant;
                }

                return Container(
                  width: 12.w,
                  height: 12.w,
                  decoration: BoxDecoration(
                    color: resultColor,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      result.toString().toUpperCase(),
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 2.h),
            Text(
              'Last 5 matches (most recent first)',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNextFixture(BuildContext context) {
    final theme = Theme.of(context);
    final nextMatch = teamData["nextFixture"] as Map<String, dynamic>? ??
        {
          "opponent": "Simba SC",
          "date": "2025-08-30",
          "time": "16:00",
          "venue": "National Stadium",
          "isHome": true,
        };

    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Next Fixture',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color:
                    theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2.w),
                border: Border.all(
                  color: theme.colorScheme.primary.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${nextMatch["isHome"] == true ? "vs" : "@"} ${nextMatch["opponent"]}',
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'schedule',
                              color: theme.colorScheme.primary,
                              size: 16,
                            ),
                            SizedBox(width: 2.w),
                            Text(
                              '${nextMatch["date"]} at ${nextMatch["time"]}',
                              style: theme.textTheme.bodyMedium,
                            ),
                          ],
                        ),
                        SizedBox(height: 0.5.h),
                        Row(
                          children: [
                            CustomIconWidget(
                              iconName: 'location_on',
                              color: theme.colorScheme.primary,
                              size: 16,
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: Text(
                                nextMatch["venue"] as String? ?? "TBA",
                                style: theme.textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  CustomIconWidget(
                    iconName: 'arrow_forward_ios',
                    color: theme.colorScheme.primary,
                    size: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickStats(BuildContext context) {
    final theme = Theme.of(context);
    final stats = teamData["seasonStats"] as Map<String, dynamic>? ??
        {
          "matchesPlayed": 15,
          "wins": 8,
          "draws": 4,
          "losses": 3,
          "goalsFor": 24,
          "goalsAgainst": 12,
        };

    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Season Statistics',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Matches',
                    stats["matchesPlayed"]?.toString() ?? "0",
                    'sports_soccer',
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Wins',
                    stats["wins"]?.toString() ?? "0",
                    'check_circle',
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Draws',
                    stats["draws"]?.toString() ?? "0",
                    'remove_circle',
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Losses',
                    stats["losses"]?.toString() ?? "0",
                    'cancel',
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Goals For',
                    stats["goalsFor"]?.toString() ?? "0",
                    'sports_score',
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Goals Against',
                    stats["goalsAgainst"]?.toString() ?? "0",
                    'shield',
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Goal Diff',
                    ((stats["goalsFor"] ?? 0) - (stats["goalsAgainst"] ?? 0))
                        .toString(),
                    'trending_up',
                  ),
                ),
                Expanded(
                  child: _buildStatItem(
                    context,
                    'Points',
                    ((stats["wins"] ?? 0) * 3 + (stats["draws"] ?? 0))
                        .toString(),
                    'emoji_events',
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(
      BuildContext context, String label, String value, String iconName) {
    final theme = Theme.of(context);

    return Column(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: theme.colorScheme.primary,
          size: 24,
        ),
        SizedBox(height: 1.h),
        Text(
          value,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
