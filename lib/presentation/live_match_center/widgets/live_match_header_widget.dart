import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Widget for displaying live match header with team info and score
class LiveMatchHeaderWidget extends StatefulWidget {
  final String matchId;
  final VoidCallback? onRefresh;
  final VoidCallback? onShare;

  const LiveMatchHeaderWidget({
    super.key,
    required this.matchId,
    this.onRefresh,
    this.onShare,
  });

  @override
  State<LiveMatchHeaderWidget> createState() => _LiveMatchHeaderWidgetState();
}

class _LiveMatchHeaderWidgetState extends State<LiveMatchHeaderWidget>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  // Mock match data
  final Map<String, dynamic> _matchData = {
    "id": "match_001",
    "status": "live",
    "minute": "78'",
    "period": "2nd Half",
    "homeTeam": {
      "id": "simba_sc",
      "name": "Simba SC",
      "shortName": "SIM",
      "logo":
          "https://logos-world.net/wp-content/uploads/2020/06/Simba-SC-Logo.png",
      "score": 2,
    },
    "awayTeam": {
      "id": "yanga_sc",
      "name": "Young Africans SC",
      "shortName": "YAN",
      "logo":
          "https://upload.wikimedia.org/wikipedia/en/thumb/7/75/Young_Africans_SC_logo.svg/1200px-Young_Africans_SC_logo.svg.png",
      "score": 1,
    },
    "venue": {
      "name": "Benjamin Mkapa Stadium",
      "city": "Dar es Salaam",
    },
    "competition": {
      "name": "NBC Premier League",
      "round": "Matchday 15",
    },
    "weather": {
      "temperature": "28°C",
      "condition": "Clear",
      "icon": "sunny",
    },
    "attendance": "45,000",
    "referee": "Ally Rangara",
  };

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _pulseAnimation = Tween<double>(
      begin: 1.0,
      end: 1.1,
    ).animate(CurvedAnimation(
      parent: _pulseController,
      curve: Curves.easeInOut,
    ));

    // Start pulsing animation for live matches
    if (_matchData["status"] == "live") {
      _pulseController.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isLive = _matchData["status"] == "live";

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : Colors.grey).withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          // Main match info
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: [
                // Competition and venue info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _matchData["competition"]["name"] as String,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            _matchData["competition"]["round"] as String,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isLive)
                      AnimatedBuilder(
                        animation: _pulseAnimation,
                        builder: (context, child) {
                          return Transform.scale(
                            scale: _pulseAnimation.value,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 3.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                color: isDark
                                    ? AppTheme.errorDark
                                    : AppTheme.errorLight,
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: (isDark
                                            ? AppTheme.errorDark
                                            : AppTheme.errorLight)
                                        .withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    spreadRadius: 2,
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: 8,
                                    height: 8,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    'LIVE',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                  ],
                ),

                SizedBox(height: 3.h),

                // Teams and score
                Row(
                  children: [
                    // Home team
                    Expanded(
                      child: Column(
                        children: [
                          CustomImageWidget(
                            imageUrl: _matchData["homeTeam"]["logo"] as String,
                            width: 16.w,
                            height: 16.w,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            _matchData["homeTeam"]["name"] as String,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            _matchData["homeTeam"]["shortName"] as String,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Score and match time
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                      decoration: BoxDecoration(
                        color: (isDark
                                ? AppTheme.primaryDark
                                : AppTheme.primaryLight)
                            .withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: (isDark
                                  ? AppTheme.primaryDark
                                  : AppTheme.primaryLight)
                              .withValues(alpha: 0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        children: [
                          // Score
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                _matchData["homeTeam"]["score"].toString(),
                                style: AppTheme.dataTextStyle(
                                  isLight: !isDark,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '-',
                                style: theme.textTheme.headlineLarge?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                  fontWeight: FontWeight.w300,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                _matchData["awayTeam"]["score"].toString(),
                                style: AppTheme.dataTextStyle(
                                  isLight: !isDark,
                                  fontSize: 32,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 1.h),
                          // Match time
                          if (isLive) ...[
                            Text(
                              _matchData["minute"] as String,
                              style: AppTheme.liveScoreTextStyle(
                                isLight: !isDark,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Text(
                              _matchData["period"] as String,
                              style: theme.textTheme.labelSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ] else ...[
                            Text(
                              'Full Time',
                              style: theme.textTheme.titleSmall?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),

                    // Away team
                    Expanded(
                      child: Column(
                        children: [
                          CustomImageWidget(
                            imageUrl: _matchData["awayTeam"]["logo"] as String,
                            width: 16.w,
                            height: 16.w,
                            fit: BoxFit.contain,
                          ),
                          SizedBox(height: 1.h),
                          Text(
                            _matchData["awayTeam"]["name"] as String,
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 0.5.h),
                          Text(
                            _matchData["awayTeam"]["shortName"] as String,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 3.h),

                // Match details
                Container(
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      // Venue and referee
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CustomIconWidget(
                                  iconName: 'location_on',
                                  size: 16,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                SizedBox(width: 1.w),
                                Expanded(
                                  child: Text(
                                    '${_matchData["venue"]["name"]}, ${_matchData["venue"]["city"]}',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Row(
                            children: [
                              CustomIconWidget(
                                iconName: 'sports',
                                size: 16,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                _matchData["referee"] as String,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 1.h),
                      // Weather and attendance
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                CustomIconWidget(
                                  iconName: 'wb_sunny',
                                  size: 16,
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  '${_matchData["weather"]["temperature"]} ${_matchData["weather"]["condition"]}',
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Row(
                            children: [
                              CustomIconWidget(
                                iconName: 'people',
                                size: 16,
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                              SizedBox(width: 1.w),
                              Text(
                                _matchData["attendance"] as String,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Action buttons
          Container(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.05),
              border: Border(
                top: BorderSide(
                  color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                // Refresh button
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: widget.onRefresh,
                    icon: CustomIconWidget(
                      iconName: 'refresh',
                      size: 18,
                      color: theme.colorScheme.primary,
                    ),
                    label: Text('Refresh'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    ),
                  ),
                ),

                SizedBox(width: 3.w),

                // Share button
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: widget.onShare,
                    icon: CustomIconWidget(
                      iconName: 'share',
                      size: 18,
                      color: theme.colorScheme.onPrimary,
                    ),
                    label: Text('Share'),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
