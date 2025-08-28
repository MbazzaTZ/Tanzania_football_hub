import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Tab item data class for custom tab bar
class TabItem {
  final String label;
  final IconData? icon;
  final Widget? customWidget;
  final String? route;
  final bool isActive;
  final int? badgeCount;

  const TabItem({
    required this.label,
    this.icon,
    this.customWidget,
    this.route,
    this.isActive = false,
    this.badgeCount,
  });
}

/// Custom Tab Bar implementing Contemporary Sports Minimalism
/// with Tanzanian Heritage Palette for football application section navigation.
class CustomTabBar extends StatelessWidget implements PreferredSizeWidget {
  /// List of tab items
  final List<TabItem> tabs;
  
  /// Current selected index
  final int currentIndex;
  
  /// Callback when tab is tapped
  final ValueChanged<int>? onTap;
  
  /// Whether tabs are scrollable
  final bool isScrollable;
  
  /// Tab controller for advanced control
  final TabController? controller;
  
  /// Background color override
  final Color? backgroundColor;
  
  /// Selected tab color override
  final Color? selectedColor;
  
  /// Unselected tab color override
  final Color? unselectedColor;
  
  /// Indicator color override
  final Color? indicatorColor;
  
  /// Whether to show badges on tabs
  final bool showBadges;
  
  /// Custom height for the tab bar
  final double? height;

  const CustomTabBar({
    super.key,
    required this.tabs,
    required this.currentIndex,
    this.onTap,
    this.isScrollable = false,
    this.controller,
    this.backgroundColor,
    this.selectedColor,
    this.unselectedColor,
    this.indicatorColor,
    this.showBadges = true,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    // Theme colors
    final Color effectiveBackgroundColor = backgroundColor ?? 
        theme.colorScheme.surface;
    
    final Color effectiveSelectedColor = selectedColor ?? 
        theme.colorScheme.primary;
    
    final Color effectiveUnselectedColor = unselectedColor ?? 
        (isDark ? const Color(0xFFBDBDBD) : const Color(0xFF757575));
    
    final Color effectiveIndicatorColor = indicatorColor ?? 
        effectiveSelectedColor;

    return Container(
      height: height ?? kToolbarHeight,
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        border: Border(
          bottom: BorderSide(
            color: isDark 
                ? const Color(0xFF424242) 
                : const Color(0xFFE0E0E0),
            width: 1.0,
          ),
        ),
      ),
      child: TabBar(
        controller: controller,
        tabs: tabs.asMap().entries.map((entry) {
          final index = entry.key;
          final tab = entry.value;
          final isSelected = index == currentIndex;
          
          return _CustomTab(
            item: tab,
            isSelected: isSelected,
            selectedColor: effectiveSelectedColor,
            unselectedColor: effectiveUnselectedColor,
            showBadge: showBadges,
          );
        }).toList(),
        isScrollable: isScrollable,
        labelColor: effectiveSelectedColor,
        unselectedLabelColor: effectiveUnselectedColor,
        indicatorColor: effectiveIndicatorColor,
        indicatorSize: TabBarIndicatorSize.label,
        indicatorWeight: 2.0,
        labelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        onTap: (index) {
          HapticFeedback.lightImpact();
          if (onTap != null) {
            onTap!(index);
          } else if (tabs[index].route != null) {
            Navigator.pushNamed(context, tabs[index].route!);
          }
        },
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height ?? kToolbarHeight);

  /// Factory constructor for fixtures and results tabs
  factory CustomTabBar.fixturesResults({
    Key? key,
    required int currentIndex,
    ValueChanged<int>? onTap,
    TabController? controller,
  }) {
    return CustomTabBar(
      key: key,
      currentIndex: currentIndex,
      onTap: onTap,
      controller: controller,
      tabs: const [
        TabItem(
          label: 'Fixtures',
          icon: Icons.schedule,
        ),
        TabItem(
          label: 'Results',
          icon: Icons.check_circle_outline,
        ),
        TabItem(
          label: 'Live',
          icon: Icons.radio_button_checked,
          isActive: true,
        ),
      ],
    );
  }

  /// Factory constructor for league tables tabs
  factory CustomTabBar.leagueTables({
    Key? key,
    required int currentIndex,
    ValueChanged<int>? onTap,
    TabController? controller,
  }) {
    return CustomTabBar(
      key: key,
      currentIndex: currentIndex,
      onTap: onTap,
      controller: controller,
      isScrollable: true,
      tabs: const [
        TabItem(label: 'Premier League'),
        TabItem(label: 'First Division'),
        TabItem(label: 'Women\'s League'),
        TabItem(label: 'Youth League'),
      ],
    );
  }

  /// Factory constructor for team profile tabs
  factory CustomTabBar.teamProfile({
    Key? key,
    required int currentIndex,
    ValueChanged<int>? onTap,
    TabController? controller,
  }) {
    return CustomTabBar(
      key: key,
      currentIndex: currentIndex,
      onTap: onTap,
      controller: controller,
      tabs: const [
        TabItem(
          label: 'Overview',
          icon: Icons.info_outline,
        ),
        TabItem(
          label: 'Squad',
          icon: Icons.groups,
        ),
        TabItem(
          label: 'Fixtures',
          icon: Icons.calendar_today,
        ),
        TabItem(
          label: 'Stats',
          icon: Icons.bar_chart,
        ),
      ],
    );
  }

  /// Factory constructor for live match center tabs
  factory CustomTabBar.liveMatches({
    Key? key,
    required int currentIndex,
    ValueChanged<int>? onTap,
    TabController? controller,
    int liveMatchCount = 0,
  }) {
    return CustomTabBar(
      key: key,
      currentIndex: currentIndex,
      onTap: onTap,
      controller: controller,
      tabs: [
        TabItem(
          label: 'Live Now',
          icon: Icons.radio_button_checked,
          isActive: true,
          badgeCount: liveMatchCount > 0 ? liveMatchCount : null,
        ),
        const TabItem(
          label: 'Today',
          icon: Icons.today,
        ),
        const TabItem(
          label: 'Tomorrow',
          icon: Icons.event,
        ),
      ],
    );
  }

  /// Factory constructor for player profile tabs
  factory CustomTabBar.playerProfile({
    Key? key,
    required int currentIndex,
    ValueChanged<int>? onTap,
    TabController? controller,
  }) {
    return CustomTabBar(
      key: key,
      currentIndex: currentIndex,
      onTap: onTap,
      controller: controller,
      tabs: const [
        TabItem(
          label: 'Overview',
          icon: Icons.person_outline,
        ),
        TabItem(
          label: 'Stats',
          icon: Icons.bar_chart,
        ),
        TabItem(
          label: 'Career',
          icon: Icons.timeline,
        ),
      ],
    );
  }
}

/// Individual tab widget
class _CustomTab extends StatelessWidget {
  final TabItem item;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final bool showBadge;

  const _CustomTab({
    required this.item,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.showBadge,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final Color textColor = isSelected ? selectedColor : unselectedColor;
    
    // Custom widget override
    if (item.customWidget != null) {
      return Tab(child: item.customWidget);
    }

    return Tab(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              if (item.icon != null) ...[
                Stack(
                  clipBehavior: Clip.none,
                  children: [
                    Icon(
                      item.icon,
                      size: 20,
                      color: textColor,
                    ),
                    // Active indicator for live content
                    if (item.isActive)
                      Positioned(
                        right: -2,
                        top: -2,
                        child: Container(
                          width: 6,
                          height: 6,
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
                const SizedBox(width: 8),
              ],
              
              // Label
              Flexible(
                child: Text(
                  item.label,
                  style: GoogleFonts.inter(
                    fontSize: 14,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                    color: textColor,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          
          // Badge count
          if (showBadge && item.badgeCount != null && item.badgeCount! > 0)
            Positioned(
              right: -8,
              top: -8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: isDark 
                      ? const Color(0xFFEF5350) 
                      : const Color(0xFFD32F2F),
                  borderRadius: BorderRadius.circular(10),
                ),
                constraints: const BoxConstraints(
                  minWidth: 16,
                  minHeight: 16,
                ),
                child: Text(
                  item.badgeCount! > 99 ? '99+' : item.badgeCount.toString(),
                  style: GoogleFonts.inter(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Variant enum for different tab bar configurations
enum TabBarVariant {
  /// Standard tabs with text only
  standard,
  
  /// Tabs with icons and text
  withIcons,
  
  /// Tabs with badges and indicators
  withBadges,
  
  /// Scrollable tabs for many options
  scrollable,
}

/// Extension for creating tab bars with specific variants
extension CustomTabBarVariants on CustomTabBar {
  /// Create tab bar with specific variant
  factory CustomTabBar.variant({
    Key? key,
    required TabBarVariant variant,
    required List<String> labels,
    required int currentIndex,
    ValueChanged<int>? onTap,
    TabController? controller,
    List<IconData>? icons,
    List<int>? badgeCounts,
  }) {
    List<TabItem> tabs;
    
    switch (variant) {
      case TabBarVariant.withIcons:
        tabs = labels.asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value;
          return TabItem(
            label: label,
            icon: icons != null && index < icons.length 
                ? icons[index] 
                : Icons.circle_outlined,
          );
        }).toList();
        break;
        
      case TabBarVariant.withBadges:
        tabs = labels.asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value;
          return TabItem(
            label: label,
            badgeCount: badgeCounts != null && index < badgeCounts.length 
                ? badgeCounts[index] 
                : null,
          );
        }).toList();
        break;
        
      case TabBarVariant.scrollable:
        tabs = labels.map((label) => TabItem(label: label)).toList();
        return CustomTabBar(
          key: key,
          tabs: tabs,
          currentIndex: currentIndex,
          onTap: onTap,
          controller: controller,
          isScrollable: true,
        );
        
      case TabBarVariant.standard:
      default:
        tabs = labels.map((label) => TabItem(label: label)).toList();
        break;
    }
    
    return CustomTabBar(
      key: key,
      tabs: tabs,
      currentIndex: currentIndex,
      onTap: onTap,
      controller: controller,
    );
  }
}