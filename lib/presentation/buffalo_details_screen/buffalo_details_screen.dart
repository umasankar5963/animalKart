import 'package:animal_kart/presentation/buffalo_details_screen/widgets/aiInsights_widget.dart'
    show AiInsightsWidget;
import 'package:animal_kart/presentation/buffalo_details_screen/widgets/bottom_actionbar_widget.dart';
import 'package:animal_kart/presentation/buffalo_details_screen/widgets/buffaloImage_gallery_widget.dart';
import 'package:animal_kart/presentation/buffalo_details_screen/widgets/buffalo_Infocard_widget.dart';
import 'package:animal_kart/presentation/buffalo_details_screen/widgets/sellerInfo_widget.dart';
import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import './widgets/additional_details_widget.dart';

import './widgets/health_certificate_widget.dart';

class BuffaloDetailsScreen extends StatefulWidget {
  const BuffaloDetailsScreen({Key? key}) : super(key: key);

  @override
  State<BuffaloDetailsScreen> createState() => _BuffaloDetailsScreenState();
}

class _BuffaloDetailsScreenState extends State<BuffaloDetailsScreen> {
  bool _isWishlisted = false;
  bool _isLoading = true;
  late Map<String, dynamic> _buffaloData;

  @override
  void initState() {
    super.initState();
    _loadBuffaloData();
  }

  void _loadBuffaloData() {
    // Simulate loading data
    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() {
        _isLoading = false;
        _buffaloData = _getMockBuffaloData();
      });
    });
  }

  Map<String, dynamic> _getMockBuffaloData() {
    return {
      "id": "BUF001",
      "name": "Premium Murrah Buffalo",
      "breed": "Murrah",
      "age": 4,
      "weight": 550,
      "gender": "Female",
      "milkYield": 15,
      "price": "₹1,50,000",
      "images": [
        "https://images.pexels.com/photos/422218/pexels-photo-422218.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "https://images.pexels.com/photos/1108099/pexels-photo-1108099.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "https://images.pexels.com/photos/1108101/pexels-photo-1108101.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
        "https://images.pexels.com/photos/1108102/pexels-photo-1108102.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1",
      ],
      "imageSemanticLabels": [
        "Large black Murrah buffalo standing in green pasture with clear blue sky background",
        "Close-up side view of healthy Murrah buffalo showing distinctive curved horns and robust build",
        "Murrah buffalo grazing peacefully in lush green field during golden hour lighting",
        "Full body shot of premium Murrah buffalo displaying excellent body conformation and health",
      ],
      "seller": {
        "name": "Rajesh Kumar",
        "farmName": "Green Valley Farm",
        "location": "Hisar, Haryana",
        "rating": 4.8,
        "animalsSold": 127,
        "experience": 12,
        "phone": "+91 98765 43210",
        "totalAnimals": 45,
        "avatar":
            "https://images.unsplash.com/photo-1719593622919-70d3e620e8fb",
        "avatarSemanticLabel":
            "Middle-aged Indian farmer in traditional white kurta standing confidently in front of farm buildings",
      },
      "aiInsights": {
        "healthScore": 0.92,
        "breedingScore": 0.88,
        "marketScore": 0.85,
        "healthPrediction":
            "Excellent health with strong immunity. Regular milk production expected for next 5-6 years.",
        "breedingPotential":
            "High breeding potential with proven genetics. Suitable for producing quality offspring.",
        "marketAnalysis":
            "Above market value due to superior breed quality and health status. Good investment potential.",
        "recommendation":
            "Highly recommended for dairy farming and breeding purposes. Expected ROI of 25-30% annually.",
        "recommendationLevel": "high",
      },
      "healthCertificate": {
        "isVerified": true,
        "status": "verified",
        "certificateId": "HC2024001234",
        "issuedBy": "Dr. Suresh Veterinary Clinic",
        "issueDate": "15 Oct 2024",
        "validUntil": "15 Oct 2025",
        "fitForBreeding": true,
        "transportReady": true,
        "certificateImage":
            "https://via.placeholder.com/400x600/E8F5E8/2E7D32?text=Health+Certificate",
      },
      "additionalDetails": {
        "vaccinations": [
          {
            "name": "FMD Vaccine",
            "date": "10 Sep 2024",
            "description":
                "Foot and Mouth Disease vaccination completed successfully",
          },
          {
            "name": "Brucellosis Vaccine",
            "date": "25 Aug 2024",
            "description": "Brucellosis prevention vaccine administered",
          },
          {
            "name": "Anthrax Vaccine",
            "date": "15 Jul 2024",
            "description": "Annual anthrax vaccination completed",
          },
        ],
        "feeding": {
          "dailyFeed": 25,
          "feedType": "Green Fodder + Concentrate",
          "waterIntake": 80,
          "schedule": "3 times daily (6 AM, 12 PM, 6 PM)",
          "specialDiet":
              "High protein concentrate mix for enhanced milk production. Includes mineral supplements and vitamins.",
        },
        "transport": {
          "mode": "Specialized Livestock Truck",
          "estimatedTime": "2-3 days",
          "cost": "₹5,000 - ₹8,000",
          "insurance": "Full transport insurance included",
          "instructions":
              "Requires climate-controlled transport with regular feeding stops every 4 hours. Veterinary supervision recommended for long distances.",
        },
      },
    };
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        body: _buildLoadingState(),
      );
    }

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: Column(
        children: [
          // Custom Header
          _buildCustomHeader(),

          // Scrollable Content
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Image Gallery
                  BuffaloImageGalleryWidget(
                    images: (_buffaloData["images"] as List).cast<String>(),
                    semanticLabels:
                        (_buffaloData["imageSemanticLabels"] as List)
                            .cast<String>(),
                  ),

                  SizedBox(height: 2.h),

                  // Buffalo Info Card
                  BuffaloInfoCardWidget(buffaloData: _buffaloData),

                  SizedBox(height: 1.h),

                  // AI Insights
                  AiInsightsWidget(
                    aiInsights:
                        _buffaloData["aiInsights"] as Map<String, dynamic>,
                  ),

                  SizedBox(height: 1.h),

                  // Health Certificate
                  HealthCertificateWidget(
                    healthData:
                        _buffaloData["healthCertificate"]
                            as Map<String, dynamic>,
                  ),

                  SizedBox(height: 1.h),

                  // Seller Information
                  SellerInfoWidget(
                    sellerData: _buffaloData["seller"] as Map<String, dynamic>,
                  ),

                  SizedBox(height: 1.h),

                  // Additional Details
                  AdditionalDetailsWidget(
                    additionalData:
                        _buffaloData["additionalDetails"]
                            as Map<String, dynamic>,
                  ),

                  // Bottom padding for action bar
                  SizedBox(height: 12.h),
                ],
              ),
            ),
          ),
        ],
      ),

      // Bottom Action Bar
      bottomNavigationBar: BottomActionBarWidget(
        buffaloData: _buffaloData,
        onAddToCart: _handleAddToCart,
        onBuyNow: _handleBuyNow,
      ),
    );
  }

  Widget _buildLoadingState() {
    return Column(
      children: [
        // Loading Header
        SafeArea(
          child: Container(
            padding: EdgeInsets.all(4.w),
            child: Row(
              children: [
                Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                const Spacer(),
                Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
                SizedBox(width: 3.w),
                Container(
                  width: 10.w,
                  height: 10.w,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(2.w),
                  ),
                ),
              ],
            ),
          ),
        ),

        // Loading Image
        Container(
          height: 40.h,
          width: double.infinity,
          color: AppTheme.lightTheme.colorScheme.onSurfaceVariant.withValues(
            alpha: 0.1,
          ),
          child: Center(
            child: CircularProgressIndicator(
              color: AppTheme.lightTheme.colorScheme.primary,
            ),
          ),
        ),

        SizedBox(height: 2.h),

        // Loading Content
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w),
            child: Column(
              children: [
                // Loading Card
                Container(
                  height: 20.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                ),
                SizedBox(height: 2.h),
                Container(
                  height: 15.h,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant
                        .withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(3.w),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCustomHeader() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(4.w),
        child: Row(
          children: [
            // Back Button
            InkWell(
              onTap: () => Navigator.pop(context),
              borderRadius: BorderRadius.circular(2.w),
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(2.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CustomIconWidget(
                  iconName: 'arrow_back',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 6.w,
                ),
              ),
            ),

            const Spacer(),

            // Share Button
            InkWell(
              onTap: _handleShare,
              borderRadius: BorderRadius.circular(2.w),
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(2.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CustomIconWidget(
                  iconName: 'share',
                  color: AppTheme.lightTheme.colorScheme.onSurface,
                  size: 6.w,
                ),
              ),
            ),

            SizedBox(width: 3.w),

            // Wishlist Button
            InkWell(
              onTap: _toggleWishlist,
              borderRadius: BorderRadius.circular(2.w),
              child: Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  color: _isWishlisted
                      ? AppTheme.lightTheme.colorScheme.primary.withValues(
                          alpha: 0.1,
                        )
                      : AppTheme.lightTheme.colorScheme.surface,
                  borderRadius: BorderRadius.circular(2.w),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: CustomIconWidget(
                  iconName: _isWishlisted ? 'favorite' : 'favorite_border',
                  color: _isWishlisted
                      ? AppTheme.lightTheme.colorScheme.primary
                      : AppTheme.lightTheme.colorScheme.onSurface,
                  size: 6.w,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _toggleWishlist() {
    setState(() {
      _isWishlisted = !_isWishlisted;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isWishlisted ? "Added to wishlist" : "Removed from wishlist",
        ),
        backgroundColor: _isWishlisted
            ? AppTheme.successLight
            : AppTheme.lightTheme.colorScheme.onSurface,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void _handleShare() {
    final String shareText =
        """
🐃 ${_buffaloData["name"]} - ${_buffaloData["breed"]}
💰 Price: ${_buffaloData["price"]}
📍 Location: ${(_buffaloData["seller"] as Map)["location"]}
⭐ Seller Rating: ${(_buffaloData["seller"] as Map)["rating"]}/5

Check out this premium buffalo on AnimalKart!
""";

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Sharing buffalo details..."),
        backgroundColor: AppTheme.lightTheme.colorScheme.primary,
      ),
    );
  }

  void _handleAddToCart() {
    // Handle add to cart logic
    print("Added to cart: ${_buffaloData["name"]}");
  }

  void _handleBuyNow() {
    // Handle buy now logic
    print("Buy now: ${_buffaloData["name"]}");
  }
}
