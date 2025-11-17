import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:animal_kart/widgets/custom_Image_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BuyerInquiryCard extends StatelessWidget {
  final Map<String, dynamic> inquiry;
  final VoidCallback? onTap;

  const BuyerInquiryCard({Key? key, required this.inquiry, this.onTap})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool isUnread = inquiry['isUnread'] ?? false;

    return Card(
      elevation: 1,
      margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: EdgeInsets.all(3.w),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 6.w,
                    child: CustomImageWidget(
                      imageUrl: inquiry['buyerAvatar'] ?? '',
                      width: 12.w,
                      height: 12.w,
                      fit: BoxFit.cover,
                      semanticLabel:
                          inquiry['buyerAvatarLabel'] ??
                          'Buyer profile picture',
                    ),
                  ),
                  if (isUnread)
                    Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 3.w,
                        height: 3.w,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 1),
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(width: 3.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            inquiry['buyerName'] ?? 'Unknown Buyer',
                            style: AppTheme.lightTheme.textTheme.titleSmall
                                ?.copyWith(
                                  fontWeight: isUnread
                                      ? FontWeight.w600
                                      : FontWeight.w500,
                                ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        Text(
                          inquiry['time'] ?? '',
                          style: AppTheme.lightTheme.textTheme.bodySmall
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      'Interested in ${inquiry['buffaloBreed'] ?? 'your buffalo'}',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[700],
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      inquiry['message'] ?? 'No message',
                      style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                        color: Colors.grey[600],
                        fontWeight: isUnread
                            ? FontWeight.w500
                            : FontWeight.w400,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              CustomIconWidget(
                iconName: 'chevron_right',
                size: 20,
                color: Colors.grey[400]!,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
