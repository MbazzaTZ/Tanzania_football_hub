import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Widget for displaying live match statistics with real-time data
class MatchStatisticsWidget extends StatefulWidget {
  final String matchId;
  final VoidCallback? onRefresh;

  const MatchStatisticsWidget({
    super.key,
    required this.matchId,
    this.onRefresh,
  });

  @override
  State<MatchStatisticsWidget> createState() => _MatchStatisticsWidgetState();
}

class _MatchStatisticsWidgetState extends State<MatchStatisticsWidget> {
  // Mock statistics data
  final Map<String, dynamic> _matchStats = {
    "homeTeam": {
      "name": "Simba SC",
      "logo":
          "https://logos-world.net/wp-content/uploads/2020/06/Simba-SC-Logo.png",
      "stats": {
        "possession": 58,
        "shots": 12,
        "shotsOnTarget": 6,
        "corners": 7,
        "fouls": 14,
        "yellowCards": 2,
        "redCards": 0,
        "offsides": 3,
        "passes": 342,
        "passAccuracy": 84,
        "crosses": 18,
        "tackles": 22,
        "saves": 3,
      }
    },
    "awayTeam": {
      "name": "Young Africans SC",
      "logo":
          "https://upload.wikimedia.org/wikipedia/en/thumb/7/75/Young_Africans_SC_logo.svg/1200px-Young_Africans_SC_logo.svg.png",
      "stats": {
        "possession": 42,
        "shots": 8,
        "shotsOnTarget": 4,
        "corners": 4,
        "fouls": 11,
        "yellowCards": 1,
        "redCards": 0,
        "offsides": 2,
        "passes": 278,
        "passAccuracy": 79,
        "crosses": 12,
        "tackles": 28,
        "saves": 4,
      }
    }
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final homeStats = _matchStats["homeTeam"]["stats"] as Map<String, dynamic>;
    final awayStats = _matchStats["awayTeam"]["stats"] as Map<String, dynamic>;

    return RefreshIndicator(
      onRefresh: () async {
        widget.onRefresh?.call();
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            // Team headers
            Container(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? Colors.black : Colors.grey)
                        .withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Home team
                  Expanded(
                    child: Column(
                      children: [
                        CustomImageWidget(
                          imageUrl: _matchStats["homeTeam"]["logo"] as String,
                          width: 12.w,
                          height: 12.w,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          _matchStats["homeTeam"]["name"] as String,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),

                  // VS
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                    decoration: BoxDecoration(
                      color: (isDark
                              ? AppTheme.primaryDark
                              : AppTheme.primaryLight)
                          .withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      'VS',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: isDark
                            ? AppTheme.primaryDark
                            : AppTheme.primaryLight,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),

                  // Away team
                  Expanded(
                    child: Column(
                      children: [
                        CustomImageWidget(
                          imageUrl: _matchStats["awayTeam"]["logo"] as String,
                          width: 12.w,
                          height: 12.w,
                          fit: BoxFit.contain,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          _matchStats["awayTeam"]["name"] as String,
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 3.h),

            // Statistics
            _buildStatisticSection(
              context,
              'Match Statistics',
              [
                _StatItem('Possession', homeStats["possession"],
                    awayStats["possession"],
                    isPercentage: true),
                _StatItem('Shots', homeStats["shots"], awayStats["shots"]),
                _StatItem('Shots on Target', homeStats["shotsOnTarget"],
                    awayStats["shotsOnTarget"]),
                _StatItem(
                    'Corners', homeStats["corners"], awayStats["corners"]),
                _StatItem('Fouls', homeStats["fouls"], awayStats["fouls"]),
                _StatItem(
                    'Offsides', homeStats["offsides"], awayStats["offsides"]),
              ],
            ),

            SizedBox(height: 3.h),

            _buildStatisticSection(
              context,
              'Disciplinary',
              [
                _StatItem('Yellow Cards', homeStats["yellowCards"],
                    awayStats["yellowCards"]),
                _StatItem(
                    'Red Cards', homeStats["redCards"], awayStats["redCards"]),
              ],
            ),

            SizedBox(height: 3.h),

            _buildStatisticSection(
              context,
              'Passing & Attacking',
              [
                _StatItem('Passes', homeStats["passes"], awayStats["passes"]),
                _StatItem('Pass Accuracy', homeStats["passAccuracy"],
                    awayStats["passAccuracy"],
                    isPercentage: true),
                _StatItem(
                    'Crosses', homeStats["crosses"], awayStats["crosses"]),
                _StatItem(
                    'Tackles', homeStats["tackles"], awayStats["tackles"]),
              ],
            ),

            SizedBox(height: 3.h),

            _buildStatisticSection(
              context,
              'Goalkeeping',
              [
                _StatItem('Saves', homeStats["saves"], awayStats["saves"]),
              ],
            ),

            SizedBox(height: 2.h),
          ],
        ),
      ),
    );
  }

  Widget _buildStatisticSection(
      BuildContext context, String title, List<_StatItem> stats) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : Colors.grey).withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Section header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: (isDark ? AppTheme.primaryDark : AppTheme.primaryLight)
                  .withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                color: isDark ? AppTheme.primaryDark : AppTheme.primaryLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Statistics items
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: stats.asMap().entries.map((entry) {
                final index = entry.key;
                final stat = entry.value;

                return Column(
                  children: [
                    if (index > 0) SizedBox(height: 2.h),
                    _buildStatisticRow(context, stat),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatisticRow(BuildContext context, _StatItem stat) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final homeValue = stat.homeValue as int;
    final awayValue = stat.awayValue as int;
    final total = homeValue + awayValue;
    final homePercentage = total > 0 ? homeValue / total : 0.0;
    final awayPercentage = total > 0 ? awayValue / total : 0.0;

    return Column(
      children: [
        // Values and label
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Home value
            SizedBox(
              width: 15.w,
              child: Text(
                stat.isPercentage ? '${homeValue}%' : homeValue.toString(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.left,
              ),
            ),

            // Stat label
            Expanded(
              child: Text(
                stat.label,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            // Away value
            SizedBox(
              width: 15.w,
              child: Text(
                stat.isPercentage ? '${awayValue}%' : awayValue.toString(),
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),

        SizedBox(height: 1.h),

        // Progress bar
        Container(
          height: 6,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
          ),
          child: Row(
            children: [
              // Home team progress
              if (homePercentage > 0)
                Expanded(
                  flex: (homePercentage * 100).round(),
                  child: Container(
                    decoration: BoxDecoration(
                      color:
                          isDark ? AppTheme.primaryDark : AppTheme.primaryLight,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(3),
                        bottomLeft: Radius.circular(3),
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                    ),
                  ),
                ),

              // Away team progress
              if (awayPercentage > 0)
                Expanded(
                  flex: (awayPercentage * 100).round(),
                  child: Container(
                    decoration: BoxDecoration(
                      color: isDark
                          ? AppTheme.secondaryDark
                          : AppTheme.secondaryLight,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(3),
                        bottomLeft: Radius.circular(3),
                        topRight: Radius.circular(3),
                        bottomRight: Radius.circular(3),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatItem {
  final String label;
  final dynamic homeValue;
  final dynamic awayValue;
  final bool isPercentage;

  _StatItem(this.label, this.homeValue, this.awayValue,
      {this.isPercentage = false});
}