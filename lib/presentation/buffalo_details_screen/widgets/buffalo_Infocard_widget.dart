import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:animal_kart/widgets/custom_Image_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BuffaloInfoCardWidget extends StatelessWidget {
  final Map<String, dynamic> buffaloData;

  const BuffaloInfoCardWidget({Key? key, required this.buffaloData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      padding: EdgeInsets.all(4.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        borderRadius: BorderRadius.circular(3.w),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Price Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      buffaloData["name"] as String? ?? "Buffalo",
                      style: AppTheme.lightTheme.textTheme.headlineSmall
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: AppTheme.lightTheme.colorScheme.onSurface,
                          ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      buffaloData["breed"] as String? ?? "Unknown Breed",
                      style: AppTheme.lightTheme.textTheme.bodyLarge?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.primary,
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: Text(
                  buffaloData["price"] as String? ?? "₹0",
                  style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Buffalo Details Grid
          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  "Age",
                  "${buffaloData["age"] ?? "N/A"} years",
                  'calendar_today',
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  "Weight",
                  "${buffaloData["weight"] ?? "N/A"} kg",
                  'fitness_center',
                ),
              ),
            ],
          ),

          SizedBox(height: 1.5.h),

          Row(
            children: [
              Expanded(
                child: _buildDetailItem(
                  "Gender",
                  buffaloData["gender"] as String? ?? "N/A",
                  'pets',
                ),
              ),
              Expanded(
                child: _buildDetailItem(
                  "Milk Yield",
                  "${buffaloData["milkYield"] ?? "N/A"} L/day",
                  'local_drink',
                ),
              ),
            ],
          ),

          SizedBox(height: 2.h),

          // Seller Info Row
          Row(
            children: [
              Container(
                width: 12.w,
                height: 12.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppTheme.lightTheme.colorScheme.primary,
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: CustomImageWidget(
                    imageUrl:
                        (buffaloData["seller"]
                                as Map<String, dynamic>?)?["avatar"]
                            as String? ??
                        "",
                    width: 12.w,
                    height: 12.w,
                    fit: BoxFit.cover,
                    semanticLabel:
                        (buffaloData["seller"]
                                as Map<
                                  String,
                                  dynamic
                                >?)?["avatarSemanticLabel"]
                            as String? ??
                        "Seller profile photo",
                  ),
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (buffaloData["seller"] as Map<String, dynamic>?)?["name"]
                              as String? ??
                          "Unknown Seller",
                      style: AppTheme.lightTheme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: 'location_on',
                          color: AppTheme.lightTheme.colorScheme.primary,
                          size: 4.w,
                        ),
                        SizedBox(width: 1.w),
                        Expanded(
                          child: Text(
                            (buffaloData["seller"]
                                        as Map<String, dynamic>?)?["location"]
                                    as String? ??
                                "Unknown Location",
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(
                                  color: AppTheme
                                      .lightTheme
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Rating
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: AppTheme.successLight,
                  borderRadius: BorderRadius.circular(1.5.w),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CustomIconWidget(
                      iconName: 'star',
                      color: Colors.white,
                      size: 3.w,
                    ),
                    SizedBox(width: 1.w),
                    Text(
                      "${(buffaloData["seller"] as Map<String, dynamic>?)?["rating"] ?? "0.0"}",
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDetailItem(String label, String value, String iconName) {
    return Container(
      padding: EdgeInsets.all(2.w),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.primary.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Column(
        children: [
          CustomIconWidget(
            iconName: iconName,
            color: AppTheme.lightTheme.colorScheme.primary,
            size: 5.w,
          ),
          SizedBox(height: 0.5.h),
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 0.2.h),
          Text(
            value,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
