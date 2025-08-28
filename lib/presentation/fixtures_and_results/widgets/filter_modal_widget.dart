import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/app_export.dart';

class FilterModalWidget extends StatefulWidget {
  final List<String> selectedCompetitions;
  final ValueChanged<List<String>> onApplyFilters;

  const FilterModalWidget({
    super.key,
    required this.selectedCompetitions,
    required this.onApplyFilters,
  });

  @override
  State<FilterModalWidget> createState() => _FilterModalWidgetState();
}

class _FilterModalWidgetState extends State<FilterModalWidget> {
  late List<String> _tempSelectedCompetitions;

  final List<Map<String, dynamic>> _competitions = [
    {
      'name': 'NBC Premier League',
      'logo':
          'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=100&h=100&fit=crop',
      'color': Color(0xFF2E7D32),
    },
    {
      'name': 'Championship League',
      'logo':
          'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=100&h=100&fit=crop',
      'color': Color(0xFFFFC107),
    },
    {
      'name': 'Federation Cup',
      'logo':
          'https://images.unsplash.com/photo-1579952363873-27d3bfad9c0d?w=100&h=100&fit=crop',
      'color': Color(0xFFD32F2F),
    },
    {
      'name': 'Community Shield',
      'logo':
          'https://images.unsplash.com/photo-1606925797300-0b35e9d1794e?w=100&h=100&fit=crop',
      'color': Color(0xFF1976D2),
    },
    {
      'name': 'Women\'s League',
      'logo':
          'https://images.unsplash.com/photo-1551698618-1dfe5d97d256?w=100&h=100&fit=crop',
      'color': Color(0xFF7B1FA2),
    },
    {
      'name': 'Youth League',
      'logo':
          'https://images.unsplash.com/photo-1574629810360-7efbbe195018?w=100&h=100&fit=crop',
      'color': Color(0xFF388E3C),
    },
  ];

  @override
  void initState() {
    super.initState();
    _tempSelectedCompetitions = List.from(widget.selectedCompetitions);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: 70.h,
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            width: 12.w,
            height: 0.5.h,
            margin: EdgeInsets.symmetric(vertical: 1.h),
            decoration: BoxDecoration(
              color: theme.colorScheme.onSurface.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(2),
            ),
          ),

          // Header
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Filter Competitions',
                  style: GoogleFonts.inter(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: theme.colorScheme.onSurface,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: CustomIconWidget(
                    iconName: 'close',
                    color: theme.colorScheme.onSurface,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),

          Divider(
            color: theme.colorScheme.outline.withValues(alpha: 0.3),
            height: 1,
          ),

          // Competition list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              itemCount: _competitions.length,
              itemBuilder: (context, index) {
                final competition = _competitions[index];
                final isSelected =
                    _tempSelectedCompetitions.contains(competition['name']);

                return Container(
                  margin: EdgeInsets.only(bottom: 1.h),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? theme.colorScheme.primary.withValues(alpha: 0.1)
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? theme.colorScheme.primary
                          : theme.colorScheme.outline.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 4.w, vertical: 0.5.h),
                    leading: Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: competition['color'],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomImageWidget(
                          imageUrl: competition['logo'],
                          width: 12.w,
                          height: 12.w,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text(
                      competition['name'],
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                    trailing: Checkbox(
                      value: isSelected,
                      onChanged: (value) {
                        setState(() {
                          if (value == true) {
                            _tempSelectedCompetitions.add(competition['name']);
                          } else {
                            _tempSelectedCompetitions
                                .remove(competition['name']);
                          }
                        });
                      },
                      activeColor: theme.colorScheme.primary,
                    ),
                    onTap: () {
                      setState(() {
                        if (isSelected) {
                          _tempSelectedCompetitions.remove(competition['name']);
                        } else {
                          _tempSelectedCompetitions.add(competition['name']);
                        }
                      });
                    },
                  ),
                );
              },
            ),
          ),

          // Action buttons
          Container(
            padding: EdgeInsets.all(4.w),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              border: Border(
                top: BorderSide(
                  color: theme.colorScheme.outline.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _tempSelectedCompetitions.clear();
                      });
                    },
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                      side: BorderSide(
                        color: theme.colorScheme.outline,
                        width: 1,
                      ),
                    ),
                    child: Text(
                      'Clear All',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 4.w),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      widget.onApplyFilters(_tempSelectedCompetitions);
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 1.5.h),
                    ),
                    child: Text(
                      'Apply Filters (${_tempSelectedCompetitions.length})',
                      style: GoogleFonts.inter(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}