import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AdditionalDetailsWidget extends StatefulWidget {
  final Map<String, dynamic> additionalData;

  const AdditionalDetailsWidget({Key? key, required this.additionalData})
    : super(key: key);

  @override
  State<AdditionalDetailsWidget> createState() =>
      _AdditionalDetailsWidgetState();
}

class _AdditionalDetailsWidgetState extends State<AdditionalDetailsWidget> {
  String _expandedSection = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
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
        children: [
          // Vaccination History Section
          _buildCollapsibleSection(
            "vaccination",
            "Vaccination History",
            "Complete vaccination records",
            'vaccines',
            AppTheme.successLight,
            _buildVaccinationContent(),
          ),

          Divider(
            height: 1,
            color: AppTheme.lightTheme.colorScheme.outline.withValues(
              alpha: 0.2,
            ),
          ),

          // Feeding Information Section
          _buildCollapsibleSection(
            "feeding",
            "Feeding Information",
            "Diet and nutrition details",
            'restaurant',
            AppTheme.sellerAccentLight,
            _buildFeedingContent(),
          ),

          Divider(
            height: 1,
            color: AppTheme.lightTheme.colorScheme.outline.withValues(
              alpha: 0.2,
            ),
          ),

          // Transport Requirements Section
          _buildCollapsibleSection(
            "transport",
            "Transport Requirements",
            "Shipping and handling guidelines",
            'local_shipping',
            AppTheme.transportAccentLight,
            _buildTransportContent(),
          ),
        ],
      ),
    );
  }

  Widget _buildCollapsibleSection(
    String sectionId,
    String title,
    String subtitle,
    String iconName,
    Color color,
    Widget content,
  ) {
    final bool isExpanded = _expandedSection == sectionId;

    return Column(
      children: [
        InkWell(
          onTap: () {
            setState(() {
              _expandedSection = isExpanded ? "" : sectionId;
            });
          },
          child: Container(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(2.w),
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: CustomIconWidget(
                    iconName: iconName,
                    color: color,
                    size: 5.w,
                  ),
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: AppTheme.lightTheme.textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                            ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        subtitle,
                        style: AppTheme.lightTheme.textTheme.bodyMedium
                            ?.copyWith(
                              color: AppTheme
                                  .lightTheme
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ),
                ),
                CustomIconWidget(
                  iconName: isExpanded ? 'expand_less' : 'expand_more',
                  color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                  size: 6.w,
                ),
              ],
            ),
          ),
        ),
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: isExpanded ? null : 0,
          child: isExpanded
              ? Container(
                  padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
                  child: content,
                )
              : const SizedBox.shrink(),
        ),
      ],
    );
  }

  Widget _buildVaccinationContent() {
    final vaccinations =
        (widget.additionalData["vaccinations"] as List?)
            ?.cast<Map<String, dynamic>>() ??
        [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (vaccinations.isEmpty)
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.warningLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: 'info',
                  color: AppTheme.warningLight,
                  size: 4.w,
                ),
                SizedBox(width: 2.w),
                Expanded(
                  child: Text(
                    "No vaccination records available",
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          )
        else
          ...vaccinations
              .map(
                (vaccination) => Container(
                  margin: EdgeInsets.only(bottom: 2.h),
                  padding: EdgeInsets.all(3.w),
                  decoration: BoxDecoration(
                    color: AppTheme.successLight.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(2.w),
                    border: Border.all(
                      color: AppTheme.successLight.withValues(alpha: 0.2),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'check_circle',
                            color: AppTheme.successLight,
                            size: 4.w,
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: Text(
                              vaccination["name"] as String? ??
                                  "Unknown Vaccine",
                              style: AppTheme.lightTheme.textTheme.titleSmall
                                  ?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: AppTheme
                                        .lightTheme
                                        .colorScheme
                                        .onSurface,
                                  ),
                            ),
                          ),
                          Text(
                            vaccination["date"] as String? ?? "N/A",
                            style: AppTheme.lightTheme.textTheme.bodySmall
                                ?.copyWith(
                                  color: AppTheme
                                      .lightTheme
                                      .colorScheme
                                      .onSurfaceVariant,
                                  fontWeight: FontWeight.w500,
                                ),
                          ),
                        ],
                      ),
                      if (vaccination["description"] != null) ...[
                        SizedBox(height: 1.h),
                        Text(
                          vaccination["description"] as String,
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                                color: AppTheme
                                    .lightTheme
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                      ],
                    ],
                  ),
                ),
              )
              .toList(),
      ],
    );
  }

  Widget _buildFeedingContent() {
    final feeding =
        widget.additionalData["feeding"] as Map<String, dynamic>? ?? {};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          "Daily Feed",
          "${feeding["dailyFeed"] ?? "N/A"} kg",
          'restaurant',
        ),
        SizedBox(height: 1.5.h),
        _buildInfoRow(
          "Feed Type",
          feeding["feedType"] as String? ?? "N/A",
          'grass',
        ),
        SizedBox(height: 1.5.h),
        _buildInfoRow(
          "Water Intake",
          "${feeding["waterIntake"] ?? "N/A"} L/day",
          'water_drop',
        ),
        SizedBox(height: 1.5.h),
        _buildInfoRow(
          "Feeding Schedule",
          feeding["schedule"] as String? ?? "N/A",
          'schedule',
        ),
        if (feeding["specialDiet"] != null) ...[
          SizedBox(height: 2.h),
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.sellerAccentLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'star',
                      color: AppTheme.sellerAccentLight,
                      size: 4.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      "Special Diet Requirements",
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.sellerAccentLight,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  feeding["specialDiet"] as String,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildTransportContent() {
    final transport =
        widget.additionalData["transport"] as Map<String, dynamic>? ?? {};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildInfoRow(
          "Transport Mode",
          transport["mode"] as String? ?? "N/A",
          'local_shipping',
        ),
        SizedBox(height: 1.5.h),
        _buildInfoRow(
          "Estimated Time",
          transport["estimatedTime"] as String? ?? "N/A",
          'schedule',
        ),
        SizedBox(height: 1.5.h),
        _buildInfoRow(
          "Transport Cost",
          transport["cost"] as String? ?? "N/A",
          'currency_rupee',
        ),
        SizedBox(height: 1.5.h),
        _buildInfoRow(
          "Insurance",
          transport["insurance"] as String? ?? "N/A",
          'security',
        ),

        SizedBox(height: 2.h),

        // Special Instructions
        if (transport["instructions"] != null)
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: AppTheme.transportAccentLight.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2.w),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CustomIconWidget(
                      iconName: 'info',
                      color: AppTheme.transportAccentLight,
                      size: 4.w,
                    ),
                    SizedBox(width: 2.w),
                    Text(
                      "Special Instructions",
                      style: AppTheme.lightTheme.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: AppTheme.transportAccentLight,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 1.h),
                Text(
                  transport["instructions"] as String,
                  style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value, String iconName) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: AppTheme.lightTheme.colorScheme.primary,
          size: 4.w,
        ),
        SizedBox(width: 3.w),
        Text(
          "$label:",
          style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w500,
            color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
          ),
        ),
        SizedBox(width: 2.w),
        Expanded(
          child: Text(
            value,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.lightTheme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.end,
          ),
        ),
      ],
    );
  }
}
