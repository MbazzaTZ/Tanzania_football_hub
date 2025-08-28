import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Custom AppBar widget implementing Contemporary Sports Minimalism design
/// with Tanzanian Heritage Palette for football application navigation.
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  /// The title to display in the app bar
  final String title;

  /// Whether to show the back button (automatically determined if not specified)
  final bool? showBackButton;

  /// Custom leading widget (overrides back button if provided)
  final Widget? leading;

  /// List of action widgets to display on the right side
  final List<Widget>? actions;

  /// Whether to center the title
  final bool centerTitle;

  /// Custom bottom widget (typically used for tabs)
  final PreferredSizeWidget? bottom;

  /// Background color override
  final Color? backgroundColor;

  /// Foreground color override
  final Color? foregroundColor;

  /// Elevation override
  final double? elevation;

  /// Whether this app bar is for a live match context
  final bool isLiveContext;

  const CustomAppBar({
    super.key,
    required this.title,
    this.showBackButton,
    this.leading,
    this.actions,
    this.centerTitle = false,
    this.bottom,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation,
    this.isLiveContext = false,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    // Determine colors based on context
    final Color effectiveBackgroundColor = backgroundColor ??
        (isLiveContext
            ? (isDark ? const Color(0xFF1E1E1E) : const Color(0xFFFFFFFF))
            : theme.appBarTheme.backgroundColor ?? theme.colorScheme.surface);

    final Color effectiveForegroundColor = foregroundColor ??
        theme.appBarTheme.foregroundColor ??
        theme.colorScheme.onSurface;

    return AppBar(
      title: Text(
        title,
        style: GoogleFonts.inter(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: effectiveForegroundColor,
        ),
      ),
      centerTitle: centerTitle,
      backgroundColor: effectiveBackgroundColor,
      foregroundColor: effectiveForegroundColor,
      elevation: elevation ?? (isLiveContext ? 2.0 : 1.0),
      shadowColor: isDark
          ? Colors.black.withValues(alpha: 0.3)
          : Colors.black.withValues(alpha: 0.1),

      // Leading widget configuration
      leading: leading ??
          (showBackButton == true ||
                  (showBackButton == null && Navigator.of(context).canPop())
              ? IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    HapticFeedback.lightImpact();
                    Navigator.of(context).pop();
                  },
                )
              : null),

      // Actions with haptic feedback
      actions: actions?.map((action) {
        if (action is IconButton) {
          return IconButton(
            icon: action.icon,
            onPressed: () {
              HapticFeedback.lightImpact();
              action.onPressed?.call();
            },
            tooltip: action.tooltip,
          );
        }
        return action;
      }).toList(),

      // Bottom widget (typically TabBar)
      bottom: bottom,

      // System UI overlay style
      systemOverlayStyle: SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
        statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
        kToolbarHeight + (bottom?.preferredSize.height ?? 0.0),
      );

  /// Factory constructor for home screen app bar
  factory CustomAppBar.home({
    Key? key,
    List<Widget>? actions,
  }) {
    return CustomAppBar(
      key: key,
      title: 'Tanzanian Football',
      actions: actions ??
          [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // Navigate to notifications or show notifications panel
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notifications feature coming soon'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                tooltip: 'Notifications',
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.search),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // Navigate to search
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Search feature coming soon'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                tooltip: 'Search',
              ),
            ),
          ],
    );
  }

  /// Factory constructor for live match center app bar
  factory CustomAppBar.liveMatch({
    Key? key,
    String? matchTitle,
    List<Widget>? actions,
  }) {
    return CustomAppBar(
      key: key,
      title: matchTitle ?? 'Live Matches',
      isLiveContext: true,
      actions: actions ??
          [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.refresh),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // Refresh live data
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Refreshing live data...'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                tooltip: 'Refresh',
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // Toggle favorite match
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Match added to favorites'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                tooltip: 'Add to Favorites',
              ),
            ),
          ],
    );
  }

  /// Factory constructor for team profile app bar
  factory CustomAppBar.teamProfile({
    Key? key,
    required String teamName,
    List<Widget>? actions,
  }) {
    return CustomAppBar(
      key: key,
      title: teamName,
      showBackButton: true,
      actions: actions ??
          [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.favorite_border),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // Toggle follow team
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Following $teamName'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                tooltip: 'Follow Team',
              ),
            ),
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // Share team profile
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sharing team profile...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                tooltip: 'Share',
              ),
            ),
          ],
    );
  }

  /// Factory constructor for player profile app bar
  factory CustomAppBar.playerProfile({
    Key? key,
    required String playerName,
    List<Widget>? actions,
  }) {
    return CustomAppBar(
      key: key,
      title: playerName,
      showBackButton: true,
      actions: actions ??
          [
            Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.share),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  // Share player profile
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Sharing player profile...'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                tooltip: 'Share',
              ),
            ),
          ],
    );
  }

  /// Factory constructor with TabBar for fixtures and results
  factory CustomAppBar.withTabs({
    Key? key,
    required String title,
    required List<String> tabs,
    TabController? tabController,
    List<Widget>? actions,
  }) {
    return CustomAppBar(
      key: key,
      title: title,
      actions: actions,
      bottom: TabBar(
        controller: tabController,
        tabs: tabs.map((tab) => Tab(text: tab)).toList(),
        isScrollable: tabs.length > 3,
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
