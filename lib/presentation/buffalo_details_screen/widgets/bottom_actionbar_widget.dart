import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class BottomActionBarWidget extends StatefulWidget {
  final Map<String, dynamic> buffaloData;
  final VoidCallback? onAddToCart;
  final VoidCallback? onBuyNow;

  const BottomActionBarWidget({
    Key? key,
    required this.buffaloData,
    this.onAddToCart,
    this.onBuyNow,
  }) : super(key: key);

  @override
  State<BottomActionBarWidget> createState() => _BottomActionBarWidgetState();
}

class _BottomActionBarWidgetState extends State<BottomActionBarWidget> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final String priceString = widget.buffaloData["price"] as String? ?? "₹0";
    final double price = _extractPrice(priceString);
    final double totalPrice = price * _quantity;

    return Container(
      padding: EdgeInsets.fromLTRB(4.w, 2.h, 4.w, 2.h),
      decoration: BoxDecoration(
        color: AppTheme.lightTheme.colorScheme.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Quantity and Price Row
            Row(
              children: [
                // Quantity Selector
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: AppTheme.lightTheme.colorScheme.outline.withValues(
                        alpha: 0.3,
                      ),
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: _quantity > 1
                            ? () => setState(() => _quantity--)
                            : null,
                        borderRadius: BorderRadius.circular(2.w),
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          child: CustomIconWidget(
                            iconName: 'remove',
                            color: _quantity > 1
                                ? AppTheme.lightTheme.colorScheme.primary
                                : AppTheme
                                      .lightTheme
                                      .colorScheme
                                      .onSurfaceVariant
                                      .withValues(alpha: 0.5),
                            size: 5.w,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 4.w,
                          vertical: 2.w,
                        ),
                        child: Text(
                          "$_quantity",
                          style: AppTheme.lightTheme.textTheme.titleMedium
                              ?.copyWith(
                                fontWeight: FontWeight.w600,
                                color:
                                    AppTheme.lightTheme.colorScheme.onSurface,
                              ),
                        ),
                      ),
                      InkWell(
                        onTap: _quantity < 5
                            ? () => setState(() => _quantity++)
                            : null,
                        borderRadius: BorderRadius.circular(2.w),
                        child: Container(
                          padding: EdgeInsets.all(2.w),
                          child: CustomIconWidget(
                            iconName: 'add',
                            color: _quantity < 5
                                ? AppTheme.lightTheme.colorScheme.primary
                                : AppTheme
                                      .lightTheme
                                      .colorScheme
                                      .onSurfaceVariant
                                      .withValues(alpha: 0.5),
                            size: 5.w,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(width: 4.w),

                // Price Display
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      if (_quantity > 1)
                        Text(
                          "$priceString × $_quantity",
                          style: AppTheme.lightTheme.textTheme.bodySmall
                              ?.copyWith(
                                color: AppTheme
                                    .lightTheme
                                    .colorScheme
                                    .onSurfaceVariant,
                              ),
                        ),
                      Text(
                        "₹${_formatPrice(totalPrice)}",
                        style: AppTheme.lightTheme.textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: AppTheme.lightTheme.colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: 2.h),

            // Action Buttons
            Row(
              children: [
                // Add to Cart Button
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      widget.onAddToCart?.call();
                      _showAddToCartSuccess();
                    },
                    icon: CustomIconWidget(
                      iconName: 'shopping_cart',
                      color: AppTheme.lightTheme.colorScheme.primary,
                      size: 5.w,
                    ),
                    label: Text(
                      "Add to Cart",
                      style: AppTheme.lightTheme.textTheme.titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: AppTheme.lightTheme.colorScheme.primary,
                          ),
                    ),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      side: BorderSide(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        width: 2,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: 3.w),

                // Buy Now Button
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: () {
                      widget.onBuyNow?.call();
                      _showBuyNowDialog();
                    },
                    icon: CustomIconWidget(
                      iconName: 'flash_on',
                      color: Colors.white,
                      size: 5.w,
                    ),
                    label: Text(
                      "Buy Now",
                      style: AppTheme.lightTheme.textTheme.titleMedium
                          ?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.lightTheme.colorScheme.primary,
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(3.w),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            // Quantity Limit Note
            if (_quantity >= 5)
              Padding(
                padding: EdgeInsets.only(top: 1.h),
                child: Text(
                  "Maximum 5 animals per order",
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.warningLight,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  double _extractPrice(String priceString) {
    // Extract numeric value from price string like "₹1,50,000"
    final numericString = priceString.replaceAll(RegExp(r'[^\d.]'), '');
    return double.tryParse(numericString) ?? 0.0;
  }

  String _formatPrice(double price) {
    // Format price in Indian numbering system
    if (price >= 100000) {
      return "${(price / 100000).toStringAsFixed(1)}L";
    } else if (price >= 1000) {
      return "${(price / 1000).toStringAsFixed(0)}K";
    } else {
      return price.toStringAsFixed(0);
    }
  }

  void _showAddToCartSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            CustomIconWidget(
              iconName: 'check_circle',
              color: Colors.white,
              size: 5.w,
            ),
            SizedBox(width: 2.w),
            Expanded(
              child: Text(
                "$_quantity ${widget.buffaloData["name"] ?? "Buffalo"} added to cart",
                style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        backgroundColor: AppTheme.successLight,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(2.w)),
        action: SnackBarAction(
          label: "View Cart",
          textColor: Colors.white,
          onPressed: () {
            // Navigate to cart
          },
        ),
      ),
    );
  }

  void _showBuyNowDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(3.w)),
        title: Row(
          children: [
            CustomIconWidget(
              iconName: 'shopping_bag',
              color: AppTheme.lightTheme.colorScheme.primary,
              size: 6.w,
            ),
            SizedBox(width: 2.w),
            Text(
              "Confirm Purchase",
              style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "You are about to purchase:",
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            SizedBox(height: 1.h),
            Container(
              padding: EdgeInsets.all(3.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.primary.withValues(
                  alpha: 0.05,
                ),
                borderRadius: BorderRadius.circular(2.w),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "${widget.buffaloData["name"] ?? "Buffalo"} × $_quantity",
                    style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 0.5.h),
                  Text(
                    "Total: ₹${_formatPrice(_extractPrice(widget.buffaloData["price"] as String? ?? "₹0") * _quantity)}",
                    style: AppTheme.lightTheme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w700,
                      color: AppTheme.lightTheme.colorScheme.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              _proceedToCheckout();
            },
            child: Text("Proceed to Checkout"),
          ),
        ],
      ),
    );
  }

  void _proceedToCheckout() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Proceeding to checkout..."),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }
}
