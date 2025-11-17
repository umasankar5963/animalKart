import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class QuickStatsWidget extends StatelessWidget {
  final int totalBuffalos;
  final String averagePrice;
  final String lastUpdated;

  const QuickStatsWidget({
    Key? key,
    required this.totalBuffalos,
    required this.averagePrice,
    required this.lastUpdated,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryLight.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppTheme.primaryLight.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildStatItem(
                  icon: 'pets',
                  label: 'Available Buffalo',
                  value: totalBuffalos.toString(),
                  color: AppTheme.primaryLight,
                ),
              ),
              Container(
                width: 1,
                height: 6.h,
                color: AppTheme.lightTheme.dividerColor,
              ),
              Expanded(
                child: _buildStatItem(
                  icon: 'currency_rupee',
                  label: 'Average Price',
                  value: averagePrice,
                  color: AppTheme.sellerAccentLight,
                ),
              ),
            ],
          ),
          SizedBox(height: 2.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomIconWidget(
                iconName: 'update',
                color: AppTheme.textMediumEmphasisLight,
                size: 16,
              ),
              SizedBox(width: 2.w),
              Text(
                'Last updated: $lastUpdated',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.textMediumEmphasisLight,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String icon,
    required String label,
    required String value,
    required Color color,
  }) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(2.w),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: CustomIconWidget(iconName: icon, color: color, size: 24),
        ),
        SizedBox(height: 1.h),
        Text(
          value,
          style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
            color: color,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 0.5.h),
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textMediumEmphasisLight,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
