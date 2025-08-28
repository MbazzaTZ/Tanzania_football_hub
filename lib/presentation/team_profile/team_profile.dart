import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import './widgets/team_fixtures_widget.dart';
import './widgets/team_header_widget.dart';
import './widgets/team_overview_widget.dart';
import './widgets/team_squad_widget.dart';
import './widgets/team_statistics_widget.dart';

class TeamProfile extends StatefulWidget {
  const TeamProfile({super.key});

  @override
  State<TeamProfile> createState() => _TeamProfileState();
}

class _TeamProfileState extends State<TeamProfile>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _isFollowing = false;
  bool _isLoading = false;

  // Mock team data
  final Map<String, dynamic> _teamData = {
    "id": 1,
    "name": "Young Africans SC",
    "nickname": "Yanga",
    "logo":
        "https://upload.wikimedia.org/wikipedia/en/thumb/c/c8/Young_Africans_SC_logo.png/200px-Young_Africans_SC_logo.png",
    "coverPhoto":
        "https://images.pexels.com/photos/274506/pexels-photo-274506.jpeg",
    "founded": 1935,
    "stadium": "Benjamin Mkapa Stadium",
    "manager": "Nasreddine Nabi",
    "league": "NBC Premier League",
    "recentForm": ['W', 'W', 'D', 'W', 'L'],
    "nextFixture": {
      "opponent": "Simba SC",
      "date": "2025-08-30",
      "time": "16:00",
      "venue": "National Stadium",
      "isHome": true,
    },
    "seasonStats": {
      "matchesPlayed": 15,
      "wins": 8,
      "draws": 4,
      "losses": 3,
      "goalsFor": 24,
      "goalsAgainst": 12,
    },
    "squad": [
      {
        "id": 1,
        "name": "Metacha Mnata",
        "position": "GK",
        "jerseyNumber": 1,
        "age": 28,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 2,
        "name": "Bakari Mwamnyeto",
        "position": "DF",
        "jerseyNumber": 2,
        "age": 26,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 3,
        "name": "Dickson Job",
        "position": "DF",
        "jerseyNumber": 3,
        "age": 29,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 4,
        "name": "Kelvin Yondani",
        "position": "DF",
        "jerseyNumber": 4,
        "age": 27,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 5,
        "name": "Ibrahim Hamad",
        "position": "DF",
        "jerseyNumber": 5,
        "age": 24,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 6,
        "name": "Mudathir Yahya",
        "position": "MF",
        "jerseyNumber": 6,
        "age": 25,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 7,
        "name": "Feisal Salum",
        "position": "MF",
        "jerseyNumber": 8,
        "age": 28,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 8,
        "name": "Stephane Aziz Ki",
        "position": "MF",
        "jerseyNumber": 10,
        "age": 26,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 9,
        "name": "Prince Dube",
        "position": "FW",
        "jerseyNumber": 9,
        "age": 30,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 10,
        "name": "Clement Mzize",
        "position": "FW",
        "jerseyNumber": 7,
        "age": 32,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
    ],
    "upcomingFixtures": [
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
    ],
    "recentResults": [
      {
        "id": 1,
        "opponent": "Mbeya City",
        "opponentLogo":
            "https://upload.wikimedia.org/wikipedia/en/thumb/2/2c/Mbeya_City_FC_logo.png/200px-Mbeya_City_FC_logo.png",
        "date": "2025-08-20",
        "time": "16:00",
        "venue": "Benjamin Mkapa Stadium",
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
    ],
    "detailedStats": {
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
    },
  };

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: _refreshTeamData,
        child: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              TeamHeaderWidget(
                teamData: _teamData,
                isFollowing: _isFollowing,
                onFollowToggle: _toggleFollow,
              ),
              SliverPersistentHeader(
                delegate: _SliverTabBarDelegate(
                  TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Overview'),
                      Tab(text: 'Squad'),
                      Tab(text: 'Fixtures'),
                      Tab(text: 'Stats'),
                    ],
                    labelStyle: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    unselectedLabelStyle: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w400,
                    ),
                    indicatorColor: theme.colorScheme.primary,
                    labelColor: theme.colorScheme.primary,
                    unselectedLabelColor: theme.colorScheme.onSurfaceVariant,
                    dividerColor: Colors.transparent,
                  ),
                ),
                pinned: true,
              ),
            ];
          },
          body: _isLoading
              ? _buildLoadingState()
              : TabBarView(
                  controller: _tabController,
                  children: [
                    TeamOverviewWidget(teamData: _teamData),
                    TeamSquadWidget(teamData: _teamData),
                    TeamFixturesWidget(teamData: _teamData),
                    TeamStatisticsWidget(teamData: _teamData),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildLoadingState() {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            color: theme.colorScheme.primary,
          ),
          SizedBox(height: 2.h),
          Text(
            'Loading team data...',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _refreshTeamData() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Team data updated successfully'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  void _toggleFollow() {
    setState(() {
      _isFollowing = !_isFollowing;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isFollowing
              ? 'You are now following ${_teamData["name"]}'
              : 'You unfollowed ${_teamData["name"]}',
        ),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _isFollowing = !_isFollowing;
            });
          },
        ),
      ),
    );
  }
}

class _SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverTabBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;

  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    final theme = Theme.of(context);

    return Container(
      color: theme.colorScheme.surface,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(_SliverTabBarDelegate oldDelegate) {
    return false;
  }
}
