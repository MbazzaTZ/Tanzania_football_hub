import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import './widgets/live_commentary_widget.dart';
import './widgets/live_match_header_widget.dart';
import './widgets/match_lineups_widget.dart';
import './widgets/match_statistics_widget.dart';

/// Live Match Center screen providing comprehensive real-time match coverage
class LiveMatchCenter extends StatefulWidget {
  const LiveMatchCenter({super.key});

  @override
  State<LiveMatchCenter> createState() => _LiveMatchCenterState();
}

class _LiveMatchCenterState extends State<LiveMatchCenter>
    with TickerProviderStateMixin {
  late TabController _tabController;
  int _currentTabIndex = 0;
  bool _isLoading = false;
  bool _isConnected = true;
  String _matchId = "match_001";

  final List<String> _tabLabels = [
    'Commentary',
    'Statistics',
    'Lineups',
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: _tabLabels.length,
      vsync: this,
    );
    _tabController.addListener(_onTabChanged);
    _initializeMatchData();
  }

  @override
  void dispose() {
    _tabController.removeListener(_onTabChanged);
    _tabController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
      HapticFeedback.lightImpact();
    }
  }

  Future<void> _initializeMatchData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate loading match data
    await Future.delayed(const Duration(milliseconds: 800));

    if (mounted) {
      setState(() {
        _isLoading = false;
        _isConnected = true;
      });
    }
  }

  Future<void> _refreshMatchData() async {
    HapticFeedback.lightImpact();
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(milliseconds: 1000));

      if (mounted) {
        setState(() {
          _isLoading = false;
          _isConnected = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Match data updated'),
            duration: const Duration(seconds: 2),
            behavior: SnackBarBehavior.floating,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isConnected = false;
        });
      }
    }
  }

  void _shareMatch() {
    HapticFeedback.lightImpact();

    // Mock share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Sharing match: Simba SC 2-1 Young Africans SC'),
        duration: const Duration(seconds: 2),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        action: SnackBarAction(
          label: 'Copy Link',
          onPressed: () {
            Clipboard.setData(const ClipboardData(
              text: 'https://tanzaniafootballhub.com/match/simba-vs-yanga-live',
            ));
          },
        ),
      ),
    );
  }

  void _navigateToTeamProfile(String teamId) {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(context, '/team-profile');
  }

  void _navigateToPlayerProfile(String playerId) {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(context, '/player-profile');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Live Match Center',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: false,
        elevation: 0,
        backgroundColor: theme.colorScheme.surface,
        foregroundColor: theme.colorScheme.onSurface,
        leading: IconButton(
          icon: CustomIconWidget(
            iconName: 'arrow_back',
            size: 24,
            color: theme.colorScheme.onSurface,
          ),
          onPressed: () {
            HapticFeedback.lightImpact();
            Navigator.pop(context);
          },
        ),
        actions: [
          // Connection status indicator
          if (!_isConnected)
            Container(
              margin: EdgeInsets.only(right: 2.w),
              padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
              decoration: BoxDecoration(
                color: isDark ? AppTheme.warningDark : AppTheme.warningLight,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomIconWidget(
                    iconName: 'wifi_off',
                    size: 14,
                    color: Colors.white,
                  ),
                  SizedBox(width: 1.w),
                  Text(
                    'Offline',
                    style: theme.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),

          // More options menu
          PopupMenuButton<String>(
            icon: CustomIconWidget(
              iconName: 'more_vert',
              size: 24,
              color: theme.colorScheme.onSurface,
            ),
            onSelected: (value) {
              HapticFeedback.lightImpact();
              switch (value) {
                case 'refresh':
                  _refreshMatchData();
                  break;
                case 'share':
                  _shareMatch();
                  break;
                case 'notifications':
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Match notifications enabled'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  break;
                case 'fullscreen':
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Fullscreen mode coming soon'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                  break;
              }
            },
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'refresh',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'refresh',
                      size: 20,
                      color: theme.colorScheme.onSurface,
                    ),
                    SizedBox(width: 3.w),
                    Text('Refresh Data'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'share',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'share',
                      size: 20,
                      color: theme.colorScheme.onSurface,
                    ),
                    SizedBox(width: 3.w),
                    Text('Share Match'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'notifications',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'notifications',
                      size: 20,
                      color: theme.colorScheme.onSurface,
                    ),
                    SizedBox(width: 3.w),
                    Text('Notifications'),
                  ],
                ),
              ),
              PopupMenuItem(
                value: 'fullscreen',
                child: Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'fullscreen',
                      size: 20,
                      color: theme.colorScheme.onSurface,
                    ),
                    SizedBox(width: 3.w),
                    Text('Fullscreen'),
                  ],
                ),
              ),
            ],
          ),
        ],
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
      ),
      body: _isLoading
          ? _buildLoadingState(context)
          : Column(
              children: [
                // Sticky header with match info
                LiveMatchHeaderWidget(
                  matchId: _matchId,
                  onRefresh: _refreshMatchData,
                  onShare: _shareMatch,
                ),

                // Tab bar
                Container(
                  decoration: BoxDecoration(
                    color: theme.colorScheme.surface,
                    border: Border(
                      bottom: BorderSide(
                        color:
                            isDark ? AppTheme.borderDark : AppTheme.borderLight,
                        width: 1,
                      ),
                    ),
                  ),
                  child: TabBar(
                    controller: _tabController,
                    tabs: _tabLabels.asMap().entries.map((entry) {
                      final index = entry.key;
                      final label = entry.value;
                      final isSelected = index == _currentTabIndex;

                      return Tab(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4.w, vertical: 1.h),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              if (index == 0) ...[
                                CustomIconWidget(
                                  iconName: 'chat_bubble_outline',
                                  size: 18,
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurfaceVariant,
                                ),
                                SizedBox(width: 1.w),
                              ] else if (index == 1) ...[
                                CustomIconWidget(
                                  iconName: 'bar_chart',
                                  size: 18,
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurfaceVariant,
                                ),
                                SizedBox(width: 1.w),
                              ] else if (index == 2) ...[
                                CustomIconWidget(
                                  iconName: 'groups',
                                  size: 18,
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurfaceVariant,
                                ),
                                SizedBox(width: 1.w),
                              ],
                              Text(
                                label,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: isSelected
                                      ? FontWeight.w600
                                      : FontWeight.w400,
                                  color: isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList(),
                    labelColor: theme.colorScheme.primary,
                    unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                    indicatorColor: theme.colorScheme.primary,
                    indicatorWeight: 3,
                    indicatorSize: TabBarIndicatorSize.label,
                  ),
                ),

                // Tab content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Live Commentary
                      LiveCommentaryWidget(
                        matchId: _matchId,
                        onRefresh: _refreshMatchData,
                      ),

                      // Match Statistics
                      MatchStatisticsWidget(
                        matchId: _matchId,
                        onRefresh: _refreshMatchData,
                      ),

                      // Match Lineups
                      MatchLineupsWidget(
                        matchId: _matchId,
                        onRefresh: _refreshMatchData,
                      ),
                    ],
                  ),
                ),
              ],
            ),

      // Bottom navigation
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 1, // Live tab is selected
        onTap: (index) {
          HapticFeedback.lightImpact();
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home-screen');
              break;
            case 1:
              // Already on live match center
              break;
            case 2:
              Navigator.pushNamed(context, '/fixtures-and-results');
              break;
            case 3:
              Navigator.pushNamed(context, '/league-tables');
              break;
          }
        },
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'home_outlined',
              size: 24,
              color: theme.bottomNavigationBarTheme.unselectedItemColor ??
                  theme.colorScheme.onSurfaceVariant,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'home',
              size: 24,
              color: theme.bottomNavigationBarTheme.selectedItemColor ??
                  theme.colorScheme.primary,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                CustomIconWidget(
                  iconName: 'sports_soccer',
                  size: 24,
                  color: theme.bottomNavigationBarTheme.selectedItemColor ??
                      theme.colorScheme.primary,
                ),
                Positioned(
                  right: -2,
                  top: -2,
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: isDark ? AppTheme.errorDark : AppTheme.errorLight,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: (isDark
                                  ? AppTheme.errorDark
                                  : AppTheme.errorLight)
                              .withValues(alpha: 0.3),
                          blurRadius: 4,
                          spreadRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'calendar_today_outlined',
              size: 24,
              color: theme.bottomNavigationBarTheme.unselectedItemColor ??
                  theme.colorScheme.onSurfaceVariant,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'calendar_today',
              size: 24,
              color: theme.bottomNavigationBarTheme.selectedItemColor ??
                  theme.colorScheme.primary,
            ),
            label: 'Fixtures',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'table_chart_outlined',
              size: 24,
              color: theme.bottomNavigationBarTheme.unselectedItemColor ??
                  theme.colorScheme.onSurfaceVariant,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'table_chart',
              size: 24,
              color: theme.bottomNavigationBarTheme.selectedItemColor ??
                  theme.colorScheme.primary,
            ),
            label: 'Tables',
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor:
                AlwaysStoppedAnimation<Color>(theme.colorScheme.primary),
          ),
          SizedBox(height: 3.h),
          Text(
            'Loading match data...',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'Getting the latest updates',
            style: theme.textTheme.bodySmall?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
