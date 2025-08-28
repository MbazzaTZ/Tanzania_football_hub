import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

/// Widget for displaying match lineups with formation graphics
class MatchLineupsWidget extends StatefulWidget {
  final String matchId;
  final VoidCallback? onRefresh;

  const MatchLineupsWidget({
    super.key,
    required this.matchId,
    this.onRefresh,
  });

  @override
  State<MatchLineupsWidget> createState() => _MatchLineupsWidgetState();
}

class _MatchLineupsWidgetState extends State<MatchLineupsWidget> {
  // Mock lineup data
  final Map<String, dynamic> _lineupData = {
    "homeTeam": {
      "name": "Simba SC",
      "formation": "4-3-3",
      "color": "#FF0000",
      "players": [
        {
          "id": 1,
          "name": "Aishi Manula",
          "position": "GK",
          "number": 1,
          "x": 0.5,
          "y": 0.9
        },
        {
          "id": 2,
          "name": "Shomari Kapombe",
          "position": "RB",
          "number": 2,
          "x": 0.8,
          "y": 0.7
        },
        {
          "id": 3,
          "name": "Joash Onyango",
          "position": "CB",
          "number": 5,
          "x": 0.65,
          "y": 0.7
        },
        {
          "id": 4,
          "name": "Henock Inonga",
          "position": "CB",
          "number": 26,
          "x": 0.35,
          "y": 0.7
        },
        {
          "id": 5,
          "name": "Mohamed Hussein",
          "position": "LB",
          "number": 3,
          "x": 0.2,
          "y": 0.7
        },
        {
          "id": 6,
          "name": "Clatous Chama",
          "position": "CM",
          "number": 10,
          "x": 0.5,
          "y": 0.5
        },
        {
          "id": 7,
          "name": "Jonas Mkude",
          "position": "CM",
          "number": 8,
          "x": 0.3,
          "y": 0.4
        },
        {
          "id": 8,
          "name": "Taddeo Lwanga",
          "position": "CM",
          "number": 6,
          "x": 0.7,
          "y": 0.4
        },
        {
          "id": 9,
          "name": "Luis Miquissone",
          "position": "RW",
          "number": 11,
          "x": 0.8,
          "y": 0.2
        },
        {
          "id": 10,
          "name": "John Bocco",
          "position": "ST",
          "number": 9,
          "x": 0.5,
          "y": 0.1
        },
        {
          "id": 11,
          "name": "Bernard Morrison",
          "position": "LW",
          "number": 7,
          "x": 0.2,
          "y": 0.2
        },
      ],
      "substitutes": [
        {"id": 12, "name": "Ally Salim", "position": "GK", "number": 16},
        {"id": 13, "name": "Meddie Kagere", "position": "FW", "number": 14},
        {"id": 14, "name": "Hassan Dilunga", "position": "MF", "number": 18},
        {"id": 15, "name": "Gadiel Michael", "position": "DF", "number": 23},
        {
          "id": 16,
          "name": "Saido Ntibazonkiza",
          "position": "MF",
          "number": 20
        },
      ]
    },
    "awayTeam": {
      "name": "Young Africans SC",
      "formation": "4-2-3-1",
      "color": "#FFFF00",
      "players": [
        {
          "id": 21,
          "name": "Metacha Mnata",
          "position": "GK",
          "number": 1,
          "x": 0.5,
          "y": 0.1
        },
        {
          "id": 22,
          "name": "Bakari Mwamnyeto",
          "position": "RB",
          "number": 2,
          "x": 0.8,
          "y": 0.3
        },
        {
          "id": 23,
          "name": "Dickson Job",
          "position": "CB",
          "number": 5,
          "x": 0.65,
          "y": 0.3
        },
        {
          "id": 24,
          "name": "Ibrahim Hamad",
          "position": "CB",
          "number": 4,
          "x": 0.35,
          "y": 0.3
        },
        {
          "id": 25,
          "name": "Haruna Niyonzima",
          "position": "LB",
          "number": 3,
          "x": 0.2,
          "y": 0.3
        },
        {
          "id": 26,
          "name": "Khalid Aucho",
          "position": "CDM",
          "number": 6,
          "x": 0.4,
          "y": 0.5
        },
        {
          "id": 27,
          "name": "Mudathir Yahya",
          "position": "CDM",
          "number": 8,
          "x": 0.6,
          "y": 0.5
        },
        {
          "id": 28,
          "name": "Feisal Salum",
          "position": "CAM",
          "number": 10,
          "x": 0.5,
          "y": 0.6
        },
        {
          "id": 29,
          "name": "Tuisila Kisinda",
          "position": "RW",
          "number": 11,
          "x": 0.8,
          "y": 0.7
        },
        {
          "id": 30,
          "name": "Prince Dube",
          "position": "ST",
          "number": 9,
          "x": 0.5,
          "y": 0.9
        },
        {
          "id": 31,
          "name": "Clement Mzize",
          "position": "LW",
          "number": 7,
          "x": 0.2,
          "y": 0.7
        },
      ],
      "substitutes": [
        {"id": 32, "name": "Djigui Diarra", "position": "GK", "number": 16},
        {"id": 33, "name": "Hassan Kessy", "position": "MF", "number": 14},
        {"id": 34, "name": "Pacome Zouzoua", "position": "FW", "number": 18},
        {"id": 35, "name": "Zawadi Mauya", "position": "DF", "number": 23},
        {"id": 36, "name": "Stephane Aziz Ki", "position": "MF", "number": 20},
      ]
    }
  };

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return RefreshIndicator(
      onRefresh: () async {
        widget.onRefresh?.call();
        await Future.delayed(const Duration(milliseconds: 500));
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.all(4.w),
        child: Column(
          children: [
            // Formation display
            Container(
              height: 60.h,
              decoration: BoxDecoration(
                color: theme.colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: (isDark ? Colors.black : Colors.grey)
                        .withValues(alpha: 0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Football field background
                  _buildFootballField(context),

                  // Home team players
                  ..._buildTeamPlayers(context, _lineupData["homeTeam"], true),

                  // Away team players
                  ..._buildTeamPlayers(context, _lineupData["awayTeam"], false),
                ],
              ),
            ),

            SizedBox(height: 3.h),

            // Team formations and substitutes
            Row(
              children: [
                // Home team info
                Expanded(
                  child: _buildTeamInfo(context, _lineupData["homeTeam"], true),
                ),

                SizedBox(width: 4.w),

                // Away team info
                Expanded(
                  child:
                      _buildTeamInfo(context, _lineupData["awayTeam"], false),
                ),
              ],
            ),

            SizedBox(height: 3.h),

            // Substitutes section
            _buildSubstitutesSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildFootballField(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF2E7D32).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: CustomPaint(
        painter: _FootballFieldPainter(
          lineColor: isDark
              ? Colors.white.withValues(alpha: 0.3)
              : Colors.black.withValues(alpha: 0.3),
        ),
      ),
    );
  }

  List<Widget> _buildTeamPlayers(
      BuildContext context, Map<String, dynamic> teamData, bool isHome) {
    final theme = Theme.of(context);
    final players = teamData["players"] as List<dynamic>;
    final teamColor = Color(
        int.parse(teamData["color"].toString().replaceFirst('#', '0xFF')));

    return players.map((player) {
      final playerData = player as Map<String, dynamic>;
      final x = playerData["x"] as double;
      final y = isHome
          ? playerData["y"] as double
          : 1.0 - (playerData["y"] as double);

      return Positioned(
        left: x * 85.w - 6.w,
        top: y * 55.h - 6.w,
        child: GestureDetector(
          onTap: () {
            _showPlayerDetails(context, playerData, teamData["name"] as String);
          },
          child: Container(
            width: 12.w,
            height: 12.w,
            decoration: BoxDecoration(
              color: teamColor,
              shape: BoxShape.circle,
              border: Border.all(
                color: theme.colorScheme.surface,
                width: 2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.3),
                  blurRadius: 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Text(
                playerData["number"].toString(),
                style: theme.textTheme.labelMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
      );
    }).toList();
  }

  Widget _buildTeamInfo(
      BuildContext context, Map<String, dynamic> teamData, bool isHome) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : Colors.grey).withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            teamData["name"] as String,
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 1.h),
          Row(
            children: [
              CustomIconWidget(
                iconName: 'sports_soccer',
                size: 16,
                color: theme.colorScheme.onSurfaceVariant,
              ),
              SizedBox(width: 1.w),
              Text(
                'Formation: ${teamData["formation"]}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSubstitutesSection(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: (isDark ? Colors.black : Colors.grey).withValues(alpha: 0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: (isDark ? AppTheme.primaryDark : AppTheme.primaryLight)
                  .withValues(alpha: 0.1),
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(12),
                topRight: Radius.circular(12),
              ),
            ),
            child: Text(
              'Substitutes',
              style: theme.textTheme.titleMedium?.copyWith(
                color: isDark ? AppTheme.primaryDark : AppTheme.primaryLight,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),

          // Substitutes list
          Padding(
            padding: EdgeInsets.all(4.w),
            child: Column(
              children: [
                // Home team substitutes
                _buildSubstitutesList(context, _lineupData["homeTeam"], true),

                SizedBox(height: 2.h),

                // Away team substitutes
                _buildSubstitutesList(context, _lineupData["awayTeam"], false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSubstitutesList(
      BuildContext context, Map<String, dynamic> teamData, bool isHome) {
    final theme = Theme.of(context);
    final substitutes = teamData["substitutes"] as List<dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          teamData["name"] as String,
          style: theme.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 1.h),
        ...substitutes.map((sub) {
          final subData = sub as Map<String, dynamic>;
          return Padding(
            padding: EdgeInsets.only(bottom: 1.h),
            child: Row(
              children: [
                Container(
                  width: 8.w,
                  height: 8.w,
                  decoration: BoxDecoration(
                    color: theme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.1),
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      subData["number"].toString(),
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Text(
                    subData["name"] as String,
                    style: theme.textTheme.bodyMedium,
                  ),
                ),
                Text(
                  subData["position"] as String,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ],
    );
  }

  void _showPlayerDetails(
      BuildContext context, Map<String, dynamic> player, String teamName) {
    final theme = Theme.of(context);

    showModalBottomSheet(
      context: context,
      backgroundColor: theme.colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Container(
        padding: EdgeInsets.all(6.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 12.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color:
                    theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            SizedBox(height: 3.h),
            Text(
              player["name"] as String,
              style: theme.textTheme.headlineSmall?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              teamName,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildPlayerStat(
                    context, 'Number', player["number"].toString()),
                _buildPlayerStat(
                    context, 'Position', player["position"] as String),
              ],
            ),
            SizedBox(height: 3.h),
          ],
        ),
      ),
    );
  }

  Widget _buildPlayerStat(BuildContext context, String label, String value) {
    final theme = Theme.of(context);

    return Column(
      children: [
        Text(
          value,
          style: theme.textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.w700,
            color: theme.colorScheme.primary,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _FootballFieldPainter extends CustomPainter {
  final Color lineColor;

  _FootballFieldPainter({required this.lineColor});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = lineColor
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    // Field outline
    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), paint);

    // Center line
    canvas.drawLine(
      Offset(0, size.height / 2),
      Offset(size.width, size.height / 2),
      paint,
    );

    // Center circle
    canvas.drawCircle(
      Offset(size.width / 2, size.height / 2),
      size.width * 0.1,
      paint,
    );

    // Penalty areas
    final penaltyAreaWidth = size.width * 0.3;
    final penaltyAreaHeight = size.height * 0.15;

    // Top penalty area
    canvas.drawRect(
      Rect.fromLTWH(
        (size.width - penaltyAreaWidth) / 2,
        0,
        penaltyAreaWidth,
        penaltyAreaHeight,
      ),
      paint,
    );

    // Bottom penalty area
    canvas.drawRect(
      Rect.fromLTWH(
        (size.width - penaltyAreaWidth) / 2,
        size.height - penaltyAreaHeight,
        penaltyAreaWidth,
        penaltyAreaHeight,
      ),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
