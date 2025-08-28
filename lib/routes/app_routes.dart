import 'package:flutter/material.dart';
import '../presentation/league_tables/league_tables.dart';
import '../presentation/fixtures_and_results/fixtures_and_results.dart';
import '../presentation/team_profile/team_profile.dart';
import '../presentation/live_match_center/live_match_center.dart';
import '../presentation/home_screen/home_screen.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String leagueTables = '/league-tables';
  static const String fixturesAndResults = '/fixtures-and-results';
  static const String teamProfile = '/team-profile';
  static const String liveMatchCenter = '/live-match-center';
  static const String home = '/home-screen';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const LeagueTables(),
    leagueTables: (context) => const LeagueTables(),
    fixturesAndResults: (context) => const FixturesAndResults(),
    teamProfile: (context) => const TeamProfile(),
    liveMatchCenter: (context) => const LiveMatchCenter(),
    home: (context) => const HomeScreen(),
    // TODO: Add your other routes here
  };
}
