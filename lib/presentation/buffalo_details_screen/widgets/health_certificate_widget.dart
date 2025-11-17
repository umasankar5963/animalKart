import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:animal_kart/widgets/custom_Image_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class HealthCertificateWidget extends StatelessWidget {
  final Map<String, dynamic> healthData;

  const HealthCertificateWidget({Key? key, required this.healthData})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isVerified = healthData["isVerified"] as bool? ?? false;
    final String status = healthData["status"] as String? ?? "pending";

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
          // Header Row
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: _getStatusColor(status).withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(2.w),
                ),
                child: CustomIconWidget(
                  iconName: 'verified_user',
                  color: _getStatusColor(status),
                  size: 6.w,
                ),
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Health Certificate",
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Row(
                      children: [
                        CustomIconWidget(
                          iconName: isVerified ? 'check_circle' : 'pending',
                          color: _getStatusColor(status),
                          size: 4.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          _getStatusText(status),
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                                color: _getStatusColor(status),
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              if (isVerified)
                InkWell(
                  onTap: () => _viewCertificate(context),
                  borderRadius: BorderRadius.circular(2.w),
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 3.w,
                      vertical: 1.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.lightTheme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomIconWidget(
                          iconName: 'visibility',
                          color: Colors.white,
                          size: 4.w,
                        ),
                        SizedBox(width: 1.w),
                        Text(
                          "View",
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),

          if (isVerified) ...[
            SizedBox(height: 2.h),

            // Certificate Details
            Container(
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
                children: [
                  _buildCertificateRow(
                    "Certificate ID",
                    healthData["certificateId"] as String? ?? "N/A",
                    'badge',
                  ),
                  SizedBox(height: 1.h),
                  _buildCertificateRow(
                    "Issued By",
                    healthData["issuedBy"] as String? ?? "N/A",
                    'person',
                  ),
                  SizedBox(height: 1.h),
                  _buildCertificateRow(
                    "Issue Date",
                    healthData["issueDate"] as String? ?? "N/A",
                    'calendar_today',
                  ),
                  SizedBox(height: 1.h),
                  _buildCertificateRow(
                    "Valid Until",
                    healthData["validUntil"] as String? ?? "N/A",
                    'schedule',
                  ),
                ],
              ),
            ),

            SizedBox(height: 2.h),

            // Health Status
            Text(
              "Health Status",
              style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
                color: AppTheme.lightTheme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 1.h),

            Wrap(
              spacing: 2.w,
              runSpacing: 1.h,
              children: [
                _buildHealthStatusChip("Vaccinated", true),
                _buildHealthStatusChip("Disease Free", true),
                _buildHealthStatusChip(
                  "Fit for Breeding",
                  healthData["fitForBreeding"] as bool? ?? false,
                ),
                _buildHealthStatusChip(
                  "Transport Ready",
                  healthData["transportReady"] as bool? ?? false,
                ),
              ],
            ),
          ] else ...[
            SizedBox(height: 2.h),

            // Pending Status Message
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.warningLight.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(2.w),
                border: Border.all(
                  color: AppTheme.warningLight.withValues(alpha: 0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  CustomIconWidget(
                    iconName: 'info',
                    color: AppTheme.warningLight,
                    size: 5.w,
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Text(
                      "Health certificate verification is in progress. Please check back later for updated status.",
                      style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                        color: AppTheme.lightTheme.colorScheme.onSurface,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildCertificateRow(String label, String value, String iconName) {
    return Row(
      children: [
        CustomIconWidget(
          iconName: iconName,
          color: AppTheme.successLight,
          size: 4.w,
        ),
        SizedBox(width: 2.w),
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

  Widget _buildHealthStatusChip(String label, bool isPositive) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: isPositive
            ? AppTheme.successLight.withValues(alpha: 0.1)
            : AppTheme.errorLight.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(2.w),
        border: Border.all(
          color: isPositive
              ? AppTheme.successLight.withValues(alpha: 0.3)
              : AppTheme.errorLight.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CustomIconWidget(
            iconName: isPositive ? 'check_circle' : 'cancel',
            color: isPositive ? AppTheme.successLight : AppTheme.errorLight,
            size: 3.w,
          ),
          SizedBox(width: 1.w),
          Text(
            label,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: isPositive ? AppTheme.successLight : AppTheme.errorLight,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case "verified":
        return AppTheme.successLight;
      case "pending":
        return AppTheme.warningLight;
      case "rejected":
        return AppTheme.errorLight;
      default:
        return AppTheme.neutralLight;
    }
  }

  String _getStatusText(String status) {
    switch (status.toLowerCase()) {
      case "verified":
        return "Verified";
      case "pending":
        return "Verification Pending";
      case "rejected":
        return "Verification Failed";
      default:
        return "Unknown Status";
    }
  }

  void _viewCertificate(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 80.h,
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(5.w)),
        ),
        child: Column(
          children: [
            // Handle
            Container(
              margin: EdgeInsets.only(top: 2.h),
              width: 10.w,
              height: 0.5.h,
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                    .withValues(alpha: 0.3),
                borderRadius: BorderRadius.circular(0.25.h),
              ),
            ),

            // Header
            Padding(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Health Certificate",
                      style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: CustomIconWidget(
                      iconName: 'close',
                      color: AppTheme.lightTheme.colorScheme.onSurface,
                      size: 6.w,
                    ),
                  ),
                ],
              ),
            ),

            // Certificate Content
            Expanded(
              child: Container(
                margin: EdgeInsets.all(4.w),
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(3.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      CustomImageWidget(
                        imageUrl:
                            healthData["certificateImage"] as String? ??
                            "https://via.placeholder.com/400x600/E8F5E8/2E7D32?text=Health+Certificate",
                        width: double.infinity,
                        height: 60.h,
                        fit: BoxFit.contain,
                        semanticLabel:
                            "Health certificate document showing veterinary verification and health status details",
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
