import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../core/app_export.dart';
import '../../widgets/custom_app_bar.dart';
import '../../widgets/custom_bottom_bar.dart';
import './widgets/competition_selector_widget.dart';
import './widgets/league_table_widget.dart';
import './widgets/table_legend_widget.dart';

class LeagueTables extends StatefulWidget {
  const LeagueTables({super.key});

  @override
  State<LeagueTables> createState() => _LeagueTablesState();
}

class _LeagueTablesState extends State<LeagueTables> {
  int _selectedCompetitionIndex = 0;
  bool _isLoading = false;
  DateTime _lastUpdated = DateTime.now();

  // Mock data for competitions
  final List<Map<String, dynamic>> _competitions = [
    {
      'id': 1,
      'name': 'NBC Premier League',
      'logo':
          'https://images.unsplash.com/photo-1614632537190-23e4b2d8b5b8?w=100&h=100&fit=crop&crop=center',
      'currentMatchday': 15,
      'teams': [
        {
          'id': 1,
          'name': 'Simba SC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 11,
          'drawn': 2,
          'lost': 1,
          'goalsFor': 28,
          'goalsAgainst': 8,
          'goalDifference': 20,
          'points': 35,
        },
        {
          'id': 2,
          'name': 'Young Africans',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 10,
          'drawn': 3,
          'lost': 1,
          'goalsFor': 25,
          'goalsAgainst': 7,
          'goalDifference': 18,
          'points': 33,
        },
        {
          'id': 3,
          'name': 'Azam FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 8,
          'drawn': 4,
          'lost': 2,
          'goalsFor': 22,
          'goalsAgainst': 12,
          'goalDifference': 10,
          'points': 28,
        },
        {
          'id': 4,
          'name': 'Coastal Union',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 7,
          'drawn': 5,
          'lost': 2,
          'goalsFor': 19,
          'goalsAgainst': 11,
          'goalDifference': 8,
          'points': 26,
        },
        {
          'id': 5,
          'name': 'Kagera Sugar',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 6,
          'drawn': 6,
          'lost': 2,
          'goalsFor': 18,
          'goalsAgainst': 13,
          'goalDifference': 5,
          'points': 24,
        },
        {
          'id': 6,
          'name': 'Mbeya City',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 6,
          'drawn': 4,
          'lost': 4,
          'goalsFor': 16,
          'goalsAgainst': 15,
          'goalDifference': 1,
          'points': 22,
        },
        {
          'id': 7,
          'name': 'Namungo FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 5,
          'drawn': 6,
          'lost': 3,
          'goalsFor': 15,
          'goalsAgainst': 14,
          'goalDifference': 1,
          'points': 21,
        },
        {
          'id': 8,
          'name': 'Geita Gold FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 5,
          'drawn': 5,
          'lost': 4,
          'goalsFor': 14,
          'goalsAgainst': 13,
          'goalDifference': 1,
          'points': 20,
        },
        {
          'id': 9,
          'name': 'Dodoma Jiji FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 5,
          'drawn': 4,
          'lost': 5,
          'goalsFor': 13,
          'goalsAgainst': 16,
          'goalDifference': -3,
          'points': 19,
        },
        {
          'id': 10,
          'name': 'Ihefu FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 4,
          'drawn': 6,
          'lost': 4,
          'goalsFor': 12,
          'goalsAgainst': 14,
          'goalDifference': -2,
          'points': 18,
        },
        {
          'id': 11,
          'name': 'Singida Big Stars',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 4,
          'drawn': 5,
          'lost': 5,
          'goalsFor': 11,
          'goalsAgainst': 15,
          'goalDifference': -4,
          'points': 17,
        },
        {
          'id': 12,
          'name': 'Mtibwa Sugar',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 4,
          'drawn': 4,
          'lost': 6,
          'goalsFor': 10,
          'goalsAgainst': 17,
          'goalDifference': -7,
          'points': 16,
        },
        {
          'id': 13,
          'name': 'Ruvu Shooting',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 3,
          'drawn': 6,
          'lost': 5,
          'goalsFor': 9,
          'goalsAgainst': 16,
          'goalDifference': -7,
          'points': 15,
        },
        {
          'id': 14,
          'name': 'Polisi Tanzania',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 3,
          'drawn': 5,
          'lost': 6,
          'goalsFor': 8,
          'goalsAgainst': 18,
          'goalDifference': -10,
          'points': 14,
        },
        {
          'id': 15,
          'name': 'Kinondoni MC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 2,
          'drawn': 7,
          'lost': 5,
          'goalsFor': 7,
          'goalsAgainst': 15,
          'goalDifference': -8,
          'points': 13,
        },
        {
          'id': 16,
          'name': 'Mwadui FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 2,
          'drawn': 6,
          'lost': 6,
          'goalsFor': 6,
          'goalsAgainst': 16,
          'goalDifference': -10,
          'points': 12,
        },
        {
          'id': 17,
          'name': 'Mashujaa FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 2,
          'drawn': 4,
          'lost': 8,
          'goalsFor': 5,
          'goalsAgainst': 20,
          'goalDifference': -15,
          'points': 10,
        },
        {
          'id': 18,
          'name': 'Biashara United',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 1,
          'drawn': 5,
          'lost': 8,
          'goalsFor': 4,
          'goalsAgainst': 22,
          'goalDifference': -18,
          'points': 8,
        },
        {
          'id': 19,
          'name': 'JKT Tanzania',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 1,
          'drawn': 4,
          'lost': 9,
          'goalsFor': 3,
          'goalsAgainst': 25,
          'goalDifference': -22,
          'points': 7,
        },
        {
          'id': 20,
          'name': 'Fountain Gate FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 14,
          'won': 0,
          'drawn': 3,
          'lost': 11,
          'goalsFor': 2,
          'goalsAgainst': 28,
          'goalDifference': -26,
          'points': 3,
        },
      ],
    },
    {
      'id': 2,
      'name': 'Championship League',
      'logo':
          'https://images.unsplash.com/photo-1614632537190-23e4b2d8b5b8?w=100&h=100&fit=crop&crop=center',
      'currentMatchday': 12,
      'teams': [
        {
          'id': 21,
          'name': 'Mwanza FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 9,
          'drawn': 2,
          'lost': 1,
          'goalsFor': 22,
          'goalsAgainst': 6,
          'goalDifference': 16,
          'points': 29,
        },
        {
          'id': 22,
          'name': 'Arusha City FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 8,
          'drawn': 3,
          'lost': 1,
          'goalsFor': 20,
          'goalsAgainst': 8,
          'goalDifference': 12,
          'points': 27,
        },
        {
          'id': 23,
          'name': 'Tanga City FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 7,
          'drawn': 4,
          'lost': 1,
          'goalsFor': 18,
          'goalsAgainst': 9,
          'goalDifference': 9,
          'points': 25,
        },
        {
          'id': 24,
          'name': 'Morogoro FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 6,
          'drawn': 5,
          'lost': 1,
          'goalsFor': 16,
          'goalsAgainst': 10,
          'goalDifference': 6,
          'points': 23,
        },
        {
          'id': 25,
          'name': 'Kilifi FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 5,
          'drawn': 6,
          'lost': 1,
          'goalsFor': 14,
          'goalsAgainst': 11,
          'goalDifference': 3,
          'points': 21,
        },
        {
          'id': 26,
          'name': 'Iringa United',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 5,
          'drawn': 4,
          'lost': 3,
          'goalsFor': 13,
          'goalsAgainst': 12,
          'goalDifference': 1,
          'points': 19,
        },
        {
          'id': 27,
          'name': 'Songea FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 4,
          'drawn': 6,
          'lost': 2,
          'goalsFor': 12,
          'goalsAgainst': 11,
          'goalDifference': 1,
          'points': 18,
        },
        {
          'id': 28,
          'name': 'Kigoma FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 4,
          'drawn': 5,
          'lost': 3,
          'goalsFor': 11,
          'goalsAgainst': 12,
          'goalDifference': -1,
          'points': 17,
        },
        {
          'id': 29,
          'name': 'Tabora United',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 3,
          'drawn': 7,
          'lost': 2,
          'goalsFor': 10,
          'goalsAgainst': 11,
          'goalDifference': -1,
          'points': 16,
        },
        {
          'id': 30,
          'name': 'Lindi FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 3,
          'drawn': 6,
          'lost': 3,
          'goalsFor': 9,
          'goalsAgainst': 12,
          'goalDifference': -3,
          'points': 15,
        },
        {
          'id': 31,
          'name': 'Mtwara FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 2,
          'drawn': 8,
          'lost': 2,
          'goalsFor': 8,
          'goalsAgainst': 10,
          'goalDifference': -2,
          'points': 14,
        },
        {
          'id': 32,
          'name': 'Shinyanga FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 2,
          'drawn': 7,
          'lost': 3,
          'goalsFor': 7,
          'goalsAgainst': 11,
          'goalDifference': -4,
          'points': 13,
        },
        {
          'id': 33,
          'name': 'Bukoba FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 2,
          'drawn': 5,
          'lost': 5,
          'goalsFor': 6,
          'goalsAgainst': 14,
          'goalDifference': -8,
          'points': 11,
        },
        {
          'id': 34,
          'name': 'Musoma United',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 1,
          'drawn': 6,
          'lost': 5,
          'goalsFor': 5,
          'goalsAgainst': 15,
          'goalDifference': -10,
          'points': 9,
        },
        {
          'id': 35,
          'name': 'Njombe FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 1,
          'drawn': 4,
          'lost': 7,
          'goalsFor': 4,
          'goalsAgainst': 18,
          'goalDifference': -14,
          'points': 7,
        },
        {
          'id': 36,
          'name': 'Manyara FC',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 12,
          'won': 0,
          'drawn': 3,
          'lost': 9,
          'goalsFor': 2,
          'goalsAgainst': 22,
          'goalDifference': -20,
          'points': 3,
        },
      ],
    },
    {
      'id': 3,
      'name': 'Women\'s Premier League',
      'logo':
          'https://images.unsplash.com/photo-1614632537190-23e4b2d8b5b8?w=100&h=100&fit=crop&crop=center',
      'currentMatchday': 10,
      'teams': [
        {
          'id': 37,
          'name': 'Simba Queens',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 10,
          'won': 9,
          'drawn': 1,
          'lost': 0,
          'goalsFor': 28,
          'goalsAgainst': 3,
          'goalDifference': 25,
          'points': 28,
        },
        {
          'id': 38,
          'name': 'Yanga Princess',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 10,
          'won': 8,
          'drawn': 1,
          'lost': 1,
          'goalsFor': 24,
          'goalsAgainst': 5,
          'goalDifference': 19,
          'points': 25,
        },
        {
          'id': 39,
          'name': 'Fountain Gate Queens',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 10,
          'won': 6,
          'drawn': 3,
          'lost': 1,
          'goalsFor': 18,
          'goalsAgainst': 8,
          'goalDifference': 10,
          'points': 21,
        },
        {
          'id': 40,
          'name': 'Coastal Union Queens',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 10,
          'won': 5,
          'drawn': 4,
          'lost': 1,
          'goalsFor': 15,
          'goalsAgainst': 9,
          'goalDifference': 6,
          'points': 19,
        },
        {
          'id': 41,
          'name': 'Azam Queens',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 10,
          'won': 5,
          'drawn': 3,
          'lost': 2,
          'goalsFor': 14,
          'goalsAgainst': 10,
          'goalDifference': 4,
          'points': 18,
        },
        {
          'id': 42,
          'name': 'Mbeya City Queens',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 10,
          'won': 4,
          'drawn': 4,
          'lost': 2,
          'goalsFor': 12,
          'goalsAgainst': 11,
          'goalDifference': 1,
          'points': 16,
        },
        {
          'id': 43,
          'name': 'Namungo Queens',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 10,
          'won': 3,
          'drawn': 5,
          'lost': 2,
          'goalsFor': 11,
          'goalsAgainst': 12,
          'goalDifference': -1,
          'points': 14,
        },
        {
          'id': 44,
          'name': 'Geita Gold Queens',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 10,
          'won': 3,
          'drawn': 4,
          'lost': 3,
          'goalsFor': 10,
          'goalsAgainst': 13,
          'goalDifference': -3,
          'points': 13,
        },
        {
          'id': 45,
          'name': 'Dodoma Jiji Queens',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 10,
          'won': 2,
          'drawn': 6,
          'lost': 2,
          'goalsFor': 9,
          'goalsAgainst': 11,
          'goalDifference': -2,
          'points': 12,
        },
        {
          'id': 46,
          'name': 'Ihefu Queens',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 10,
          'won': 2,
          'drawn': 5,
          'lost': 3,
          'goalsFor': 8,
          'goalsAgainst': 12,
          'goalDifference': -4,
          'points': 11,
        },
        {
          'id': 47,
          'name': 'Singida Queens',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 10,
          'won': 1,
          'drawn': 7,
          'lost': 2,
          'goalsFor': 7,
          'goalsAgainst': 10,
          'goalDifference': -3,
          'points': 10,
        },
        {
          'id': 48,
          'name': 'Mtibwa Sugar Queens',
          'logo':
              'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=50&h=50&fit=crop&crop=center',
          'played': 10,
          'won': 1,
          'drawn': 4,
          'lost': 5,
          'goalsFor': 6,
          'goalsAgainst': 16,
          'goalDifference': -10,
          'points': 7,
        },
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: CustomAppBar(
        title: 'League Tables',
        actions: [
          IconButton(
            icon: CustomIconWidget(
              iconName: 'refresh',
              color: theme.colorScheme.onSurface,
              size: 24,
            ),
            onPressed: _refreshTables,
            tooltip: 'Refresh Tables',
          ),
          IconButton(
            icon: CustomIconWidget(
              iconName: 'search',
              color: theme.colorScheme.onSurface,
              size: 24,
            ),
            onPressed: _showSearchDialog,
            tooltip: 'Search Teams',
          ),
          IconButton(
            icon: CustomIconWidget(
              iconName: 'share',
              color: theme.colorScheme.onSurface,
              size: 24,
            ),
            onPressed: _shareTable,
            tooltip: 'Share Table',
          ),
        ],
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(
                color: theme.colorScheme.primary,
              ),
            )
          : Column(
              children: [
                // Competition selector
                CompetitionSelectorWidget(
                  competitions: _competitions,
                  selectedIndex: _selectedCompetitionIndex,
                  onCompetitionSelected: _onCompetitionSelected,
                ),

                // Last updated info
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                    color: isDark
                        ? const Color(0xFF2E2E2E)
                        : const Color(0xFFF5F5F5),
                    border: Border(
                      bottom: BorderSide(
                        color: isDark
                            ? const Color(0xFF424242)
                            : const Color(0xFFE0E0E0),
                        width: 1,
                      ),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Last updated: ${_formatLastUpdated()}',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.6),
                        ),
                      ),
                      GestureDetector(
                        onTap: _refreshTables,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconWidget(
                              iconName: 'update',
                              color: theme.colorScheme.primary,
                              size: 16,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              'Update',
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: theme.colorScheme.primary,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // League table
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: _refreshTables,
                    color: theme.colorScheme.primary,
                    child: LeagueTableWidget(
                      competitionData: _competitions[_selectedCompetitionIndex],
                      onTeamTap: _onTeamTap,
                      onTeamLongPress: _onTeamLongPress,
                    ),
                  ),
                ),

                // Table legend
                const TableLegendWidget(),
              ],
            ),
      bottomNavigationBar: CustomBottomBar(
        currentIndex:
            3, // Tables tab index (0=Home, 1=Live, 2=Fixtures, 3=Tables)
      ),
    );
  }

  void _onCompetitionSelected(int index) {
    setState(() {
      _selectedCompetitionIndex = index;
    });
    HapticFeedback.lightImpact();
  }

  Future<void> _refreshTables() async {
    setState(() {
      _isLoading = true;
    });

    HapticFeedback.lightImpact();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isLoading = false;
      _lastUpdated = DateTime.now();
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('League tables updated successfully'),
          backgroundColor: Theme.of(context).colorScheme.primary,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  void _onTeamTap(Map<String, dynamic> team) {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(
      context,
      '/team-profile',
      arguments: team,
    );
  }

  void _onTeamLongPress(Map<String, dynamic> team) {
    HapticFeedback.mediumImpact();
    _showTeamContextMenu(team);
  }

  void _showTeamContextMenu(Map<String, dynamic> team) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).colorScheme.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        final theme = Theme.of(context);

        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Handle bar
              Container(
                width: 12.w,
                height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              SizedBox(height: 3.h),

              // Team info
              Row(
                children: [
                  CustomImageWidget(
                    imageUrl: team['logo'] as String,
                    width: 40,
                    height: 40,
                    fit: BoxFit.contain,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      team['name'] as String,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 3.h),

              // Menu options
              _buildContextMenuItem(
                context,
                icon: 'calendar_today',
                title: 'View Fixtures',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/fixtures-and-results');
                },
              ),
              _buildContextMenuItem(
                context,
                icon: 'bar_chart',
                title: 'Team Stats',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(context, '/team-profile');
                },
              ),
              _buildContextMenuItem(
                context,
                icon: 'favorite_border',
                title: 'Follow Team',
                onTap: () {
                  Navigator.pop(context);
                  _followTeam(team);
                },
              ),

              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContextMenuItem(
    BuildContext context, {
    required String icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);

    return ListTile(
      leading: CustomIconWidget(
        iconName: icon,
        color: theme.colorScheme.onSurface,
        size: 24,
      ),
      title: Text(
        title,
        style: theme.textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }

  void _followTeam(Map<String, dynamic> team) {
    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Following ${team['name']}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _showSearchDialog() {
    showDialog(
      context: context,
      builder: (context) {
        final theme = Theme.of(context);
        String searchQuery = '';

        return AlertDialog(
          backgroundColor: theme.colorScheme.surface,
          title: Text(
            'Search Teams',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Enter team name...',
              prefixIcon: CustomIconWidget(
                iconName: 'search',
                color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
                size: 20,
              ),
            ),
            onChanged: (value) {
              searchQuery = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
                _performSearch(searchQuery);
              },
              child: Text('Search'),
            ),
          ],
        );
      },
    );
  }

  void _performSearch(String query) {
    if (query.isEmpty) return;

    HapticFeedback.lightImpact();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Searching for "$query"...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _shareTable() {
    HapticFeedback.lightImpact();
    final competition = _competitions[_selectedCompetitionIndex];
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${competition['name']} table...'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  String _formatLastUpdated() {
    final now = DateTime.now();
    final difference = now.difference(_lastUpdated);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inMinutes < 60) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inHours < 24) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }
}
