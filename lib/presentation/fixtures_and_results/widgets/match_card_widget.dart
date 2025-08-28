import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';

class MatchCardWidget extends StatelessWidget {
  final Map<String, dynamic> match;
  final VoidCallback? onTap;
  final VoidCallback? onSetReminder;
  final VoidCallback? onTeamDetails;
  final VoidCallback? onHeadToHead;
  final VoidCallback? onShare;

  const MatchCardWidget({
    super.key,
    required this.match,
    this.onTap,
    this.onSetReminder,
    this.onTeamDetails,
    this.onHeadToHead,
    this.onShare,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isCompleted = match['status'] == 'completed';
    final isLive = match['status'] == 'live';
    final isUpcoming = match['status'] == 'upcoming';

    return Dismissible(
      key: Key(match['id'].toString()),
      direction: DismissDirection.startToEnd,
      background: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            SizedBox(width: 6.w),
            CustomIconWidget(
              iconName: 'info',
              color: theme.colorScheme.primary,
              size: 24,
            ),
            SizedBox(width: 2.w),
            Text(
              'Team Details',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.primary,
              ),
            ),
            Spacer(),
            CustomIconWidget(
              iconName: 'compare_arrows',
              color: theme.colorScheme.primary,
              size: 24,
            ),
            SizedBox(width: 2.w),
            Text(
              'H2H',
              style: GoogleFonts.inter(
                fontSize: 12.sp,
                fontWeight: FontWeight.w500,
                color: theme.colorScheme.primary,
              ),
            ),
            Spacer(),
            CustomIconWidget(
              iconName: 'share',
              color: theme.colorScheme.primary,
              size: 24,
            ),
            SizedBox(width: 6.w),
          ],
        ),
      ),
      onDismissed: (direction) {
        // Handle swipe actions
        if (onTeamDetails != null) onTeamDetails!();
      },
      child: GestureDetector(
        onTap: onTap,
        onLongPress: () => _showContextMenu(context),
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
          padding: EdgeInsets.all(4.w),
          decoration: BoxDecoration(
            color: theme.colorScheme.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isLive
                  ? theme.colorScheme.tertiary
                  : theme.colorScheme.outline.withValues(alpha: 0.2),
              width: isLive ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.shadow.withValues(alpha: 0.1),
                blurRadius: 4,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            children: [
              // Competition and time row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 6.w,
                        height: 6.w,
                        decoration: BoxDecoration(
                          color:
                              Color(int.parse(match['competition']['color'])),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(4),
                          child: CustomImageWidget(
                            imageUrl: match['competition']['logo'],
                            width: 6.w,
                            height: 6.w,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 2.w),
                      Text(
                        match['competition']['name'],
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w500,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      if (isLive) ...[
                        Container(
                          width: 2.w,
                          height: 2.w,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.tertiary,
                            shape: BoxShape.circle,
                          ),
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          'LIVE',
                          style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.tertiary,
                          ),
                        ),
                      ] else
                        Text(
                          match['time'],
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.onSurface
                                .withValues(alpha: 0.7),
                          ),
                        ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: 2.h),

              // Teams and score row
              Row(
                children: [
                  // Home team
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 16.w,
                          height: 16.w,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: theme.colorScheme.outline
                                  .withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CustomImageWidget(
                              imageUrl: match['homeTeam']['logo'],
                              width: 16.w,
                              height: 16.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          match['homeTeam']['name'],
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
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
                    child: Column(
                      children: [
                        if (isCompleted || isLive) ...[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                match['homeScore'].toString(),
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                '-',
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w400,
                                  color: theme.colorScheme.onSurface
                                      .withValues(alpha: 0.5),
                                ),
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                match['awayScore'].toString(),
                                style: GoogleFonts.jetBrainsMono(
                                  fontSize: 24.sp,
                                  fontWeight: FontWeight.w700,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ],
                          ),
                          if (isLive)
                            Text(
                              "${match['minute']}'",
                              style: GoogleFonts.inter(
                                fontSize: 10.sp,
                                fontWeight: FontWeight.w500,
                                color: theme.colorScheme.tertiary,
                              ),
                            ),
                        ] else ...[
                          Text(
                            'VS',
                            style: GoogleFonts.inter(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.w600,
                              color: theme.colorScheme.onSurface
                                  .withValues(alpha: 0.5),
                            ),
                          ),
                          SizedBox(height: 1.h),
                          if (isUpcoming && onSetReminder != null)
                            TextButton.icon(
                              onPressed: onSetReminder,
                              icon: CustomIconWidget(
                                iconName: 'notifications',
                                color: theme.colorScheme.primary,
                                size: 16,
                              ),
                              label: Text(
                                'Set Reminder',
                                style: GoogleFonts.inter(
                                  fontSize: 10.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 2.w, vertical: 0.5.h),
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
                        Container(
                          width: 16.w,
                          height: 16.w,
                          decoration: BoxDecoration(
                            color: theme.colorScheme.surface,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: theme.colorScheme.outline
                                  .withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: CustomImageWidget(
                              imageUrl: match['awayTeam']['logo'],
                              width: 16.w,
                              height: 16.w,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          match['awayTeam']['name'],
                          style: GoogleFonts.inter(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.onSurface,
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

              // Goal scorers (for completed matches)
              if (isCompleted &&
                  match['goalScorers'] != null &&
                  (match['goalScorers'] as List).isNotEmpty) ...[
                SizedBox(height: 2.h),
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: theme.colorScheme.outline.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Goal Scorers',
                        style: GoogleFonts.inter(
                          fontSize: 10.sp,
                          fontWeight: FontWeight.w600,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.7),
                        ),
                      ),
                      SizedBox(height: 0.5.h),
                      ...(match['goalScorers'] as List)
                          .map((scorer) => Padding(
                                padding: EdgeInsets.only(bottom: 0.2.h),
                                child: Text(
                                  "${scorer['name']} ${scorer['minute']}'",
                                  style: GoogleFonts.inter(
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w400,
                                    color: theme.colorScheme.onSurface,
                                  ),
                                ),
                              ))
                          .toList(),
                    ],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CustomIconWidget(
                iconName: 'calendar_today',
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              title: Text('Add to Calendar'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Added to calendar')),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'location_on',
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              title: Text('View Venue'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Venue: ${match['venue'] ?? 'TBA'}')),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'article',
                color: Theme.of(context).colorScheme.primary,
                size: 24,
              ),
              title: Text('Match Report'),
              onTap: () {
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Opening match report...')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}