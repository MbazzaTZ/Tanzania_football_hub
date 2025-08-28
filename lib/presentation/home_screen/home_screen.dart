import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/fixture_card_widget.dart';
import './widgets/live_match_card_widget.dart';
import './widgets/news_card_widget.dart';
import './widgets/quick_stats_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _refreshController;
  bool _isRefreshing = false;
  int _currentLiveMatchIndex = 0;
  late AnimationController _liveIndicatorController;

  // Mock data for live matches
  final List<Map<String, dynamic>> _liveMatches = [
    {
      "id": 1,
      "homeTeam": {
        "name": "Simba SC",
        "logo":
            "https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=100&h=100&fit=crop&crop=center"
      },
      "awayTeam": {
        "name": "Young Africans",
        "logo":
            "https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=100&h=100&fit=crop&crop=center"
      },
      "homeScore": 2,
      "awayScore": 1,
      "minute": 67,
      "competition": "NBC Premier League"
    },
    {
      "id": 2,
      "homeTeam": {
        "name": "Azam FC",
        "logo":
            "https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=100&h=100&fit=crop&crop=center"
      },
      "awayTeam": {
        "name": "Coastal Union",
        "logo":
            "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=100&h=100&fit=crop&crop=center"
      },
      "homeScore": 0,
      "awayScore": 0,
      "minute": 23,
      "competition": "NBC Premier League"
    },
    {
      "id": 3,
      "homeTeam": {
        "name": "Kagera Sugar",
        "logo":
            "https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=100&h=100&fit=crop&crop=center"
      },
      "awayTeam": {
        "name": "Mbeya City",
        "logo":
            "https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=100&h=100&fit=crop&crop=center"
      },
      "homeScore": 1,
      "awayScore": 2,
      "minute": 89,
      "competition": "First Division"
    }
  ];

  // Mock data for today's fixtures
  final List<Map<String, dynamic>> _todayFixtures = [
    {
      "id": 4,
      "homeTeam": {
        "name": "Namungo FC",
        "logo":
            "https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=100&h=100&fit=crop&crop=center"
      },
      "awayTeam": {
        "name": "Dodoma Jiji FC",
        "logo":
            "https://images.unsplash.com/photo-1606107557195-0e29a4b5b4aa?w=100&h=100&fit=crop&crop=center"
      },
      "time": "16:00",
      "competition": "NBC Premier League"
    },
    {
      "id": 5,
      "homeTeam": {
        "name": "Mtibwa Sugar",
        "logo":
            "https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=100&h=100&fit=crop&crop=center"
      },
      "awayTeam": {
        "name": "Ihefu FC",
        "logo":
            "https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=100&h=100&fit=crop&crop=center"
      },
      "time": "19:00",
      "competition": "NBC Premier League"
    }
  ];

  // Mock data for latest news
  final List<Map<String, dynamic>> _latestNews = [
    {
      "id": 1,
      "title": "Simba SC Extends Lead at Top of NBC Premier League Table",
      "summary":
          "The Msimbazi Reds secured a crucial 2-1 victory over Young Africans in the Kariakoo Derby, extending their lead at the top of the table to 5 points.",
      "imageUrl":
          "https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=400&h=250&fit=crop&crop=center",
      "category": "League News",
      "timeAgo": "2 hours ago"
    },
    {
      "id": 2,
      "title": "Tanzania National Team Announces Squad for AFCON Qualifiers",
      "summary":
          "Coach Adel Amrouche has named a 25-man squad for the upcoming Africa Cup of Nations qualifiers against Morocco and Zambia.",
      "imageUrl":
          "https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=400&h=250&fit=crop&crop=center",
      "category": "National Team",
      "timeAgo": "5 hours ago"
    },
    {
      "id": 3,
      "title": "New Stadium Construction Begins in Dodoma",
      "summary":
          "Construction of the new 40,000-capacity stadium in Dodoma has officially begun, set to be completed by 2025.",
      "imageUrl":
          "https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=400&h=250&fit=crop&crop=center",
      "category": "Infrastructure",
      "timeAgo": "1 day ago"
    }
  ];

  // Mock data for top scorer
  final Map<String, dynamic> _topScorer = {
    "playerName": "John Bocco",
    "teamName": "Simba SC",
    "playerImage":
        "https://images.unsplash.com/photo-1472099645785-5658abf4ff4e?w=150&h=150&fit=crop&crop=face",
    "goals": 18
  };

  // Mock data for league table
  final List<Map<String, dynamic>> _leagueTable = [
    {
      "name": "Simba SC",
      "logo":
          "https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=50&h=50&fit=crop&crop=center",
      "played": 24,
      "points": 65
    },
    {
      "name": "Young Africans",
      "logo":
          "https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=50&h=50&fit=crop&crop=center",
      "played": 24,
      "points": 60
    },
    {
      "name": "Azam FC",
      "logo":
          "https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center",
      "played": 24,
      "points": 52
    }
  ];

  @override
  void initState() {
    super.initState();
    _refreshController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _liveIndicatorController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _liveIndicatorController.repeat();
    _startLiveMatchCarousel();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _refreshController.dispose();
    _liveIndicatorController.dispose();
    super.dispose();
  }

  void _startLiveMatchCarousel() {
    if (_liveMatches.isNotEmpty) {
      Future.delayed(const Duration(seconds: 10), () {
        if (mounted) {
          setState(() {
            _currentLiveMatchIndex =
                (_currentLiveMatchIndex + 1) % _liveMatches.length;
          });
          _startLiveMatchCarousel();
        }
      });
    }
  }

  Future<void> _handleRefresh() async {
    if (_isRefreshing) return;

    setState(() {
      _isRefreshing = true;
    });

    HapticFeedback.lightImpact();
    _refreshController.forward();

    // Simulate refresh delay
    await Future.delayed(const Duration(seconds: 2));

    _refreshController.reverse();
    setState(() {
      _isRefreshing = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Live data updated'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _navigateToLiveMatchCenter() {
    Navigator.pushNamed(context, '/live-match-center');
  }

  void _navigateToFixtures() {
    Navigator.pushNamed(context, '/fixtures-and-results');
  }

  void _navigateToLeagueTables() {
    Navigator.pushNamed(context, '/league-tables');
  }

  void _navigateToTeamProfile(String teamName) {
    Navigator.pushNamed(context, '/team-profile');
  }

  void _navigateToPlayerProfile() {
    Navigator.pushNamed(context, '/player-profile');
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Search'),
        content: const TextField(
          decoration: InputDecoration(
            hintText: 'Search teams, players, matches...',
            prefixIcon: Icon(Icons.search),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Search feature coming soon'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            child: const Text('Search'),
          ),
        ],
      ),
    );
  }

  void _setMatchReminder(Map<String, dynamic> fixture) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
            'Reminder set for ${(fixture["homeTeam"] as Map<String, dynamic>)["name"]} vs ${(fixture["awayTeam"] as Map<String, dynamic>)["name"]}'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showMatchContextMenu(Map<String, dynamic> match) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: EdgeInsets.all(4.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: CustomIconWidget(
                iconName: 'share',
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Share Match'),
              onTap: () {
                Navigator.pop(context);
                HapticFeedback.lightImpact();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Match shared'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'calendar_today',
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Add to Calendar'),
              onTap: () {
                Navigator.pop(context);
                HapticFeedback.lightImpact();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Added to calendar'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
            ),
            ListTile(
              leading: CustomIconWidget(
                iconName: 'info',
                size: 24,
                color: Theme.of(context).colorScheme.primary,
              ),
              title: const Text('Team Details'),
              onTap: () {
                Navigator.pop(context);
                _navigateToTeamProfile('');
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 1,
        shadowColor: isDark
            ? Colors.black.withValues(alpha: 0.3)
            : Colors.black.withValues(alpha: 0.1),
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'sports_soccer',
              size: 28,
              color: theme.colorScheme.primary,
            ),
            SizedBox(width: 3.w),
            Text(
              'Tanzania Football Hub',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            onPressed: _showSearchDialog,
            icon: CustomIconWidget(
              iconName: 'search',
              size: 24,
              color: theme.colorScheme.onSurface,
            ),
            tooltip: 'Search',
          ),
          IconButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Notifications feature coming soon'),
                  duration: Duration(seconds: 2),
                ),
              );
            },
            icon: CustomIconWidget(
              iconName: 'notifications_outlined',
              size: 24,
              color: theme.colorScheme.onSurface,
            ),
            tooltip: 'Notifications',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _handleRefresh,
        color: theme.colorScheme.primary,
        child: CustomScrollView(
          controller: _scrollController,
          slivers: [
            // Live matches section
            if (_liveMatches.isNotEmpty) ...[
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 2.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          AnimatedBuilder(
                            animation: _liveIndicatorController,
                            builder: (context, child) {
                              return Container(
                                width: 8,
                                height: 8,
                                decoration: BoxDecoration(
                                  color: (isDark
                                          ? const Color(0xFFEF5350)
                                          : const Color(0xFFD32F2F))
                                      .withValues(
                                    alpha: 0.5 +
                                        0.5 * _liveIndicatorController.value,
                                  ),
                                  shape: BoxShape.circle,
                                ),
                              );
                            },
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            'Live Now',
                            style: theme.textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      TextButton(
                        onPressed: _navigateToLiveMatchCenter,
                        child: Text(
                          'View All',
                          style: theme.textTheme.labelMedium?.copyWith(
                            color: theme.colorScheme.primary,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
                  height: 25.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    itemCount: _liveMatches.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onLongPress: () =>
                            _showMatchContextMenu(_liveMatches[index]),
                        child: LiveMatchCardWidget(
                          match: _liveMatches[index],
                          onTap: _navigateToLiveMatchCenter,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],

            // Today's fixtures section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 2.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Today\'s Fixtures',
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    TextButton(
                      onPressed: _navigateToFixtures,
                      child: Text(
                        'View All',
                        style: theme.textTheme.labelMedium?.copyWith(
                          color: theme.colorScheme.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return GestureDetector(
                    onLongPress: () =>
                        _showMatchContextMenu(_todayFixtures[index]),
                    child: FixtureCardWidget(
                      fixture: _todayFixtures[index],
                      onTap: _navigateToFixtures,
                      onSetReminder: () =>
                          _setMatchReminder(_todayFixtures[index]),
                      onViewTeams: () => _navigateToTeamProfile(''),
                    ),
                  );
                },
                childCount: _todayFixtures.length,
              ),
            ),

            // Latest news section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.fromLTRB(4.w, 3.h, 4.w, 2.h),
                child: Text(
                  'Latest News',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return NewsCardWidget(
                    news: _latestNews[index],
                    onTap: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('News article feature coming soon'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  );
                },
                childCount: _latestNews.length,
              ),
            ),

            // Quick stats section
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 3.h),
                child: QuickStatsWidget(
                  topScorer: _topScorer,
                  leagueTable: _leagueTable,
                  onViewFullTable: _navigateToLeagueTables,
                  onViewTopScorers: _navigateToPlayerProfile,
                ),
              ),
            ),

            // Bottom padding
            SliverToBoxAdapter(
              child: SizedBox(height: 10.h),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showSearchDialog,
        tooltip: 'Quick Search',
        child: CustomIconWidget(
          iconName: 'search',
          size: 24,
          color: theme.colorScheme.onPrimary,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: 0,
        selectedItemColor: theme.colorScheme.primary,
        unselectedItemColor: theme.colorScheme.onSurfaceVariant,
        backgroundColor: theme.colorScheme.surface,
        elevation: 8,
        items: [
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'home_outlined',
              size: 24,
              color: theme.colorScheme.primary,
            ),
            activeIcon: CustomIconWidget(
              iconName: 'home',
              size: 24,
              color: theme.colorScheme.primary,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Stack(
              clipBehavior: Clip.none,
              children: [
                CustomIconWidget(
                  iconName: 'sports_soccer_outlined',
                  size: 24,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
                if (_liveMatches.isNotEmpty)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isDark
                            ? const Color(0xFFEF5350)
                            : const Color(0xFFD32F2F),
                        shape: BoxShape.circle,
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
              color: theme.colorScheme.onSurfaceVariant,
            ),
            label: 'Fixtures',
          ),
          BottomNavigationBarItem(
            icon: CustomIconWidget(
              iconName: 'table_chart_outlined',
              size: 24,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            label: 'Tables',
          ),
        ],
        onTap: (index) {
          HapticFeedback.lightImpact();
          switch (index) {
            case 0:
              // Already on home
              break;
            case 1:
              _navigateToLiveMatchCenter();
              break;
            case 2:
              _navigateToFixtures();
              break;
            case 3:
              _navigateToLeagueTables();
              break;
          }
        },
      ),
    );
  }
}
