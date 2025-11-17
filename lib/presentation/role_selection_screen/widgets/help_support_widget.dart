import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HelpSupportWidget extends StatelessWidget {
  const HelpSupportWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: () {
            // Handle help navigation
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Help & Support coming soon!'),
                backgroundColor: AppTheme.lightTheme.colorScheme.primary,
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconWidget(
                iconName: 'help_outline',
                color: AppTheme.lightTheme.colorScheme.onSurface.withValues(
                  alpha: 0.6,
                ),
                size: 4.w,
              ),
              SizedBox(width: 1.w),
              Text(
                'Need Help?',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface.withValues(
                    alpha: 0.6,
                  ),
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 6.w),
        GestureDetector(
          onTap: () {
            // Handle language selection
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Language selection coming soon!'),
                backgroundColor: AppTheme.lightTheme.colorScheme.primary,
              ),
            );
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomIconWidget(
                iconName: 'language',
                color: AppTheme.lightTheme.colorScheme.onSurface.withValues(
                  alpha: 0.6,
                ),
                size: 4.w,
              ),
              SizedBox(width: 1.w),
              Text(
                'English',
                style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.lightTheme.colorScheme.onSurface.withValues(
                    alpha: 0.6,
                  ),
                  decoration: TextDecoration.underline,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
