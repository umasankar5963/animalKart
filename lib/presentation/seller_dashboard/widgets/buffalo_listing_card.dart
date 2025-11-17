import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:animal_kart/widgets/custom_Image_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class BuffaloListingCard extends StatelessWidget {
  final Map<String, dynamic> buffalo;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onPromote;
  final VoidCallback? onMarkSold;
  final VoidCallback? onDelete;

  const BuffaloListingCard({
    Key? key,
    required this.buffalo,
    this.onTap,
    this.onEdit,
    this.onPromote,
    this.onMarkSold,
    this.onDelete,
  }) : super(key: key);

  Color _getStatusColor() {
    switch (buffalo['status']?.toLowerCase()) {
      case 'active':
        return AppTheme.lightTheme.colorScheme.primary;
      case 'pending approval':
        return AppTheme.lightTheme.colorScheme.tertiary;
      case 'sold':
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Slidable(
        key: ValueKey(buffalo['id']),
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => onEdit?.call(),
              backgroundColor: AppTheme.lightTheme.colorScheme.primary,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit',
              borderRadius: BorderRadius.circular(8),
            ),
            SlidableAction(
              onPressed: (_) => onPromote?.call(),
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              icon: Icons.trending_up,
              label: 'Promote',
              borderRadius: BorderRadius.circular(8),
            ),
            SlidableAction(
              onPressed: (_) => onMarkSold?.call(),
              backgroundColor: Colors.green,
              foregroundColor: Colors.white,
              icon: Icons.check_circle,
              label: 'Mark Sold',
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (_) => onDelete?.call(),
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete',
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: CustomImageWidget(
                          imageUrl: buffalo['image'] ?? '',
                          width: 20.w,
                          height: 15.h,
                          fit: BoxFit.cover,
                          semanticLabel:
                              buffalo['semanticLabel'] ?? 'Buffalo image',
                        ),
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
                                    buffalo['breed'] ?? 'Unknown Breed',
                                    style: AppTheme
                                        .lightTheme
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.symmetric(
                                    horizontal: 2.w,
                                    vertical: 0.5.h,
                                  ),
                                  decoration: BoxDecoration(
                                    color: _getStatusColor().withValues(
                                      alpha: 0.1,
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: _getStatusColor(),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    buffalo['status'] ?? 'Unknown',
                                    style: AppTheme
                                        .lightTheme
                                        .textTheme
                                        .labelSmall
                                        ?.copyWith(
                                          color: _getStatusColor(),
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 1.h),
                            Text(
                              buffalo['price'] ?? '₹0',
                              style: AppTheme.lightTheme.textTheme.titleLarge
                                  ?.copyWith(
                                    color:
                                        AppTheme.lightTheme.colorScheme.primary,
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                            SizedBox(height: 1.h),
                            Row(
                              children: [
                                CustomIconWidget(
                                  iconName: 'visibility',
                                  size: 16,
                                  color: Colors.grey[600]!,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  '${buffalo['views'] ?? 0} views',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey[600]),
                                ),
                                SizedBox(width: 4.w),
                                CustomIconWidget(
                                  iconName: 'message',
                                  size: 16,
                                  color: Colors.grey[600]!,
                                ),
                                SizedBox(width: 1.w),
                                Text(
                                  '${buffalo['inquiries'] ?? 0} inquiries',
                                  style: AppTheme.lightTheme.textTheme.bodySmall
                                      ?.copyWith(color: Colors.grey[600]),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
