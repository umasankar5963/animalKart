import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AiInsightsWidget extends StatefulWidget {
  final Map<String, dynamic> aiInsights;

  const AiInsightsWidget({Key? key, required this.aiInsights})
    : super(key: key);

  @override
  State<AiInsightsWidget> createState() => _AiInsightsWidgetState();
}

class _AiInsightsWidgetState extends State<AiInsightsWidget> {
  bool _isExpanded = false;

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
          // Header
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            borderRadius: BorderRadius.circular(3.w),
            child: Container(
              padding: EdgeInsets.all(4.w),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(2.w),
                    decoration: BoxDecoration(
                      color: AppTheme.buyerAccentLight.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(2.w),
                    ),
                    child: CustomIconWidget(
                      iconName: 'psychology',
                      color: AppTheme.buyerAccentLight,
                      size: 6.w,
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "AI Insights",
                          style: AppTheme.lightTheme.textTheme.titleLarge
                              ?.copyWith(
                                fontWeight: FontWeight.w700,
                                color:
                                    AppTheme.lightTheme.colorScheme.onSurface,
                              ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          "Smart analysis & predictions",
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
                    iconName: _isExpanded ? 'expand_less' : 'expand_more',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 6.w,
                  ),
                ],
              ),
            ),
          ),

          // Expandable Content
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: _isExpanded ? null : 0,
            child: _isExpanded
                ? _buildExpandedContent()
                : const SizedBox.shrink(),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandedContent() {
    return Container(
      padding: EdgeInsets.fromLTRB(4.w, 0, 4.w, 4.w),
      child: Column(
        children: [
          // Health Prediction
          _buildInsightCard(
            title: "Health Prediction",
            score:
                (widget.aiInsights["healthScore"] as num?)?.toDouble() ?? 0.0,
            description:
                widget.aiInsights["healthPrediction"] as String? ??
                "No health data available",
            icon: 'favorite',
            color: AppTheme.successLight,
          ),

          SizedBox(height: 2.h),

          // Breeding Potential
          _buildInsightCard(
            title: "Breeding Potential",
            score:
                (widget.aiInsights["breedingScore"] as num?)?.toDouble() ?? 0.0,
            description:
                widget.aiInsights["breedingPotential"] as String? ??
                "No breeding data available",
            icon: 'pets',
            color: AppTheme.lightTheme.colorScheme.primary,
          ),

          SizedBox(height: 2.h),

          // Market Value Analysis
          _buildInsightCard(
            title: "Market Value Analysis",
            score:
                (widget.aiInsights["marketScore"] as num?)?.toDouble() ?? 0.0,
            description:
                widget.aiInsights["marketAnalysis"] as String? ??
                "No market data available",
            icon: 'trending_up',
            color: AppTheme.sellerAccentLight,
          ),

          SizedBox(height: 2.h),

          // Investment Recommendation
          Container(
            padding: EdgeInsets.all(3.w),
            decoration: BoxDecoration(
              color: _getRecommendationColor().withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(2.w),
              border: Border.all(
                color: _getRecommendationColor().withValues(alpha: 0.3),
                width: 1,
              ),
            ),
            child: Row(
              children: [
                CustomIconWidget(
                  iconName: _getRecommendationIcon(),
                  color: _getRecommendationColor(),
                  size: 5.w,
                ),
                SizedBox(width: 3.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Investment Recommendation",
                        style: AppTheme.lightTheme.textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                              color: _getRecommendationColor(),
                            ),
                      ),
                      SizedBox(height: 0.5.h),
                      Text(
                        widget.aiInsights["recommendation"] as String? ??
                            "No recommendation available",
                        style: AppTheme.lightTheme.textTheme.bodyMedium
                            ?.copyWith(
                              color: AppTheme.lightTheme.colorScheme.onSurface,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard({
    required String title,
    required double score,
    required String description,
    required String icon,
    required Color color,
  }) {
    return Container(
      padding: EdgeInsets.all(3.w),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(2.w),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CustomIconWidget(iconName: icon, color: color, size: 5.w),
              SizedBox(width: 2.w),
              Expanded(
                child: Text(
                  title,
                  style: AppTheme.lightTheme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppTheme.lightTheme.colorScheme.onSurface,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 2.w, vertical: 0.5.h),
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(1.5.w),
                ),
                child: Text(
                  "${(score * 10).toInt()}/10",
                  style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 1.h),

          // Progress Bar
          Container(
            height: 0.8.h,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(0.4.h),
            ),
            child: FractionallySizedBox(
              alignment: Alignment.centerLeft,
              widthFactor: score,
              child: Container(
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(0.4.h),
                ),
              ),
            ),
          ),

          SizedBox(height: 1.h),

          Text(
            description,
            style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }

  Color _getRecommendationColor() {
    final recommendation =
        widget.aiInsights["recommendationLevel"] as String? ?? "medium";
    switch (recommendation.toLowerCase()) {
      case "high":
        return AppTheme.successLight;
      case "low":
        return AppTheme.errorLight;
      default:
        return AppTheme.warningLight;
    }
  }

  String _getRecommendationIcon() {
    final recommendation =
        widget.aiInsights["recommendationLevel"] as String? ?? "medium";
    switch (recommendation.toLowerCase()) {
      case "high":
        return "thumb_up";
      case "low":
        return "thumb_down";
      default:
        return "help";
    }
  }
}
