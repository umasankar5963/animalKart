import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import './widgets/buffalo_card_widget.dart';
import './widgets/featured_carousel_widget.dart';
import './widgets/filter_chips_widget.dart';
import './widgets/quick_stats_widget.dart';
import './widgets/search_header_widget.dart';

class BuyerDashboard extends StatefulWidget {
  const BuyerDashboard({super.key});

  @override
  State<BuyerDashboard> createState() => _BuyerDashboardState();
}

class _BuyerDashboardState extends State<BuyerDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int _currentTabIndex = 0;
  final String _currentLocation = 'Pune, Maharashtra';
  bool _isRefreshing = false;

  // Mock data for featured buffalo
  final List<Map<String, dynamic>> _featuredBuffalos = [
    {
      "id": 1,
      "breed": "Murrah Buffalo",
      "price": "₹1,25,000",
      "healthScore": 9,
      "image": "https://images.unsplash.com/photo-1714578305920-a1071d4d7c52",
      "semanticLabel":
          "Large black Murrah buffalo standing in green pasture with clear blue sky background",
    },
    {
      "id": 2,
      "breed": "Nili-Ravi Buffalo",
      "price": "₹98,000",
      "healthScore": 8,
      "image": "https://images.unsplash.com/photo-1676254056115-556ae538b505",
      "semanticLabel":
          "Dark brown Nili-Ravi buffalo grazing in rural farmland with traditional wooden fence",
    },
    {
      "id": 3,
      "breed": "Surti Buffalo",
      "price": "₹85,000",
      "healthScore": 8,
      "image": "https://images.unsplash.com/photo-1571039731739-84e945309cc4",
      "semanticLabel":
          "Healthy Surti buffalo with distinctive curved horns standing near water source",
    },
  ];

  // Mock data for buffalo listings
  final List<Map<String, dynamic>> _buffaloListings = [
    {
      "id": 1,
      "breed": "Murrah Buffalo",
      "age": 4,
      "price": "₹1,25,000",
      "healthScore": 9,
      "sellerRating": 4.8,
      "location": "Hisar, Haryana",
      "image": "https://images.unsplash.com/photo-1592306275697-af8c23642402",
      "semanticLabel":
          "Premium Murrah buffalo with glossy black coat standing in well-maintained farm facility",
      "isWishlisted": false,
    },
    {
      "id": 2,
      "breed": "Nili-Ravi Buffalo",
      "age": 3,
      "price": "₹98,000",
      "healthScore": 8,
      "sellerRating": 4.6,
      "location": "Faisalabad, Punjab",
      "image": "https://images.unsplash.com/photo-1693663344477-dd89e4949ed6",
      "semanticLabel":
          "Young Nili-Ravi buffalo with distinctive markings in clean barn environment",
      "isWishlisted": true,
    },
    {
      "id": 3,
      "breed": "Surti Buffalo",
      "age": 5,
      "price": "₹85,000",
      "healthScore": 7,
      "sellerRating": 4.4,
      "location": "Anand, Gujarat",
      "image": "https://images.unsplash.com/photo-1566956884148-8f1975261dfd",
      "semanticLabel":
          "Mature Surti buffalo with characteristic light brown color grazing in open field",
      "isWishlisted": false,
    },
    {
      "id": 4,
      "breed": "Jaffarabadi Buffalo",
      "age": 6,
      "price": "₹1,15,000",
      "healthScore": 8,
      "sellerRating": 4.7,
      "location": "Gir Somnath, Gujarat",
      "image": "https://images.unsplash.com/photo-1715817608669-9240050b1012",
      "semanticLabel":
          "Large Jaffarabadi buffalo with impressive build standing near traditional water trough",
      "isWishlisted": false,
    },
    {
      "id": 5,
      "breed": "Bhadawari Buffalo",
      "age": 4,
      "price": "₹75,000",
      "healthScore": 7,
      "sellerRating": 4.3,
      "location": "Etawah, Uttar Pradesh",
      "image": "https://images.unsplash.com/photo-1649187642490-c1baa69d27fa",
      "semanticLabel":
          "Compact Bhadawari buffalo with sturdy frame in rural village setting",
      "isWishlisted": false,
    },
  ];

  // Mock data for filters
  final List<Map<String, dynamic>> _filters = [
    {"key": "breed", "label": "Breed", "isSelected": false, "count": 5},
    {"key": "price", "label": "Price Range", "isSelected": false, "count": 3},
    {"key": "health", "label": "Health Score", "isSelected": false, "count": 8},
    {"key": "location", "label": "Location", "isSelected": false, "count": 12},
    {"key": "age", "label": "Age", "isSelected": false, "count": 6},
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _tabController.addListener(() {
      setState(() {
        _currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _handleRefresh() async {
    setState(() {
      _isRefreshing = true;
    });

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      _isRefreshing = false;
    });
  }

  void _handleFilterTap(String filterKey) {
    setState(() {
      final filterIndex = _filters.indexWhere(
        (filter) => filter['key'] == filterKey,
      );
      if (filterIndex != -1) {
        _filters[filterIndex]['isSelected'] =
            !_filters[filterIndex]['isSelected'];
      }
    });
  }

  void _handleBuffaloTap(Map<String, dynamic> buffalo) {
    Navigator.pushNamed(context, '/buffalo-details-screen');
  }

  void _handleWishlistTap(int buffaloId) {
    setState(() {
      final buffaloIndex = _buffaloListings.indexWhere(
        (buffalo) => buffalo['id'] == buffaloId,
      );
      if (buffaloIndex != -1) {
        _buffaloListings[buffaloIndex]['isWishlisted'] =
            !_buffaloListings[buffaloIndex]['isWishlisted'];
      }
    });
  }

  void _handleShareTap(Map<String, dynamic> buffalo) {
    // Handle share functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Sharing ${buffalo['breed']}...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handleContactTap(Map<String, dynamic> buffalo) {
    // Handle contact seller functionality
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Contacting seller for ${buffalo['breed']}...'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  Widget _buildHomeTab() {
    final theme = Theme.of(context);

    return RefreshIndicator(
      onRefresh: _handleRefresh,
      color: theme.primaryColor,
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // Featured Buffalo Carousel
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
                  child: Text(
                    'Featured Buffalo',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.titleLarge?.color,
                    ),
                  ),
                ),
                FeaturedCarouselWidget(
                  featuredBuffalos: _featuredBuffalos,
                  onBuffaloTap: _handleBuffaloTap,
                ),
              ],
            ),
          ),

          // Quick Stats
          SliverToBoxAdapter(
            child: QuickStatsWidget(
              totalBuffalos: _buffaloListings.length,
              averagePrice: '₹96,600',
              lastUpdated: '2 mins ago',
            ),
          ),

          // Filter Chips
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  child: Text(
                    'Filter by',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.titleMedium?.color,
                    ),
                  ),
                ),
                FilterChipsWidget(
                  filters: _filters,
                  onFilterTap: _handleFilterTap,
                ),
              ],
            ),
          ),

          // Buffalo Listings Header
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 2.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Available Buffalo',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: theme.textTheme.titleLarge?.color,
                    ),
                  ),
                  Text(
                    '${_buffaloListings.length} found',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.hintColor,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Buffalo Cards List
          _buffaloListings.isEmpty
              ? SliverToBoxAdapter(
                  child: Container(
                    height: 30.h,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'pets',
                          color: theme.hintColor,
                          size: 64,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'No buffalo found',
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Try adjusting your filters',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverList(
                  delegate: SliverChildBuilderDelegate((context, index) {
                    final buffalo = _buffaloListings[index];
                    return BuffaloCardWidget(
                      buffalo: buffalo,
                      onTap: () => _handleBuffaloTap(buffalo),
                      onWishlistTap: () =>
                          _handleWishlistTap(buffalo['id'] as int),
                      onShareTap: () => _handleShareTap(buffalo),
                      onContactTap: () => _handleContactTap(buffalo),
                    );
                  }, childCount: _buffaloListings.length),
                ),

          // Bottom Padding
          SliverToBoxAdapter(child: SizedBox(height: 10.h)),
        ],
      ),
    );
  }

  Widget _buildPlaceholderTab(String tabName) {
    final theme = Theme.of(context);

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomIconWidget(
            iconName: _getTabIcon(tabName),
            color: theme.hintColor,
            size: 64,
          ),
          SizedBox(height: 2.h),
          Text(
            '$tabName Coming Soon',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.hintColor,
            ),
          ),
          SizedBox(height: 1.h),
          Text(
            'This feature is under development',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.hintColor),
          ),
        ],
      ),
    );
  }

  String _getTabIcon(String tabName) {
    switch (tabName) {
      case 'Browse':
        return 'search';
      case 'Cart':
        return 'shopping_cart';
      case 'Orders':
        return 'receipt_long';
      case 'Profile':
        return 'person';
      default:
        return 'home';
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Search Header (only show on Home tab)
            if (_currentTabIndex == 0)
              SearchHeaderWidget(
                searchController: _searchController,
                currentLocation: _currentLocation,
                onNotificationTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Notifications opened'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                onLocationTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Location picker opened'),
                      duration: Duration(seconds: 1),
                    ),
                  );
                },
                onSearchChanged: (query) {
                  // Handle search functionality
                },
              ),

            // Tab Content
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildHomeTab(),
                  _buildPlaceholderTab('Browse'),
                  _buildPlaceholderTab('Cart'),
                  _buildPlaceholderTab('Orders'),
                  _buildPlaceholderTab('Profile'),
                ],
              ),
            ),
          ],
        ),
      ),

      // Bottom Navigation Bar
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppTheme.lightTheme.colorScheme.surface,
          boxShadow: [
            BoxShadow(
              color: AppTheme.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, -2),
            ),
          ],
        ),
        child: TabBar(
          controller: _tabController,
          labelColor: AppTheme.primaryLight,
          unselectedLabelColor: AppTheme.textMediumEmphasisLight,
          indicatorColor: Colors.transparent,
          labelStyle: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
          unselectedLabelStyle: AppTheme.lightTheme.textTheme.bodySmall
              ?.copyWith(fontWeight: FontWeight.w400),
          tabs: [
            Tab(
              icon: CustomIconWidget(
                iconName: 'home',
                color: _currentTabIndex == 0
                    ? AppTheme.primaryLight
                    : AppTheme.textMediumEmphasisLight,
                size: 24,
              ),
              text: 'Home',
            ),

            Tab(
              icon: CustomIconWidget(
                iconName: 'search',
                color: _currentTabIndex == 1
                    ? AppTheme.primaryLight
                    : AppTheme.textMediumEmphasisLight,
                size: 24,
              ),
              text: 'Browse',
            ),
            Tab(
              icon: CustomIconWidget(
                iconName: 'shopping_cart',
                color: _currentTabIndex == 2
                    ? AppTheme.primaryLight
                    : AppTheme.textMediumEmphasisLight,
                size: 24,
              ),
              text: 'Cart',
            ),
            Tab(
              icon: CustomIconWidget(
                iconName: 'receipt_long',
                color: _currentTabIndex == 3
                    ? AppTheme.primaryLight
                    : AppTheme.textMediumEmphasisLight,
                size: 24,
              ),
              text: 'Orders',
            ),
            Tab(
              icon: CustomIconWidget(
                iconName: 'person',
                color: _currentTabIndex == 4
                    ? AppTheme.primaryLight
                    : AppTheme.textMediumEmphasisLight,
                size: 24,
              ),
              text: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
