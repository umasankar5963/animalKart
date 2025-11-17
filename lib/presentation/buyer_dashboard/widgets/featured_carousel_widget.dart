import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:animal_kart/widgets/custom_Image_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class FeaturedCarouselWidget extends StatefulWidget {
  final List<Map<String, dynamic>> featuredBuffalos;
  final Function(Map<String, dynamic>) onBuffaloTap;

  const FeaturedCarouselWidget({
    Key? key,
    required this.featuredBuffalos,
    required this.onBuffaloTap,
  }) : super(key: key);

  @override
  State<FeaturedCarouselWidget> createState() => _FeaturedCarouselWidgetState();
}

class _FeaturedCarouselWidgetState extends State<FeaturedCarouselWidget> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30.h,
      child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemCount: widget.featuredBuffalos.length,
              itemBuilder: (context, index) {
                final buffalo = widget.featuredBuffalos[index];
                return GestureDetector(
                  onTap: () => widget.onBuffaloTap(buffalo),
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 2.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppTheme.shadowLight,
                          blurRadius: 12,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Stack(
                        children: [
                          // Background Image
                          CustomImageWidget(
                            imageUrl: buffalo['image'] as String,
                            width: double.infinity,
                            height: double.infinity,
                            fit: BoxFit.cover,
                            semanticLabel: buffalo['semanticLabel'] as String,
                          ),

                          // Gradient Overlay
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withValues(alpha: 0.7),
                                ],
                              ),
                            ),
                          ),

                          // Featured Badge
                          Positioned(
                            top: 2.h,
                            left: 4.w,
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 3.w,
                                vertical: 1.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.sellerAccentLight,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  CustomIconWidget(
                                    iconName: 'star',
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                  SizedBox(width: 1.w),
                                  Text(
                                    'Featured',
                                    style: AppTheme
                                        .lightTheme
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          // Buffalo Info
                          Positioned(
                            bottom: 2.h,
                            left: 4.w,
                            right: 4.w,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  buffalo['breed'] as String,
                                  style: AppTheme
                                      .lightTheme
                                      .textTheme
                                      .titleLarge
                                      ?.copyWith(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w700,
                                      ),
                                ),
                                SizedBox(height: 0.5.h),
                                Row(
                                  children: [
                                    Text(
                                      buffalo['price'] as String,
                                      style: AppTheme
                                          .lightTheme
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(
                                            color: Colors.white,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                    SizedBox(width: 4.w),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 2.w,
                                        vertical: 0.5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withValues(
                                          alpha: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          CustomIconWidget(
                                            iconName: 'favorite',
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                          SizedBox(width: 1.w),
                                          Text(
                                            '${buffalo['healthScore']}/10',
                                            style: AppTheme
                                                .lightTheme
                                                .textTheme
                                                .bodySmall
                                                ?.copyWith(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ],
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
                  ),
                );
              },
            ),
          ),

          SizedBox(height: 1.h),

          // Page Indicators
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              widget.featuredBuffalos.length,
              (index) => Container(
                margin: EdgeInsets.symmetric(horizontal: 1.w),
                width: _currentIndex == index ? 8.w : 2.w,
                height: 1.h,
                decoration: BoxDecoration(
                  color: _currentIndex == index
                      ? AppTheme.primaryLight
                      : AppTheme.textDisabledLight,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
