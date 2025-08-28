import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TeamFixturesWidget extends StatefulWidget {
  final Map<String, dynamic> teamData;

  const TeamFixturesWidget({
    super.key,
    required this.teamData,
  });

  @override
  State<TeamFixturesWidget> createState() => _TeamFixturesWidgetState();
}

class _TeamFixturesWidgetState extends State<TeamFixturesWidget>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      children: [
        // Tab bar
        Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w),
          decoration: BoxDecoration(
            color: theme.colorScheme.surfaceContainerHighest
                .withValues(alpha: 0.3),
            borderRadius: BorderRadius.circular(2.w),
          ),
          child: TabBar(
            controller: _tabController,
            indicator: BoxDecoration(
              color: theme.colorScheme.primary,
              borderRadius: BorderRadius.circular(2.w),
            ),
            labelColor: Colors.white,
            unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
            dividerColor: Colors.transparent,
            tabs: const [
              Tab(text: 'Upcoming'),
              Tab(text: 'Results'),
            ],
          ),
        ),

        SizedBox(height: 2.h),

        // Tab content
        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              _buildUpcomingFixtures(),
              _buildResults(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildUpcomingFixtures() {
    final upcomingMatches = widget.teamData["upcomingFixtures"] as List? ??
        _getDefaultUpcomingFixtures();

    if (upcomingMatches.isEmpty) {
      return _buildEmptyState('No upcoming fixtures', 'schedule');
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      itemCount: upcomingMatches.length,
      itemBuilder: (context, index) {
        final match = upcomingMatches[index] as Map<String, dynamic>;
        return _buildFixtureCard(match, isUpcoming: true);
      },
    );
  }

  Widget _buildResults() {
    final results =
        widget.teamData["recentResults"] as List? ?? _getDefaultResults();

    if (results.isEmpty) {
      return _buildEmptyState('No recent results', 'sports_score');
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 4.w),
      itemCount: results.length,
      itemBuilder: (context, index) {
        final match = results[index] as Map<String, dynamic>;
        return _buildFixtureCard(match, isUpcoming: false);
      },
    );
  }

  Widget _buildEmptyState(String message, String iconName) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            size: 64,
          ),
          SizedBox(height: 2.h),
          Text(
            message,
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFixtureCard(Map<String, dynamic> match,
      {required bool isUpcoming}) {
    final theme = Theme.of(context);
    final isHome = match["isHome"] as bool? ?? true;
    final opponent = match["opponent"] as String? ?? "Unknown Team";
    final date = match["date"] as String? ?? "";
    final time = match["time"] as String? ?? "";
    final venue = match["venue"] as String? ?? "";

    return Card(
      margin: EdgeInsets.only(bottom: 2.h),
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            // Match header
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        match["competition"] as String? ?? "NBC Premier League",
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        '$date at $time',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                if (!isUpcoming && match["status"] != null)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 2.w,
                      vertical: 0.5.h,
                    ),
                    decoration: BoxDecoration(
                      color: _getMatchStatusColor(match["status"] as String),
                      borderRadius: BorderRadius.circular(1.w),
                    ),
                    child: Text(
                      match["status"] as String,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(height: 2.h),

            // Teams and score
            Row(
              children: [
                // Home team
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer
                              .withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(1.5.w),
                        ),
                        child: CustomImageWidget(
                          imageUrl: isHome
                              ? (widget.teamData["logo"] as String? ?? "")
                              : (match["opponentLogo"] as String? ?? ""),
                          width: 12.w,
                          height: 12.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        isHome
                            ? (widget.teamData["name"] as String? ?? "Team")
                            : opponent,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),

                // Score or VS
                Expanded(
                  flex: 1,
                  child: Column(
                    children: [
                      if (isUpcoming)
                        Text(
                          'VS',
                          style: theme.textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        )
                      else
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 3.w,
                            vertical: 1.h,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primaryContainer
                                .withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(2.w),
                          ),
                          child: Text(
                            '${match["homeScore"] ?? 0} - ${match["awayScore"] ?? 0}',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.primary,
                            ),
                          ),
                        ),
                      if (isUpcoming) ...[
                        SizedBox(height: 1.h),
                        Text(
                          time,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),

                // Away team
                Expanded(
                  flex: 2,
                  child: Column(
                    children: [
                      Container(
                        width: 12.w,
                        height: 12.w,
                        decoration: BoxDecoration(
                          color: theme.colorScheme.primaryContainer
                              .withValues(alpha: 0.2),
                          borderRadius: BorderRadius.circular(1.5.w),
                        ),
                        child: CustomImageWidget(
                          imageUrl: !isHome
                              ? (widget.teamData["logo"] as String? ?? "")
                              : (match["opponentLogo"] as String? ?? ""),
                          width: 12.w,
                          height: 12.w,
                          fit: BoxFit.contain,
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        !isHome
                            ? (widget.teamData["name"] as String? ?? "Team")
                            : opponent,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                        ),
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Venue
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: 'location_on',
                  color: theme.colorScheme.onSurfaceVariant,
                  size: 16,
                ),
                SizedBox(width: 1.w),
                Text(
                  venue,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Color _getMatchStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'W':
        return AppTheme.successLight;
      case 'L':
        return AppTheme.errorLight;
      case 'D':
        return AppTheme.warningLight;
      default:
        return Colors.grey;
    }
  }

  List<Map<String, dynamic>> _getDefaultUpcomingFixtures() {
    return [
      {
        "id": 1,
        "opponent": "Simba SC",
        "opponentLogo":
            "https://logos-world.net/wp-content/uploads/2020/06/Simba-SC-Logo.png",
        "date": "2025-08-30",
        "time": "16:00",
        "venue": "National Stadium",
        "isHome": true,
        "competition": "NBC Premier League",
      },
      {
        "id": 2,
        "opponent": "Azam FC",
        "opponentLogo":
            "https://upload.wikimedia.org/wikipedia/en/thumb/c/c8/Azam_FC_logo.png/200px-Azam_FC_logo.png",
        "date": "2025-09-05",
        "time": "19:00",
        "venue": "Azam Complex",
        "isHome": false,
        "competition": "NBC Premier League",
      },
      {
        "id": 3,
        "opponent": "Coastal Union",
        "opponentLogo":
            "https://upload.wikimedia.org/wikipedia/en/thumb/8/8a/Coastal_Union_FC_logo.png/200px-Coastal_Union_FC_logo.png",
        "date": "2025-09-12",
        "time": "15:30",
        "venue": "National Stadium",
        "isHome": true,
        "competition": "NBC Premier League",
      },
    ];
  }

  List<Map<String, dynamic>> _getDefaultResults() {
    return [
      {
        "id": 1,
        "opponent": "Mbeya City",
        "opponentLogo":
            "https://upload.wikimedia.org/wikipedia/en/thumb/2/2c/Mbeya_City_FC_logo.png/200px-Mbeya_City_FC_logo.png",
        "date": "2025-08-20",
        "time": "16:00",
        "venue": "National Stadium",
        "isHome": true,
        "homeScore": 2,
        "awayScore": 1,
        "status": "W",
        "competition": "NBC Premier League",
      },
      {
        "id": 2,
        "opponent": "Kagera Sugar",
        "opponentLogo":
            "https://upload.wikimedia.org/wikipedia/en/thumb/5/5a/Kagera_Sugar_FC_logo.png/200px-Kagera_Sugar_FC_logo.png",
        "date": "2025-08-15",
        "time": "19:00",
        "venue": "Kaitaba Stadium",
        "isHome": false,
        "homeScore": 1,
        "awayScore": 1,
        "status": "D",
        "competition": "NBC Premier League",
      },
      {
        "id": 3,
        "opponent": "Dodoma Jiji FC",
        "opponentLogo":
            "https://upload.wikimedia.org/wikipedia/en/thumb/d/d2/Dodoma_Jiji_FC_logo.png/200px-Dodoma_Jiji_FC_logo.png",
        "date": "2025-08-10",
        "time": "15:30",
        "venue": "National Stadium",
        "isHome": true,
        "homeScore": 3,
        "awayScore": 0,
        "status": "W",
        "competition": "NBC Premier League",
      },
    ];
  }
}
