import 'package:animal_kart/theme/app_theme.dart';
import 'package:animal_kart/widgets/customIcon_widget.dart';
import 'package:animal_kart/widgets/theme_switch.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

import './widgets/buffalo_listing_card.dart';
import './widgets/buyer_inquiry_card.dart';
import './widgets/empty_state_widget.dart';
import './widgets/quick_stats_card.dart';

class SellerDashboard extends StatefulWidget {
  const SellerDashboard({Key? key}) : super(key: key);

  @override
  State<SellerDashboard> createState() => _SellerDashboardState();
}

class _SellerDashboardState extends State<SellerDashboard>
    with TickerProviderStateMixin {
  late TabController _tabController;
  String _selectedFilter = 'All';
  bool _isRefreshing = false;

  // Mock data for buffalo listings
  final List<Map<String, dynamic>> _buffaloListings = [
    {
      "id": 1,
      "breed": "Murrah Buffalo",
      "price": "₹85,000",
      "status": "Active",
      "views": 245,
      "inquiries": 12,
      "image": "https://images.unsplash.com/photo-1714578305920-a1071d4d7c52",
      "semanticLabel":
          "Black Murrah buffalo standing in green pasture with clear blue sky background",
    },
    {
      "id": 2,
      "breed": "Nili-Ravi Buffalo",
      "price": "₹92,000",
      "status": "Pending Approval",
      "views": 156,
      "inquiries": 8,
      "image": "https://images.unsplash.com/photo-1723974282359-b5fec3634e6a",
      "semanticLabel":
          "Large dark buffalo with curved horns grazing in rural farmland setting",
    },
    {
      "id": 3,
      "breed": "Surti Buffalo",
      "price": "₹78,000",
      "status": "Sold",
      "views": 189,
      "inquiries": 15,
      "image": "https://images.unsplash.com/photo-1727897318344-1a0cd059ded8",
      "semanticLabel":
          "Brown Surti buffalo with distinctive markings standing near water source",
    },
  ];

  // Mock data for buyer inquiries
  final List<Map<String, dynamic>> _buyerInquiries = [
    {
      "id": 1,
      "buyerName": "Rajesh Kumar",
      "buyerAvatar":
          "https://img.rocket.new/generatedImages/rocket_gen_img_1aac31f10-1762274345319.png",
      "buyerAvatarLabel":
          "Profile photo of middle-aged Indian man with mustache wearing white shirt",
      "buffaloBreed": "Murrah Buffalo",
      "message": "Interested in purchasing. Can we discuss price?",
      "time": "2 hours ago",
      "isUnread": true,
    },
    {
      "id": 2,
      "buyerName": "Priya Sharma",
      "buyerAvatar":
          "https://images.unsplash.com/photo-1631268088758-3e1fe5346e0c",
      "buyerAvatarLabel":
          "Profile photo of young Indian woman with long black hair wearing traditional dress",
      "buffaloBreed": "Nili-Ravi Buffalo",
      "message": "Looking for healthy buffalo for dairy farming",
      "time": "5 hours ago",
      "isUnread": false,
    },
    {
      "id": 3,
      "buyerName": "Amit Patel",
      "buyerAvatar":
          "https://images.unsplash.com/photo-1635341542289-d0307ddd5928",
      "buyerAvatarLabel":
          "Profile photo of elderly Indian man with gray beard wearing casual shirt",
      "buffaloBreed": "Surti Buffalo",
      "message": "Can you provide health certificates?",
      "time": "1 day ago",
      "isUnread": true,
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
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

  List<Map<String, dynamic>> _getFilteredListings() {
    if (_selectedFilter == 'All') {
      return _buffaloListings;
    }
    return _buffaloListings
        .where((buffalo) => buffalo['status'] == _selectedFilter)
        .toList();
  }

  int _getUnreadInquiriesCount() {
    return _buyerInquiries
        .where((inquiry) => inquiry['isUnread'] == true)
        .length;
  }

  void _showDeleteConfirmation(Map<String, dynamic> buffalo) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete Listing'),
          content: Text(
            'Are you sure you want to delete ${buffalo['breed']} listing?',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  _buffaloListings.removeWhere(
                    (item) => item['id'] == buffalo['id'],
                  );
                });
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Listing deleted successfully')),
                );
              },
              child: Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Widget _buildTabContent(int index) {
    switch (index) {
      case 0: // Listings
        return _buildListingsTab();
      case 1: // Orders
        return _buildOrdersTab();
      case 2: // Analytics
        return _buildAnalyticsTab();
      case 3: // Profile
        return _buildProfileTab();
      default:
        return const Center(child: Text('Coming Soon'));
    }
  }

  Widget _buildListingsTab() {
    final filteredListings = _getFilteredListings();

    return Column(
      children: [
        // Filter Chips
        Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          height: 6.h,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              _buildFilterChip('All'),
              SizedBox(width: 2.w),
              _buildFilterChip('Active'),
              SizedBox(width: 2.w),
              _buildFilterChip('Pending'),
              SizedBox(width: 2.w),
              _buildFilterChip('Sold'),
            ],
          ),
        ),
        // Listings
        Expanded(
          child: RefreshIndicator(
            onRefresh: _handleRefresh,
            color: Theme.of(context).primaryColor,
            child: filteredListings.isEmpty
                ? Center(
                    child: Text(
                      'No listings found',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.only(
                      bottom: 8.h,
                    ), // Space for bottom navigation
                    itemCount: filteredListings.length,
                    itemBuilder: (context, index) {
                      final buffalo = filteredListings[index];
                      return BuffaloListingCard(
                        buffalo: buffalo,
                        onTap: () {},
                        onDelete: () => _showDeleteConfirmation(buffalo),
                        onEdit: () {},
                        onPromote: () {},
                        onMarkSold: () {
                          setState(() {
                            buffalo['status'] = 'Sold';
                          });
                        },
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  Widget _buildFilterChip(String label) {
    final isSelected = _selectedFilter == label;
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (selected) {
        setState(() {
          _selectedFilter = selected ? label : 'All';
        });
      },
      backgroundColor: Theme.of(context).colorScheme.surface,
      selectedColor: Theme.of(context).primaryColor.withOpacity(0.2),
      labelStyle: TextStyle(
        color: isSelected
            ? Theme.of(context).primaryColor
            : Theme.of(context).textTheme.bodyLarge?.color,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: isSelected
              ? Theme.of(context).primaryColor
              : Theme.of(context).dividerColor,
        ),
      ),
    );
  }

  Widget _buildOrdersTab() {
    return const Center(child: Text('Orders Tab'));
  }

  Widget _buildAnalyticsTab() {
    return const Center(child: Text('Analytics Tab'));
  }

  Widget _buildProfileTab() {
    return const Center(child: Text('Profile Tab'));
  }

  @override
  Widget build(BuildContext context) {
    final unreadCount = _getUnreadInquiriesCount();
    final filteredListings = _getFilteredListings();

    return Scaffold(
      backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.all(4.w),
              decoration: BoxDecoration(
                color: AppTheme.lightTheme.colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Green Valley Farm',
                            style: AppTheme.lightTheme.textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w700),
                          ),
                          Text(
                            '${_buffaloListings.where((b) => b['status'] == 'Active').length} Active Listings',
                            style: AppTheme.lightTheme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.grey[600]),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Theme Toggle
                          const ThemeSwitch(),
                          SizedBox(width: 2.w),
                          // Notification Bell
                          Stack(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: CustomIconWidget(
                                  iconName: 'notifications',
                                  size: 24,
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurface,
                                ),
                              ),
                              if (unreadCount > 0)
                                Positioned(
                                  right: 8,
                                  top: 8,
                                  child: Container(
                                    padding: EdgeInsets.all(1.w),
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 4.w,
                                      minHeight: 4.w,
                                    ),
                                    child: Text(
                                      unreadCount.toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 2.h),
                      // Quick Stats
                      Row(
                        children: [
                          Expanded(
                            child: QuickStatsCard(
                              title: 'Pending Orders',
                              value: '3',
                              trend: '+2',
                              isPositive: true,
                              icon: Icons.pending_actions,
                              backgroundColor: Colors.orange,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: QuickStatsCard(
                              title: 'Total Revenue',
                              value: '₹2.4L',
                              trend: '+15%',
                              isPositive: true,
                              icon: Icons.currency_rupee,
                              backgroundColor: Colors.green,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Expanded(
                            child: QuickStatsCard(
                              title: 'Active Buffalo',
                              value:
                                  '${_buffaloListings.where((b) => b['status'] == 'Active').length}',
                              trend: '+1',
                              isPositive: true,
                              icon: Icons.pets,
                              backgroundColor:
                                  AppTheme.lightTheme.colorScheme.primary,
                            ),
                          ),
                        ],
                      ),

                      // Tab Bar with TabBarView
                      Expanded(
                        child: Column(
                          children: [
                            Container(
                              color: Theme.of(context).colorScheme.surface,
                              child: TabBar(
                                controller: _tabController,
                                indicatorColor: Theme.of(context).primaryColor,
                                labelColor: Theme.of(context).primaryColor,
                                unselectedLabelColor: Theme.of(
                                  context,
                                ).hintColor,
                                tabs: const [
                                  Tab(
                                    icon: Icon(Icons.list_alt),
                                    text: 'Listings',
                                  ),
                                  Tab(
                                    icon: Icon(Icons.shopping_cart),
                                    text: 'Orders',
                                  ),
                                  Tab(
                                    icon: Icon(Icons.analytics),
                                    text: 'Analytics',
                                  ),
                                  Tab(
                                    icon: Icon(Icons.person),
                                    text: 'Profile',
                                  ),
                                ],
                              ),
                            ),
                            // Tab content
                            Expanded(
                              child: TabBarView(
                                controller: _tabController,
                                children: [
                                  // Listings Tab
                                  _buildListingsTab(),
                                  // Orders Tab
                                  _buildOrdersTab(),
                                  // Analytics Tab
                                  _buildAnalyticsTab(),
                                  // Profile Tab
                                  _buildProfileTab(),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(4.w),
                        child: Row(
                          children: [
                            Text(
                              'Filter:',
                              style: AppTheme.lightTheme.textTheme.bodyMedium
                                  ?.copyWith(fontWeight: FontWeight.w500),
                            ),
                            SizedBox(width: 2.w),
                            Expanded(
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children:
                                      [
                                            'All',
                                            'Active',
                                            'Pending Approval',
                                            'Sold',
                                          ]
                                          .map(
                                            (filter) => Padding(
                                              padding: EdgeInsets.only(
                                                right: 2.w,
                                              ),
                                              child: FilterChip(
                                                label: Text(filter),
                                                selected:
                                                    _selectedFilter == filter,
                                                onSelected: (selected) {
                                                  setState(() {
                                                    _selectedFilter = filter;
                                                  });
                                                },
                                              ),
                                            ),
                                          )
                                          .toList(),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      // Listings Content
                      Expanded(
                        child: filteredListings.isEmpty
                            ? EmptyStateWidget(
                                onAddBuffalo: () {
                                  // Navigate to add buffalo screen
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                        'Add Buffalo screen will open',
                                      ),
                                    ),
                                  );
                                },
                              )
                            : RefreshIndicator(
                                onRefresh: _handleRefresh,
                                child: ListView.builder(
                                  itemCount: filteredListings.length,
                                  itemBuilder: (context, index) {
                                    final buffalo = filteredListings[index];
                                    return BuffaloListingCard(
                                      buffalo: buffalo,
                                      onTap: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Opening ${buffalo['breed']} details',
                                            ),
                                          ),
                                        );
                                      },
                                      onEdit: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Edit ${buffalo['breed']}',
                                            ),
                                          ),
                                        );
                                      },
                                      onPromote: () {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Promote ${buffalo['breed']}',
                                            ),
                                          ),
                                        );
                                      },
                                      onMarkSold: () {
                                        setState(() {
                                          buffalo['status'] = 'Sold';
                                        });
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              '${buffalo['breed']} marked as sold',
                                            ),
                                          ),
                                        );
                                      },
                                      onDelete: () =>
                                          _showDeleteConfirmation(buffalo),
                                    );
                                  },
                                ),
                              ),
                      ),
                      // Recent Buyer Inquiries
                      if (filteredListings.isNotEmpty) ...[
                        Container(
                          padding: EdgeInsets.all(4.w),
                          decoration: BoxDecoration(
                            color: AppTheme.lightTheme.colorScheme.surface,
                            border: Border(
                              top: BorderSide(
                                color: Colors.grey.withValues(alpha: 0.2),
                                width: 1,
                              ),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Recent Inquiries',
                                    style: AppTheme
                                        .lightTheme
                                        .textTheme
                                        .titleMedium
                                        ?.copyWith(fontWeight: FontWeight.w600),
                                  ),
                                  if (unreadCount > 0)
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 2.w,
                                        vertical: 0.5.h,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Text(
                                        '$unreadCount new',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10.sp,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(height: 2.h),
                              SizedBox(
                                height: 25.h,
                                child: ListView.builder(
                                  itemCount: _buyerInquiries.length,
                                  itemBuilder: (context, index) {
                                    final inquiry = _buyerInquiries[index];
                                    return BuyerInquiryCard(
                                      inquiry: inquiry,
                                      onTap: () {
                                        setState(() {
                                          inquiry['isUnread'] = false;
                                        });
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              'Opening inquiry from ${inquiry['buyerName']}',
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ],
                  ),
                  // Orders Tab
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'shopping_cart',
                          size: 64,
                          color: Colors.grey[400]!,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Orders Management',
                          style: AppTheme.lightTheme.textTheme.headlineSmall,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Track and manage your buffalo orders',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  // Analytics Tab
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'analytics',
                          size: 64,
                          color: Colors.grey[400]!,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Sales Analytics',
                          style: AppTheme.lightTheme.textTheme.headlineSmall,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'View your sales performance and insights',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                  // Profile Tab
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomIconWidget(
                          iconName: 'person',
                          size: 64,
                          color: Colors.grey[400]!,
                        ),
                        SizedBox(height: 2.h),
                        Text(
                          'Profile Management',
                          style: AppTheme.lightTheme.textTheme.headlineSmall,
                        ),
                        SizedBox(height: 1.h),
                        Text(
                          'Manage your farm profile and settings',
                          style: AppTheme.lightTheme.textTheme.bodyMedium
                              ?.copyWith(color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _tabController.index == 0
          ? FloatingActionButton.extended(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Add New Buffalo screen will open'),
                  ),
                );
              },
              icon: CustomIconWidget(
                iconName: 'camera_alt',
                size: 20,
                color: Colors.white,
              ),
              label: Text('Add Buffalo'),
              backgroundColor: AppTheme.lightTheme.colorScheme.primary,
            )
          : null,
    );
  }
}
