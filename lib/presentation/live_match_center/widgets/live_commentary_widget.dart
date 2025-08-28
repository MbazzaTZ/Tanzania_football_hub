import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Widget for displaying live match commentary with minute-by-minute updates
class LiveCommentaryWidget extends StatefulWidget {
  final String matchId;
  final VoidCallback? onRefresh;

  const LiveCommentaryWidget({
    super.key,
    required this.matchId,
    this.onRefresh,
  });

  @override
  State<LiveCommentaryWidget> createState() => _LiveCommentaryWidgetState();
}

class _LiveCommentaryWidgetState extends State<LiveCommentaryWidget> {
  final ScrollController _scrollController = ScrollController();
  bool _autoScroll = true;

  // Mock commentary data
  final List<Map<String, dynamic>> _commentaryEvents = [
    {
      "id": 1,
      "minute": "90+3'",
      "type": "fulltime",
      "title": "Full Time",
      "description":
          "The referee blows the final whistle. Simba SC 2-1 Young Africans SC",
      "timestamp": DateTime.now().subtract(const Duration(minutes: 2)),
      "isImportant": true,
    },
    {
      "id": 2,
      "minute": "89'",
      "type": "yellow_card",
      "title": "Yellow Card",
      "description": "Hassan Kessy receives a yellow card for a late challenge",
      "player": "Hassan Kessy",
      "team": "Young Africans SC",
      "timestamp": DateTime.now().subtract(const Duration(minutes: 5)),
      "isImportant": false,
    },
    {
      "id": 3,
      "minute": "85'",
      "type": "substitution",
      "title": "Substitution",
      "description": "Meddie Kagere comes on for John Bocco",
      "playerIn": "Meddie Kagere",
      "playerOut": "John Bocco",
      "team": "Simba SC",
      "timestamp": DateTime.now().subtract(const Duration(minutes: 9)),
      "isImportant": false,
    },
    {
      "id": 4,
      "minute": "78'",
      "type": "goal",
      "title": "GOAL!",
      "description":
          "Clatous Chama scores a brilliant header from a corner kick!",
      "player": "Clatous Chama",
      "team": "Simba SC",
      "timestamp": DateTime.now().subtract(const Duration(minutes: 16)),
      "isImportant": true,
    },
    {
      "id": 5,
      "minute": "65'",
      "type": "yellow_card",
      "title": "Yellow Card",
      "description": "Joash Onyango shown yellow for dissent",
      "player": "Joash Onyango",
      "team": "Simba SC",
      "timestamp": DateTime.now().subtract(const Duration(minutes: 29)),
      "isImportant": false,
    },
    {
      "id": 6,
      "minute": "52'",
      "type": "goal",
      "title": "GOAL!",
      "description":
          "Feisal Salum equalizes with a stunning long-range effort!",
      "player": "Feisal Salum",
      "team": "Young Africans SC",
      "timestamp": DateTime.now().subtract(const Duration(minutes: 42)),
      "isImportant": true,
    },
    {
      "id": 7,
      "minute": "45+2'",
      "type": "halftime",
      "title": "Half Time",
      "description":
          "The first half comes to an end. Simba SC 1-0 Young Africans SC",
      "timestamp": DateTime.now().subtract(const Duration(minutes: 49)),
      "isImportant": true,
    },
    {
      "id": 8,
      "minute": "23'",
      "type": "goal",
      "title": "GOAL!",
      "description":
          "John Bocco opens the scoring with a tap-in from close range!",
      "player": "John Bocco",
      "team": "Simba SC",
      "timestamp": DateTime.now().subtract(const Duration(minutes: 71)),
      "isImportant": true,
    },
    {
      "id": 9,
      "minute": "1'",
      "type": "kickoff",
      "title": "Kick Off",
      "description": "The match is underway at Benjamin Mkapa Stadium",
      "timestamp": DateTime.now().subtract(const Duration(minutes: 93)),
      "isImportant": true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Disable auto-scroll if user manually scrolls
    if (_scrollController.hasClients) {
      final isAtTop = _scrollController.offset <= 100;
      if (!isAtTop && _autoScroll) {
        setState(() {
          _autoScroll = false;
        });
      }
    }
  }

  void _scrollToTop() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
      setState(() {
        _autoScroll = true;
      });
    }
  }

  IconData _getEventIcon(String type) {
    switch (type) {
      case 'goal':
        return Icons.sports_soccer;
      case 'yellow_card':
        return Icons.crop_portrait;
      case 'red_card':
        return Icons.crop_portrait;
      case 'substitution':
        return Icons.swap_horiz;
      case 'kickoff':
        return Icons.play_circle_outline;
      case 'halftime':
        return Icons.pause_circle_outline;
      case 'fulltime':
        return Icons.help_outline;
      default:
        return Icons.info_outline;
    }
  }

  Color _getEventColor(String type, bool isDark) {
    switch (type) {
      case 'goal':
        return isDark ? AppTheme.successDark : AppTheme.successLight;
      case 'yellow_card':
        return isDark ? AppTheme.warningDark : AppTheme.warningLight;
      case 'red_card':
        return isDark ? AppTheme.errorDark : AppTheme.errorLight;
      case 'substitution':
        return isDark ? AppTheme.primaryDark : AppTheme.primaryLight;
      case 'kickoff':
      case 'halftime':
      case 'fulltime':
        return isDark ? AppTheme.primaryDark : AppTheme.primaryLight;
      default:
        return isDark
            ? AppTheme.textSecondaryDark
            : AppTheme.textSecondaryLight;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Column(
      children: [
        // Auto-scroll indicator
        if (!_autoScroll)
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            decoration: BoxDecoration(
              color: (isDark ? AppTheme.primaryDark : AppTheme.primaryLight)
                  .withValues(alpha: 0.1),
              border: Border(
                bottom: BorderSide(
                  color: isDark ? AppTheme.borderDark : AppTheme.borderLight,
                  width: 1,
                ),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconWidget(
                  iconName: 'keyboard_arrow_up',
                  size: 20,
                  color: isDark ? AppTheme.primaryDark : AppTheme.primaryLight,
                ),
                SizedBox(width: 2.w),
                Text(
                  'New updates available',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color:
                        isDark ? AppTheme.primaryDark : AppTheme.primaryLight,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(width: 2.w),
                GestureDetector(
                  onTap: _scrollToTop,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color:
                          isDark ? AppTheme.primaryDark : AppTheme.primaryLight,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      'View',
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: isDark
                            ? AppTheme.onPrimaryDark
                            : AppTheme.onPrimaryLight,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),

        // Commentary list
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async {
              widget.onRefresh?.call();
              await Future.delayed(const Duration(milliseconds: 500));
            },
            child: ListView.separated(
              controller: _scrollController,
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              itemCount: _commentaryEvents.length,
              separatorBuilder: (context, index) => SizedBox(height: 2.h),
              itemBuilder: (context, index) {
                final event = _commentaryEvents[index];
                final eventType = event["type"] as String;
                final isImportant = event["isImportant"] as bool? ?? false;
                final eventColor = _getEventColor(eventType, isDark);

                return Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(12),
                    border: isImportant
                        ? Border.all(
                            color: eventColor.withValues(alpha: 0.3),
                            width: 1,
                          )
                        : null,
                    boxShadow: [
                      BoxShadow(
                        color: (isDark ? Colors.black : Colors.grey)
                            .withValues(alpha: 0.1),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(4.w),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Time and icon
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.w, vertical: 0.5.h),
                              decoration: BoxDecoration(
                                color: eventColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                event["minute"] as String,
                                style: theme.textTheme.labelMedium?.copyWith(
                                  color: eventColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                            SizedBox(height: 1.h),
                            Container(
                              padding: EdgeInsets.all(2.w),
                              decoration: BoxDecoration(
                                color: eventColor.withValues(alpha: 0.1),
                                shape: BoxShape.circle,
                              ),
                              child: CustomIconWidget(
                                iconName: _getEventIcon(eventType)
                                    .codePoint
                                    .toString(),
                                size: 20,
                                color: eventColor,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(width: 4.w),

                        // Event details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                event["title"] as String,
                                style: theme.textTheme.titleMedium?.copyWith(
                                  fontWeight: isImportant
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                  color: isImportant ? eventColor : null,
                                ),
                              ),
                              SizedBox(height: 0.5.h),
                              Text(
                                event["description"] as String,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),

                              // Player and team info
                              if (event["player"] != null) ...[
                                SizedBox(height: 1.h),
                                Row(
                                  children: [
                                    CustomIconWidget(
                                      iconName: 'person',
                                      size: 16,
                                      color: theme.colorScheme.onSurfaceVariant,
                                    ),
                                    SizedBox(width: 1.w),
                                    Text(
                                      event["player"] as String,
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    if (event["team"] != null) ...[
                                      Text(
                                        ' • ${event["team"]}',
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color: theme
                                              .colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ],

                              // Substitution details
                              if (event["playerIn"] != null &&
                                  event["playerOut"] != null) ...[
                                SizedBox(height: 1.h),
                                Row(
                                  children: [
                                    CustomIconWidget(
                                      iconName: 'arrow_upward',
                                      size: 16,
                                      color: AppTheme.successLight,
                                    ),
                                    SizedBox(width: 1.w),
                                    Text(
                                      event["playerIn"] as String,
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        color: AppTheme.successLight,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 0.5.h),
                                Row(
                                  children: [
                                    CustomIconWidget(
                                      iconName: 'arrow_downward',
                                      size: 16,
                                      color: AppTheme.errorLight,
                                    ),
                                    SizedBox(width: 1.w),
                                    Text(
                                      event["playerOut"] as String,
                                      style:
                                          theme.textTheme.bodySmall?.copyWith(
                                        color: AppTheme.errorLight,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              ],

                              // Timestamp
                              SizedBox(height: 1.h),
                              Text(
                                _formatTimestamp(
                                    event["timestamp"] as DateTime),
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${timestamp.day}/${timestamp.month}/${timestamp.year}';
    }
  }
}
