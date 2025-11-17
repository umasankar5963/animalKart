import 'package:animal_kart/controllers/cart_controller.dart';
import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:animal_kart/widgets/custom_Image_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:sizer/sizer.dart';

class BuffaloCardWidget extends ConsumerStatefulWidget {
  final Map<String, dynamic> buffalo;
  final VoidCallback? onTap;
  final VoidCallback? onWishlistTap;
  final VoidCallback? onShareTap;
  final VoidCallback? onContactTap;
  final bool showAddToCart;

  const BuffaloCardWidget({
    this.showAddToCart = true,
    Key? key,
    required this.buffalo,
    this.onTap,
    this.onWishlistTap,
    this.onShareTap,
    this.onContactTap,
  }) : super(key: key);

  @override
  ConsumerState<BuffaloCardWidget> createState() => _BuffaloCardWidgetState();
}

class _BuffaloCardWidgetState extends ConsumerState<BuffaloCardWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: isDark
                  ? Colors.black.withOpacity(0.3)
                  : AppTheme.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: isDark
              ? Border.all(color: theme.dividerColor.withOpacity(0.1))
              : null,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Buffalo Image
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: CustomImageWidget(
                imageUrl: widget.buffalo['image'] as String,
                width: double.infinity,
                height: 25.h,
                fit: BoxFit.cover,
                semanticLabel: widget.buffalo['semanticLabel'] as String,
              ),
            ),

            Padding(
              padding: EdgeInsets.all(3.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Breed and Age Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          widget.buffalo['breed'] as String,
                          style: theme.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.textTheme.titleMedium?.color,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: theme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '${widget.buffalo['age']} years',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.primaryColor,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 1.h),

                  // Price
                  Text(
                    widget.buffalo['price'] as String,
                    style: theme.textTheme.titleLarge?.copyWith(
                      color: theme.colorScheme.secondary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  SizedBox(height: 1.h),

                  // Health Score and Seller Rating Row
                  Row(
                    children: [
                      // Health Score
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 2.w,
                          vertical: 0.5.h,
                        ),
                        decoration: BoxDecoration(
                          color: _getHealthScoreColor(
                            widget.buffalo['healthScore'] as int,
                          ).withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomIconWidget(
                              iconName: 'favorite',
                              color: _getHealthScoreColor(
                                widget.buffalo['healthScore'] as int,
                              ),
                              size: 16,
                            ),
                            SizedBox(width: 1.w),
                            Text(
                              '${widget.buffalo['healthScore']}/10',
                              style: AppTheme.lightTheme.textTheme.bodySmall
                                  ?.copyWith(
                                    color: _getHealthScoreColor(
                                      widget.buffalo['healthScore'] as int,
                                    ),
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(width: 3.w),

                      // Seller Rating
                      Row(
                        children: [
                          CustomIconWidget(
                            iconName: 'star',
                            color: AppTheme.warningLight,
                            size: 16,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            '${widget.buffalo['sellerRating']}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.secondary,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),

                      const Spacer(),

                      // Quick Actions
                      Row(
                        children: [
                          if (widget.showAddToCart) ...[
                            Consumer(
                              builder: (context, ref, _) {
                                final viewCartController = ref.watch(
                                  cartProvider,
                                );
                                final isInCart = viewCartController.isInCart(
                                  widget.buffalo['id'].toString(),
                                );

                                return GestureDetector(
                                  onTap: () {
                                    if (isInCart) {
                                      viewCartController.removeItem(
                                        widget.buffalo['id'] as String,
                                      );
                                    } else {
                                      viewCartController.addItem(
                                        widget.buffalo['id'] as String,
                                        double.tryParse(
                                              (widget.buffalo['price']
                                                      as String)
                                                  .replaceAll(
                                                    RegExp(r'[^0-9.]'),
                                                    '',
                                                  ),
                                            ) ??
                                            0.0,
                                        widget.buffalo['breed'] as String,
                                        widget.buffalo['image'] as String,
                                        widget.buffalo['sellerId'] as String? ??
                                            '',
                                      );
                                    }
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(1.w),
                                    decoration: BoxDecoration(
                                      color: isInCart
                                          ? theme.primaryColor.withOpacity(0.1)
                                          : theme.colorScheme.surface,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: isInCart
                                            ? theme.primaryColor
                                            : theme.dividerColor,
                                      ),
                                    ),
                                    child: Icon(
                                      isInCart
                                          ? Icons.shopping_cart
                                          : Icons.add_shopping_cart,
                                      size: 18,
                                      color: isInCart
                                          ? theme.primaryColor
                                          : theme.hintColor,
                                    ),
                                  ),
                                );
                              },
                            ),
                            SizedBox(width: 2.w),
                            Consumer(
                              builder: (context, ref, _) {
                                final viewCartController = ref.watch(
                                  cartProvider,
                                );
                                final isInCart = viewCartController.isInCart(
                                  widget.buffalo['id'].toString(),
                                );
                                return Text(
                                  isInCart ? 'In Cart' : 'Add to Cart',
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: isInCart
                                        ? theme.primaryColor
                                        : theme.hintColor,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              },
                            ),
                          ],
                          GestureDetector(
                            onTap: widget.onWishlistTap,
                            child: Container(
                              padding: EdgeInsets.all(1.w),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: theme.dividerColor),
                              ),
                              child: CustomIconWidget(
                                iconName: widget.buffalo['isWishlisted'] == true
                                    ? 'favorite'
                                    : 'favorite_border',
                                color: widget.buffalo['isWishlisted'] as bool
                                    ? theme.colorScheme.error
                                    : theme.hintColor,
                                size: 18,
                              ),
                            ),
                          ),
                          SizedBox(width: 2.w),
                          GestureDetector(
                            onTap: widget.onShareTap,
                            child: Container(
                              padding: EdgeInsets.all(1.w),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.surface,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(color: theme.dividerColor),
                              ),
                              child: CustomIconWidget(
                                iconName: 'share',
                                color: theme.hintColor,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  SizedBox(height: 1.h),

                  // Location
                  Row(
                    children: [
                      CustomIconWidget(
                        iconName: 'location_on',
                        color: theme.hintColor,
                        size: 16,
                      ),
                      SizedBox(width: 1.w),
                      Expanded(
                        child: Text(
                          widget.buffalo['location'] as String,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.hintColor,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Color _getHealthScoreColor(int score) {
    if (score >= 8) return AppTheme.successLight;
    if (score >= 6) return AppTheme.warningLight;
    return AppTheme.errorLight;
  }
}
