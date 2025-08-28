import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_bottom_bar.dart';
import '../../widgets/custom_icon_widget.dart';
import './widgets/date_picker_widget.dart';
import './widgets/empty_state_widget.dart';
import './widgets/filter_modal_widget.dart';
import './widgets/match_card_widget.dart';
import './widgets/search_widget.dart';

class FixturesAndResults extends StatefulWidget {
  const FixturesAndResults({super.key});

  @override
  State<FixturesAndResults> createState() => _FixturesAndResultsState();
}

class _FixturesAndResultsState extends State<FixturesAndResults>
    with TickerProviderStateMixin {
  late TabController _tabController;
  DateTime _selectedDate = DateTime.now();
  String _searchQuery = '';
  List<String> _selectedCompetitions = [];
  bool _isLoading = false;
  bool _isSearching = false;
  int _currentPage = 1;
  final ScrollController _scrollController = ScrollController();

  // Mock data for fixtures and results
  final List<Map<String, dynamic>> _allMatches = [
    {
      "id": 1,
      "date": "2025-08-28",
      "time": "15:00",
      "status": "upcoming",
      "homeTeam": {
        "name": "Simba SC",
        "logo":
            "https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=100&h=100&fit=crop"
      },
      "awayTeam": {
        "name": "Young Africans",
        "logo":
            "https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=100&h=100&fit=crop"
      },
      "competition": {
        "name": "NBC Premier League",
        "logo":
            "https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=100&h=100&fit=crop",
        "color": "0xFF2E7D32"
      },
      "venue": "Benjamin Mkapa Stadium"
    },
    {
      "id": 2,
      "date": "2025-08-28",
      "time": "17:30",
      "status": "live",
      "homeTeam": {
        "name": "Azam FC",
        "logo":
            "https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=100&h=100&fit=crop"
      },
      "awayTeam": {
        "name": "Coastal Union",
        "logo":
            "https://images.unsplash.com/photo-1606925797300-0b35e9d1794e?w=100&h=100&fit=crop"
      },
      "homeScore": 2,
      "awayScore": 1,
      "minute": 67,
      "competition": {
        "name": "NBC Premier League",
        "logo":
            "https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=100&h=100&fit=crop",
        "color": "0xFF2E7D32"
      },
      "venue": "Azam Complex"
    },
    {
      "id": 3,
      "date": "2025-08-27",
      "time": "16:00",
      "status": "completed",
      "homeTeam": {
        "name": "Mbeya City",
        "logo":
            "https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=100&h=100&fit=crop"
      },
      "awayTeam": {
        "name": "Singida Big Stars",
        "logo":
            "https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=100&h=100&fit=crop"
      },
      "homeScore": 1,
      "awayScore": 3,
      "competition": {
        "name": "NBC Premier League",
        "logo":
            "https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=100&h=100&fit=crop",
        "color": "0xFF2E7D32"
      },
      "goalScorers": [
        {"name": "John Mwanga", "minute": 23, "team": "home"},
        {"name": "Peter Banda", "minute": 45, "team": "away"},
        {"name": "James Kotei", "minute": 67, "team": "away"},
        {"name": "Moses Phiri", "minute": 89, "team": "away"}
      ],
      "venue": "Sokoine Stadium"
    },
    {
      "id": 4,
      "date": "2025-08-27",
      "time": "14:00",
      "status": "completed",
      "homeTeam": {
        "name": "Kagera Sugar",
        "logo":
            "https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=100&h=100&fit=crop"
      },
      "awayTeam": {
        "name": "Mtibwa Sugar",
        "logo":
            "https://images.unsplash.com/photo-1606925797300-0b35e9d1794e?w=100&h=100&fit=crop"
      },
      "homeScore": 0,
      "awayScore": 0,
      "competition": {
        "name": "Championship League",
        "logo":
            "https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=100&h=100&fit=crop",
        "color": "0xFFFFC107"
      },
      "goalScorers": [],
      "venue": "Kaitaba Stadium"
    },
    {
      "id": 5,
      "date": "2025-08-29",
      "time": "15:30",
      "status": "upcoming",
      "homeTeam": {
        "name": "Dodoma Jiji FC",
        "logo":
            "https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=100&h=100&fit=crop"
      },
      "awayTeam": {
        "name": "Ihefu FC",
        "logo":
            "https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=100&h=100&fit=crop"
      },
      "competition": {
        "name": "Federation Cup",
        "logo":
            "https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=100&h=100&fit=crop",
        "color": "0xFFD32F2F"
      },
      "venue": "Jamhuri Stadium"
    },
    {
      "id": 6,
      "date": "2025-08-26",
      "time": "16:30",
      "status": "completed",
      "homeTeam": {
        "name": "Fountain Gate FC",
        "logo":
            "https://images.unsplash.com/photo-1606925797300-0b35e9d1794e?w=100&h=100&fit=crop"
      },
      "awayTeam": {
        "name": "Polisi Tanzania",
        "logo":
            "https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=100&h=100&fit=crop"
      },
      "homeScore": 2,
      "awayScore": 2,
      "competition": {
        "name": "NBC Premier League",
        "logo":
            "https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=100&h=100&fit=crop",
        "color": "0xFF2E7D32"
      },
      "goalScorers": [
        {"name": "Emmanuel Okwi", "minute": 12, "team": "home"},
        {"name": "Feisal Salum", "minute": 34, "team": "away"},
        {"name": "Mudathir Yahya", "minute": 56, "team": "home"},
        {"name": "John Bocco", "minute": 78, "team": "away"}
      ],
      "venue": "CCM Kirumba Stadium"
    }
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(_onTabChanged);
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onTabChanged() {
    if (mounted) {
      setState(() {
        // Reset filters when switching tabs
        _searchQuery = '';
        _selectedCompetitions = [];
      });
    }
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      _loadMoreMatches();
    }
  }

  void _loadMoreMatches() {
    if (!_isLoading) {
      setState(() {
        _isLoading = true;
        _currentPage++;
      });

      // Simulate loading delay
      Future.delayed(Duration(seconds: 1), () {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      });
    }
  }

  List<Map<String, dynamic>> _getFilteredMatches() {
    List<Map<String, dynamic>> filtered = List.from(_allMatches);

    // Filter by tab
    switch (_tabController.index) {
      case 0: // Fixtures
        filtered =
            filtered.where((match) => match['status'] == 'upcoming').toList();
        break;
      case 1: // Results
        filtered =
            filtered.where((match) => match['status'] == 'completed').toList();
        break;
      case 2: // Live
        filtered =
            filtered.where((match) => match['status'] == 'live').toList();
        break;
    }

    // Filter by search query
    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((match) {
        final homeTeam = match['homeTeam']['name'].toString().toLowerCase();
        final awayTeam = match['awayTeam']['name'].toString().toLowerCase();
        final query = _searchQuery.toLowerCase();
        return homeTeam.contains(query) || awayTeam.contains(query);
      }).toList();
    }

    // Filter by competitions
    if (_selectedCompetitions.isNotEmpty) {
      filtered = filtered.where((match) {
        return _selectedCompetitions.contains(match['competition']['name']);
      }).toList();
    }

    // Sort by date and time
    filtered.sort((a, b) {
      final dateA = DateTime.parse("${a['date']} ${a['time']}:00");
      final dateB = DateTime.parse("${b['date']} ${b['time']}:00");
      return _tabController.index == 1
          ? dateB.compareTo(dateA)
          : dateA.compareTo(dateB);
    });

    return filtered;
  }

  Map<String, List<Map<String, dynamic>>> _groupMatchesByDate(
      List<Map<String, dynamic>> matches) {
    final Map<String, List<Map<String, dynamic>>> grouped = {};

    for (final match in matches) {
      final date = match['date'];
      if (!grouped.containsKey(date)) {
        grouped[date] = [];
      }
      grouped[date]!.add(match);
    }

    return grouped;
  }

  String _formatDateHeader(String dateString) {
    final date = DateTime.parse(dateString);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final matchDate = DateTime(date.year, date.month, date.day);

    if (matchDate == today) {
      return 'Today';
    } else if (matchDate == today.add(Duration(days: 1))) {
      return 'Tomorrow';
    } else if (matchDate == today.subtract(Duration(days: 1))) {
      return 'Yesterday';
    } else {
      const months = [
        'Jan',
        'Feb',
        'Mar',
        'Apr',
        'May',
        'Jun',
        'Jul',
        'Aug',
        'Sep',
        'Oct',
        'Nov',
        'Dec'
      ];
      return '${date.day} ${months[date.month - 1]} ${date.year}';
    }
  }

  Future<void> _refreshMatches() async {
    setState(() {
      _isLoading = true;
    });

    // Simulate refresh delay
    await Future.delayed(Duration(seconds: 1));

    if (mounted) {
      setState(() {
        _isLoading = false;
        _currentPage = 1;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Matches updated'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filteredMatches = _getFilteredMatches();
    final groupedMatches = _groupMatchesByDate(filteredMatches);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Fixtures & Results',
          style: GoogleFonts.inter(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
            color: theme.colorScheme.onSurface,
          ),
        ),
        backgroundColor: theme.colorScheme.surface,
        elevation: 1,
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                backgroundColor: Colors.transparent,
                builder: (context) => FilterModalWidget(
                  selectedCompetitions: _selectedCompetitions,
                  onApplyFilters: (competitions) {
                    setState(() {
                      _selectedCompetitions = competitions;
                    });
                  },
                ),
              );
            },
            icon: Stack(
              children: [
                CustomIconWidget(
                  iconName: 'filter_list',
                  color: theme.colorScheme.onSurface,
                  size: 24,
                ),
                if (_selectedCompetitions.isNotEmpty)
                  Positioned(
                    right: 0,
                    top: 0,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: theme.colorScheme.tertiary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'Fixtures'),
            Tab(text: 'Results'),
            Tab(text: 'Live'),
          ],
          labelStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: GoogleFonts.inter(
            fontSize: 14.sp,
            fontWeight: FontWeight.w400,
          ),
        ),
      ),
      body: Column(
        children: [
          // Date picker
          DatePickerWidget(
            selectedDate: _selectedDate,
            onDateSelected: (date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),

          // Search bar
          SearchWidget(
            searchQuery: _searchQuery,
            onSearchChanged: (query) {
              setState(() {
                _searchQuery = query;
                _isSearching = query.isNotEmpty;
              });
            },
            onClear: () {
              setState(() {
                _searchQuery = '';
                _isSearching = false;
              });
            },
          ),

          // Active filters indicator
          if (_selectedCompetitions.isNotEmpty)
            Container(
              height: 6.h,
              padding: EdgeInsets.symmetric(horizontal: 4.w),
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedCompetitions.length,
                itemBuilder: (context, index) {
                  final competition = _selectedCompetitions[index];
                  return Container(
                    margin: EdgeInsets.only(right: 2.w, top: 1.h, bottom: 1.h),
                    padding:
                        EdgeInsets.symmetric(horizontal: 3.w, vertical: 0.5.h),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: theme.colorScheme.primary,
                        width: 1,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          competition,
                          style: GoogleFonts.inter(
                            fontSize: 10.sp,
                            fontWeight: FontWeight.w500,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                        SizedBox(width: 1.w),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedCompetitions.remove(competition);
                            });
                          },
                          child: CustomIconWidget(
                            iconName: 'close',
                            color: theme.colorScheme.primary,
                            size: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

          // Content
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshMatches,
              child: filteredMatches.isEmpty
                  ? EmptyStateWidget(
                      title: _isSearching
                          ? 'No matches found'
                          : (_tabController.index == 0
                              ? 'No upcoming fixtures'
                              : (_tabController.index == 1
                                  ? 'No recent results'
                                  : 'No live matches')),
                      subtitle: _isSearching
                          ? 'Try adjusting your search terms or filters'
                          : (_tabController.index == 0
                              ? 'Check back later for upcoming fixtures'
                              : (_tabController.index == 1
                                  ? 'No recent match results available'
                                  : 'No matches are currently live')),
                      showResetFilters:
                          _selectedCompetitions.isNotEmpty || _isSearching,
                      onResetFilters: () {
                        setState(() {
                          _selectedCompetitions.clear();
                          _searchQuery = '';
                          _isSearching = false;
                        });
                      },
                    )
                  : ListView.builder(
                      controller: _scrollController,
                      padding: EdgeInsets.only(bottom: 2.h),
                      itemCount:
                          groupedMatches.keys.length + (_isLoading ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == groupedMatches.keys.length) {
                          return Center(
                            child: Padding(
                              padding: EdgeInsets.all(4.w),
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final date = groupedMatches.keys.elementAt(index);
                        final matches = groupedMatches[date]!;

                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Date header
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 4.w, vertical: 1.h),
                              color: theme.colorScheme.surface,
                              child: Text(
                                _formatDateHeader(date),
                                style: GoogleFonts.inter(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.onSurface,
                                ),
                              ),
                            ),

                            // Matches for this date
                            ...matches
                                .map((match) => MatchCardWidget(
                                      match: match,
                                      onTap: () {
                                        // Navigate to match details
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Opening match details...'),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      },
                                      onSetReminder:
                                          match['status'] == 'upcoming'
                                              ? () {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                      content: Text(
                                                          'Reminder set for ${match['homeTeam']['name']} vs ${match['awayTeam']['name']}'),
                                                      duration:
                                                          Duration(seconds: 2),
                                                    ),
                                                  );
                                                }
                                              : null,
                                      onTeamDetails: () {
                                        Navigator.pushNamed(
                                            context, '/team-profile');
                                      },
                                      onHeadToHead: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Opening head-to-head stats...'),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      },
                                      onShare: () {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Sharing match details...'),
                                            duration: Duration(seconds: 1),
                                          ),
                                        );
                                      },
                                    ))
                                .toList(),
                          ],
                        );
                      },
                    ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex: 2, // Fixtures tab is active
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home-screen');
              break;
            case 1:
              Navigator.pushNamed(context, '/live-match-center');
              break;
            case 2:
              // Already on fixtures screen
              break;
            case 3:
              Navigator.pushNamed(context, '/league-tables');
              break;
          }
        },
      ),
    );
  }
}