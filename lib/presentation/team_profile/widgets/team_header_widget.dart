import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TeamHeaderWidget extends StatelessWidget {
  final Map<String, dynamic> teamData;
  final bool isFollowing;
  final VoidCallback onFollowToggle;

  const TeamHeaderWidget({
    super.key,
    required this.teamData,
    required this.isFollowing,
    required this.onFollowToggle,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return SliverAppBar(
      expandedHeight: 35.h,
      floating: false,
      pinned: true,
      backgroundColor: theme.colorScheme.surface,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(
          fit: StackFit.expand,
          children: [
            // Cover photo with gradient overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppTheme.lightTheme.primaryColor.withValues(alpha: 0.3),
                    AppTheme.lightTheme.primaryColor.withValues(alpha: 0.7),
                  ],
                ),
              ),
              child: CustomImageWidget(
                imageUrl: teamData["coverPhoto"] as String? ?? "",
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),

            // Content overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.transparent,
                      Colors.black.withValues(alpha: 0.8),
                    ],
                  ),
                ),
                child: SafeArea(
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          // Team logo
                          Container(
                            width: 20.w,
                            height: 20.w,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(2.w),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.2),
                                  blurRadius: 8,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(2.w),
                              child: CustomImageWidget(
                                imageUrl: teamData["logo"] as String? ?? "",
                                width: 20.w,
                                height: 20.w,
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),

                          SizedBox(width: 4.w),

                          // Team info
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  teamData["name"] as String? ?? "Team Name",
                                  style:
                                      theme.textTheme.headlineSmall?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 1.h),
                                Text(
                                  teamData["nickname"] as String? ?? "The Team",
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.9),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Follow button
                          ElevatedButton.icon(
                            onPressed: onFollowToggle,
                            icon: CustomIconWidget(
                              iconName:
                                  isFollowing ? 'favorite' : 'favorite_border',
                              color: Colors.white,
                              size: 18,
                            ),
                            label: Text(
                              isFollowing ? 'Following' : 'Follow',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isFollowing
                                  ? AppTheme.lightTheme.primaryColor
                                  : Colors.transparent,
                              foregroundColor: Colors.white,
                              side: BorderSide(
                                color: Colors.white.withValues(alpha: 0.5),
                                width: 1,
                              ),
                              padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                vertical: 1.h,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(2.w),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      actions: [
        IconButton(
          onPressed: () {
            // Share team functionality
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Sharing ${teamData["name"]}...'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          icon: CustomIconWidget(
            iconName: 'share',
            color: Colors.white,
            size: 24,
          ),
        ),
      ],
    );
  }
}
