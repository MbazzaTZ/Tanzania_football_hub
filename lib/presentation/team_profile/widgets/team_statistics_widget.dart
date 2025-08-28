import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TeamStatisticsWidget extends StatelessWidget {
  final Map<String, dynamic> teamData;

  const TeamStatisticsWidget({
    super.key,
    required this.teamData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final stats = teamData["detailedStats"] as Map<String, dynamic>? ??
        _getDefaultStats();

    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Season Performance Chart
          _buildPerformanceChart(context, stats),

          SizedBox(height: 3.h),

          // Goals Statistics
          _buildGoalsStats(context, stats),

          SizedBox(height: 3.h),

          // Defensive Statistics
          _buildDefensiveStats(context, stats),

          SizedBox(height: 3.h),

          // Disciplinary Record
          _buildDisciplinaryRecord(context, stats),

          SizedBox(height: 3.h),

          // Form Analysis
          _buildFormAnalysis(context, stats),
        ],
      ),
    );
  }

  Widget _buildPerformanceChart(
      BuildContext context, Map<String, dynamic> stats) {
    final theme = Theme.of(context);
    final matchResults = stats["matchResults"] as List? ??
        ['W', 'L', 'D', 'W', 'W', 'L', 'W', 'D', 'W', 'W'];

    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Season Performance',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),

            // Performance pie chart
            SizedBox(
              height: 30.h,
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: PieChart(
                      PieChartData(
                        sections: _buildPieChartSections(stats),
                        centerSpaceRadius: 8.w,
                        sectionsSpace: 2,
                        startDegreeOffset: -90,
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildLegendItem(
                          context,
                          'Wins',
                          '${stats["wins"] ?? 8}',
                          AppTheme.successLight,
                        ),
                        SizedBox(height: 1.h),
                        _buildLegendItem(
                          context,
                          'Draws',
                          '${stats["draws"] ?? 4}',
                          AppTheme.warningLight,
                        ),
                        SizedBox(height: 1.h),
                        _buildLegendItem(
                          context,
                          'Losses',
                          '${stats["losses"] ?? 3}',
                          AppTheme.errorLight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(
      BuildContext context, String label, String value, Color color) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Container(
          width: 3.w,
          height: 3.w,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            label,
            style: theme.textTheme.bodySmall,
          ),
        ),
        Text(
          value,
          style: theme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _buildPieChartSections(Map<String, dynamic> stats) {
    final wins = stats["wins"] as int? ?? 8;
    final draws = stats["draws"] as int? ?? 4;
    final losses = stats["losses"] as int? ?? 3;
    final total = wins + draws + losses;

    return [
      PieChartSectionData(
        color: AppTheme.successLight,
        value: wins.toDouble(),
        title: '${((wins / total) * 100).round()}%',
        radius: 12.w,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: AppTheme.warningLight,
        value: draws.toDouble(),
        title: '${((draws / total) * 100).round()}%',
        radius: 12.w,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      PieChartSectionData(
        color: AppTheme.errorLight,
        value: losses.toDouble(),
        title: '${((losses / total) * 100).round()}%',
        radius: 12.w,
        titleStyle: const TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    ];
  }

  Widget _buildGoalsStats(BuildContext context, Map<String, dynamic> stats) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Goals Statistics',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Goals Scored',
                    '${stats["goalsFor"] ?? 24}',
                    'sports_score',
                    AppTheme.successLight,
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Goals Conceded',
                    '${stats["goalsAgainst"] ?? 12}',
                    'shield',
                    AppTheme.errorLight,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Goal Difference',
                    '${((stats["goalsFor"] ?? 24) - (stats["goalsAgainst"] ?? 12))}',
                    'trending_up',
                    AppTheme.lightTheme.primaryColor,
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Clean Sheets',
                    '${stats["cleanSheets"] ?? 6}',
                    'security',
                    AppTheme.lightTheme.primaryColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDefensiveStats(
      BuildContext context, Map<String, dynamic> stats) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Defensive Performance',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),

            // Progress indicators for defensive stats
            _buildProgressStat(
              context,
              'Tackles Won',
              stats["tacklesWon"] as int? ?? 78,
              100,
              AppTheme.lightTheme.primaryColor,
            ),

            SizedBox(height: 1.h),

            _buildProgressStat(
              context,
              'Interceptions',
              stats["interceptions"] as int? ?? 65,
              100,
              AppTheme.successLight,
            ),

            SizedBox(height: 1.h),

            _buildProgressStat(
              context,
              'Clearances',
              stats["clearances"] as int? ?? 89,
              100,
              AppTheme.warningLight,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressStat(BuildContext context, String label, int value,
      int maxValue, Color color) {
    final theme = Theme.of(context);
    final percentage = (value / maxValue).clamp(0.0, 1.0);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: theme.textTheme.bodyMedium,
            ),
            Text(
              '$value%',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
          ],
        ),
        SizedBox(height: 0.5.h),
        LinearProgressIndicator(
          value: percentage,
          backgroundColor:
              theme.colorScheme.surfaceContainerHighest.withValues(alpha: 0.3),
          valueColor: AlwaysStoppedAnimation<Color>(color),
          minHeight: 1.h,
        ),
      ],
    );
  }

  Widget _buildDisciplinaryRecord(
      BuildContext context, Map<String, dynamic> stats) {
    final theme = Theme.of(context);

    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Disciplinary Record',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Yellow Cards',
                    '${stats["yellowCards"] ?? 18}',
                    'warning',
                    AppTheme.warningLight,
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Red Cards',
                    '${stats["redCards"] ?? 2}',
                    'error',
                    AppTheme.errorLight,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Fouls Committed',
                    '${stats["foulsCommitted"] ?? 145}',
                    'sports',
                    theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: _buildStatCard(
                    context,
                    'Fair Play Points',
                    '${stats["fairPlayPoints"] ?? 8.2}',
                    'thumb_up',
                    AppTheme.successLight,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormAnalysis(BuildContext context, Map<String, dynamic> stats) {
    final theme = Theme.of(context);
    final homeRecord = stats["homeRecord"] as Map<String, dynamic>? ??
        {"wins": 5, "draws": 2, "losses": 1};
    final awayRecord = stats["awayRecord"] as Map<String, dynamic>? ??
        {"wins": 3, "draws": 2, "losses": 2};

    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Home vs Away Performance',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Home',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.successLight,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'W: ${homeRecord["wins"]} D: ${homeRecord["draws"]} L: ${homeRecord["losses"]}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: 1,
                  height: 6.h,
                  color: theme.colorScheme.outline,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        'Away',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.warningLight,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        'W: ${awayRecord["wins"]} D: ${awayRecord["draws"]} L: ${awayRecord["losses"]}',
                        style: theme.textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(BuildContext context, String label, String value,
      String iconName, Color color) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(
          color: color.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: color,
            size: 24,
          ),
          SizedBox(height: 1.h),
          Text(
            value,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }

  Map<String, dynamic> _getDefaultStats() {
    return {
      "wins": 8,
      "draws": 4,
      "losses": 3,
      "goalsFor": 24,
      "goalsAgainst": 12,
      "cleanSheets": 6,
      "yellowCards": 18,
      "redCards": 2,
      "foulsCommitted": 145,
      "fairPlayPoints": 8.2,
      "tacklesWon": 78,
      "interceptions": 65,
      "clearances": 89,
      "homeRecord": {"wins": 5, "draws": 2, "losses": 1},
      "awayRecord": {"wins": 3, "draws": 2, "losses": 2},
      "matchResults": ['W', 'L', 'D', 'W', 'W', 'L', 'W', 'D', 'W', 'W'],
    };
  }
}
