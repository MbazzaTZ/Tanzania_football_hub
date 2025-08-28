import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class TeamSquadWidget extends StatelessWidget {
  final Map<String, dynamic> teamData;

  const TeamSquadWidget({
    super.key,
    required this.teamData,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final squad = teamData["squad"] as List? ?? _getDefaultSquad();

    return SingleChildScrollView(
      padding: EdgeInsets.all(4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Squad summary
          _buildSquadSummary(context, squad),

          SizedBox(height: 3.h),

          // Players by position
          _buildPlayersByPosition(context, squad, 'Goalkeepers', 'GK'),

          SizedBox(height: 2.h),

          _buildPlayersByPosition(context, squad, 'Defenders', 'DF'),

          SizedBox(height: 2.h),

          _buildPlayersByPosition(context, squad, 'Midfielders', 'MF'),

          SizedBox(height: 2.h),

          _buildPlayersByPosition(context, squad, 'Forwards', 'FW'),
        ],
      ),
    );
  }

  Widget _buildSquadSummary(BuildContext context, List squad) {
    final theme = Theme.of(context);

    final goalkeepers =
        squad.where((p) => (p as Map)["position"] == "GK").length;
    final defenders = squad.where((p) => (p as Map)["position"] == "DF").length;
    final midfielders =
        squad.where((p) => (p as Map)["position"] == "MF").length;
    final forwards = squad.where((p) => (p as Map)["position"] == "FW").length;

    return Card(
      child: Padding(
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Squad Overview',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 2.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildPositionCount(
                    context, 'GK', goalkeepers, 'sports_soccer'),
                _buildPositionCount(context, 'DF', defenders, 'shield'),
                _buildPositionCount(context, 'MF', midfielders, 'sports'),
                _buildPositionCount(context, 'FW', forwards, 'sports_score'),
              ],
            ),
            SizedBox(height: 2.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color:
                    theme.colorScheme.primaryContainer.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total Squad Size',
                    style: theme.textTheme.titleMedium,
                  ),
                  Text(
                    '${squad.length} Players',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPositionCount(
      BuildContext context, String position, int count, String iconName) {
    final theme = Theme.of(context);

    return Column(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: theme.colorScheme.primary,
          size: 24,
        ),
        SizedBox(height: 1.h),
        Text(
          count.toString(),
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
            color: theme.colorScheme.primary,
          ),
        ),
        Text(
          position,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }

  Widget _buildPlayersByPosition(
      BuildContext context, List squad, String sectionTitle, String position) {
    final theme = Theme.of(context);
    final positionPlayers =
        squad.where((p) => (p as Map)["position"] == position).toList();

    if (positionPlayers.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          sectionTitle,
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 1.h),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: 2.5,
            crossAxisSpacing: 2.w,
            mainAxisSpacing: 2.w,
          ),
          itemCount: positionPlayers.length,
          itemBuilder: (context, index) {
            final player = positionPlayers[index] as Map<String, dynamic>;
            return _buildPlayerCard(context, player);
          },
        ),
      ],
    );
  }

  Widget _buildPlayerCard(BuildContext context, Map<String, dynamic> player) {
    final theme = Theme.of(context);

    return Card(
      child: InkWell(
        onTap: () {
          Navigator.pushNamed(
            context,
            '/player-profile',
            arguments: player,
          );
        },
        onLongPress: () {
          _showPlayerQuickActions(context, player);
        },
        borderRadius: BorderRadius.circular(2.w),
        child: Padding(
          padding: EdgeInsets.all(2.w),
          child: Row(
            children: [
              // Player photo
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  color:
                      theme.colorScheme.primaryContainer.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(1.5.w),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1.5.w),
                  child: CustomImageWidget(
                    imageUrl: player["photo"] as String? ?? "",
                    width: 12.w,
                    height: 12.w,
                    fit: BoxFit.cover,
                  ),
                ),
              ),

              SizedBox(width: 3.w),

              // Player info
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      player["name"] as String? ?? "Player Name",
                      style: theme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: 2.w,
                            vertical: 0.5.h,
                          ),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.primary,
                            borderRadius: BorderRadius.circular(1.w),
                          ),
                          child: Text(
                            '#${player["jerseyNumber"]?.toString() ?? "0"}',
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(width: 2.w),
                        Text(
                          player["position"] as String? ?? "POS",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // Arrow indicator
              CustomIconWidget(
                iconName: 'arrow_forward_ios',
                color: theme.colorScheme.onSurfaceVariant,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showPlayerQuickActions(
      BuildContext context, Map<String, dynamic> player) {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(4.w)),
      ),
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(4.w),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 12.w,
                height: 0.5.h,
                decoration: BoxDecoration(
                  color: Theme.of(context)
                      .colorScheme
                      .onSurfaceVariant
                      .withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(1.w),
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                player["name"] as String? ?? "Player Name",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
              SizedBox(height: 3.h),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'bar_chart',
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                title: const Text('View Stats'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushNamed(
                    context,
                    '/player-profile',
                    arguments: player,
                  );
                },
              ),
              ListTile(
                leading: CustomIconWidget(
                  iconName: 'share',
                  color: Theme.of(context).colorScheme.primary,
                  size: 24,
                ),
                title: const Text('Share Player'),
                onTap: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Sharing ${player["name"]}...'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              ),
              SizedBox(height: 2.h),
            ],
          ),
        );
      },
    );
  }

  List<Map<String, dynamic>> _getDefaultSquad() {
    return [
      {
        "id": 1,
        "name": "John Mwalimu",
        "position": "GK",
        "jerseyNumber": 1,
        "age": 28,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 2,
        "name": "Hassan Mwanga",
        "position": "GK",
        "jerseyNumber": 12,
        "age": 25,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 3,
        "name": "David Mwakasege",
        "position": "DF",
        "jerseyNumber": 2,
        "age": 26,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 4,
        "name": "Emmanuel Okwi",
        "position": "DF",
        "jerseyNumber": 3,
        "age": 29,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 5,
        "name": "Kelvin Yondani",
        "position": "DF",
        "jerseyNumber": 4,
        "age": 27,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 6,
        "name": "Bakari Mwamnyeto",
        "position": "DF",
        "jerseyNumber": 5,
        "age": 24,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 7,
        "name": "Mudathir Yahya",
        "position": "MF",
        "jerseyNumber": 6,
        "age": 25,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 8,
        "name": "Feisal Salum",
        "position": "MF",
        "jerseyNumber": 8,
        "age": 28,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 9,
        "name": "Thomas Ulimwengu",
        "position": "MF",
        "jerseyNumber": 10,
        "age": 26,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 10,
        "name": "Ally Msengi",
        "position": "MF",
        "jerseyNumber": 11,
        "age": 23,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 11,
        "name": "John Bocco",
        "position": "FW",
        "jerseyNumber": 9,
        "age": 30,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
      {
        "id": 12,
        "name": "Meddie Kagere",
        "position": "FW",
        "jerseyNumber": 7,
        "age": 32,
        "photo":
            "https://cdn.pixabay.com/photo/2015/03/04/22/35/avatar-659652_640.png",
      },
    ];
  }
}
