import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

/// Navigation item data class for bottom navigation
class BottomNavItem {
  final String label;
  final IconData icon;
  final IconData? activeIcon;
  final String route;
  final bool isLive;

  const BottomNavItem({
    required this.label,
    required this.icon,
    this.activeIcon,
    required this.route,
    this.isLive = false,
  });
}

/// Custom Bottom Navigation Bar implementing Contemporary Sports Minimalism
/// with Tanzanian Heritage Palette for football application navigation.
class CustomBottomBar extends StatelessWidget {
  /// Current selected index
  final int currentIndex;
  
  /// Callback when item is tapped
  final ValueChanged<int>? onTap;
  
  /// Custom navigation items (if null, uses default football app items)
  final List<BottomNavItem>? items;
  
  /// Whether to show live indicator badges
  final bool showLiveIndicators;
  
  /// Background color override
  final Color? backgroundColor;
  
  /// Selected item color override
  final Color? selectedItemColor;
  
  /// Unselected item color override
  final Color? unselectedItemColor;

  const CustomBottomBar({
    super.key,
    required this.currentIndex,
    this.onTap,
    this.items,
    this.showLiveIndicators = true,
    this.backgroundColor,
    this.selectedItemColor,
    this.unselectedItemColor,
  });

  /// Default navigation items for football application
  static const List<BottomNavItem> _defaultItems = [
    BottomNavItem(
      label: 'Home',
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      route: '/home-screen',
    ),
    BottomNavItem(
      label: 'Live',
      icon: Icons.sports_soccer_outlined,
      activeIcon: Icons.sports_soccer,
      route: '/live-match-center',
      isLive: true,
    ),
    BottomNavItem(
      label: 'Fixtures',
      icon: Icons.calendar_today_outlined,
      activeIcon: Icons.calendar_today,
      route: '/fixtures-and-results',
    ),
    BottomNavItem(
      label: 'Tables',
      icon: Icons.table_chart_outlined,
      activeIcon: Icons.table_chart,
      route: '/league-tables',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final effectiveItems = items ?? _defaultItems;
    
    // Theme colors
    final Color effectiveBackgroundColor = backgroundColor ?? 
        theme.bottomNavigationBarTheme.backgroundColor ?? 
        theme.colorScheme.surface;
    
    final Color effectiveSelectedColor = selectedItemColor ?? 
        theme.bottomNavigationBarTheme.selectedItemColor ?? 
        theme.colorScheme.primary;
    
    final Color effectiveUnselectedColor = unselectedItemColor ?? 
        theme.bottomNavigationBarTheme.unselectedItemColor ?? 
        (isDark ? const Color(0xFFBDBDBD) : const Color(0xFF757575));

    return Container(
      decoration: BoxDecoration(
        color: effectiveBackgroundColor,
        boxShadow: [
          BoxShadow(
            color: isDark 
                ? Colors.black.withValues(alpha: 0.3)
                : Colors.black.withValues(alpha: 0.1),
            offset: const Offset(0, -1),
            blurRadius: 4,
            spreadRadius: 0,
          ),
        ],
      ),
      child: SafeArea(
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: effectiveItems.asMap().entries.map((entry) {
              final index = entry.key;
              final item = entry.value;
              final isSelected = index == currentIndex;
              
              return Expanded(
                child: _BottomNavItemWidget(
                  item: item,
                  isSelected: isSelected,
                  selectedColor: effectiveSelectedColor,
                  unselectedColor: effectiveUnselectedColor,
                  showLiveIndicator: showLiveIndicators && item.isLive,
                  onTap: () {
                    HapticFeedback.lightImpact();
                    if (onTap != null) {
                      onTap!(index);
                    } else {
                      // Default navigation behavior
                      Navigator.pushNamed(context, item.route);
                    }
                  },
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

/// Individual bottom navigation item widget
class _BottomNavItemWidget extends StatelessWidget {
  final BottomNavItem item;
  final bool isSelected;
  final Color selectedColor;
  final Color unselectedColor;
  final bool showLiveIndicator;
  final VoidCallback onTap;

  const _BottomNavItemWidget({
    required this.item,
    required this.isSelected,
    required this.selectedColor,
    required this.unselectedColor,
    required this.showLiveIndicator,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    final Color itemColor = isSelected ? selectedColor : unselectedColor;
    final IconData effectiveIcon = isSelected && item.activeIcon != null 
        ? item.activeIcon! 
        : item.icon;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with optional live indicator
            Stack(
              clipBehavior: Clip.none,
              children: [
                Icon(
                  effectiveIcon,
                  color: itemColor,
                  size: 24,
                ),
                // Live indicator dot
                if (showLiveIndicator && item.isLive)
                  Positioned(
                    right: -2,
                    top: -2,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: isDark 
                            ? const Color(0xFFEF5350) // Red accent for dark theme
                            : const Color(0xFFD32F2F), // Red accent for light theme
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: (isDark 
                                ? const Color(0xFFEF5350) 
                                : const Color(0xFFD32F2F)).withValues(alpha: 0.3),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                        ],
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 4),
            // Label
            Text(
              item.label,
              style: GoogleFonts.inter(
                fontSize: 12,
                fontWeight: isSelected ? FontWeight.w500 : FontWeight.w400,
                color: itemColor,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

/// Extension for easy navigation integration
extension CustomBottomBarNavigation on CustomBottomBar {
  /// Create bottom bar with automatic navigation handling
  static Widget withAutoNavigation({
    Key? key,
    required BuildContext context,
    List<BottomNavItem>? customItems,
    bool showLiveIndicators = true,
  }) {
    final String currentRoute = ModalRoute.of(context)?.settings.name ?? '/home-screen';
    final items = customItems ?? CustomBottomBar._defaultItems;
    final currentIndex = items.indexWhere((item) => item.route == currentRoute);
    
    return CustomBottomBar(
      key: key,
      currentIndex: currentIndex >= 0 ? currentIndex : 0,
      items: items,
      showLiveIndicators: showLiveIndicators,
      onTap: (index) {
        final selectedItem = items[index];
        if (selectedItem.route != currentRoute) {
          Navigator.pushNamed(context, selectedItem.route);
        }
      },
    );
  }
}

/// Variant enum for different bottom bar configurations
enum BottomBarVariant {
  /// Standard 4-item navigation (Home, Live, Fixtures, Tables)
  standard,
  
  /// Extended 5-item navigation (adds Teams section)
  extended,
  
  /// Minimal 3-item navigation (Home, Live, Tables)
  minimal,
}

/// Factory methods for different bottom bar variants
class CustomBottomBarVariants {
  /// Create bottom bar with specific variant
  static CustomBottomBar variant({
    Key? key,
    required BottomBarVariant variant,
    required int currentIndex,
    ValueChanged<int>? onTap,
    bool showLiveIndicators = true,
  }) {
    List<BottomNavItem> items;
    
    switch (variant) {
      case BottomBarVariant.extended:
        items = [
          ...CustomBottomBar._defaultItems,
          const BottomNavItem(
            label: 'Teams',
            icon: Icons.groups_outlined,
            activeIcon: Icons.groups,
            route: '/team-profile',
          ),
        ];
        break;
      case BottomBarVariant.minimal:
        items = [
          CustomBottomBar._defaultItems[0], // Home
          CustomBottomBar._defaultItems[1], // Live
          CustomBottomBar._defaultItems[3], // Tables
        ];
        break;
      case BottomBarVariant.standard:
      default:
        items = CustomBottomBar._defaultItems;
        break;
    }
    
    return CustomBottomBar(
      key: key,
      currentIndex: currentIndex,
      onTap: onTap,
      items: items,
      showLiveIndicators: showLiveIndicators,
    );
  }
}