import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import '../../../theme/app_theme.dart';

class FilterChipsWidget extends StatelessWidget {
  final List<Map<String, dynamic>> filters;
  final Function(String) onFilterTap;

  const FilterChipsWidget({
    Key? key,
    required this.filters,
    required this.onFilterTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 6.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = filter['isSelected'] as bool;

          return Container(
            margin: EdgeInsets.only(right: 2.w),
            child: FilterChip(
              label: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    filter['label'] as String,
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: isSelected
                          ? AppTheme.lightTheme.colorScheme.onPrimary
                          : AppTheme.textHighEmphasisLight,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  if (filter['count'] != null && filter['count'] > 0) ...[
                    SizedBox(width: 1.w),
                    Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 1.5.w,
                        vertical: 0.2.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? Colors.white.withValues(alpha: 0.3)
                            : AppTheme.primaryLight.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(
                        '${filter['count']}',
                        style: AppTheme.lightTheme.textTheme.bodySmall
                            ?.copyWith(
                              color: isSelected
                                  ? Colors.white
                                  : AppTheme.primaryLight,
                              fontWeight: FontWeight.w600,
                              fontSize: 10.sp,
                            ),
                      ),
                    ),
                  ],
                ],
              ),
              selected: isSelected,
              onSelected: (selected) => onFilterTap(filter['key'] as String),
              backgroundColor: AppTheme.lightTheme.colorScheme.surface,
              selectedColor: AppTheme.primaryLight,
              checkmarkColor: Colors.white,
              side: BorderSide(
                color: isSelected
                    ? AppTheme.primaryLight
                    : AppTheme.lightTheme.dividerColor,
                width: 1,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
            ),
          );
        },
      ),
    );
  }
}
