import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../theme/app_theme.dart';
import './widgets/app_logo_widget.dart';
import './widgets/help_support_widget.dart';
import './widgets/role_card_widget.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _lastSelectedRole;

  final List<Map<String, dynamic>> _roles = [
    {
      'title': 'Buyer',
      'description': 'Buy healthy buffalo',
      'iconName': 'shopping_cart',
      'color': AppTheme.buyerAccentLight,
      'route': '/login-screen',
    },
    {
      'title': 'SuperVisor',
      'description': 'Manage sales & orders',
      'iconName': 'supervisor_account',
      'color': AppTheme.sellerAccentLight,
      'route': '/login-screen',
    },
    {
      'title': 'Doctor',
      'description': 'Verify animal health',
      'iconName': 'medical_services',
      'color': AppTheme.doctorAccentLight,
      'route': '/login-screen',
    },
    {
      'title': 'Transport',
      'description': 'Manage deliveries',
      'iconName': 'local_shipping',
      'color': AppTheme.transportAccentLight,
      'route': '/login-screen',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadLastSelectedRole();
  }

  Future<void> _loadLastSelectedRole() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastRole = prefs.getString('last_selected_role');
      if (lastRole != null) {
        setState(() {
          _lastSelectedRole = lastRole;
        });
      }
    } catch (e) {
      // Handle error silently
    }
  }

  Future<void> _saveSelectedRole(String role) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('last_selected_role', role);
    } catch (e) {
      // Handle error silently
    }
  }

  void _handleRoleSelection(String role, String route) {
    HapticFeedback.mediumImpact();
    _saveSelectedRole(role);

    // Navigate to login screen with role parameter
    Navigator.pushNamed(
      context,
      route,
      arguments: {'role': role.toLowerCase()},
    );
  }

  void _handleGuestBrowse() {
    HapticFeedback.lightImpact();
    Navigator.pushNamed(
      context,
      '/buyer-dashboard',
      arguments: {'isGuest': true},
    );
  }

  Future<bool> _onWillPop() async {
    // Exit app confirmation
    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              'Exit AnimalKart',
              style: AppTheme.lightTheme.textTheme.titleLarge,
            ),
            content: Text(
              'Are you sure you want to exit the app?',
              style: AppTheme.lightTheme.textTheme.bodyMedium,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.of(context).pop(true),
                child: Text('Exit'),
              ),
            ],
          ),
        ) ??
        false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: AppTheme.lightTheme.scaffoldBackgroundColor,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 6),
              child: Column(
                children: [
                  SizedBox(height: 4),

                  // App Logo and Title
                  const AppLogoWidget(),

                  SizedBox(height: 6),

                  // Role Selection Title
                  Text(
                    'Choose Your Role',
                    style: AppTheme.lightTheme.textTheme.headlineSmall
                        ?.copyWith(
                          color: AppTheme.lightTheme.colorScheme.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                  ),

                  SizedBox(height: 1),

                  Text(
                    'Select how you want to use AnimalKart',
                    style: AppTheme.lightTheme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.lightTheme.colorScheme.onSurface
                          .withValues(alpha: 0.7),
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 4),

                  // Role Cards Grid
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 6,
                      childAspectRatio: 0.85,
                    ),
                    itemCount: _roles.length,
                    itemBuilder: (context, index) {
                      final role = _roles[index];
                      final isSelected = _lastSelectedRole == role['title'];

                      return RoleCardWidget(
                        title: role['title'],
                        description: role['description'],
                        iconName: role['iconName'],
                        roleColor: role['color'],
                        isSelected: isSelected,
                        onTap: () =>
                            _handleRoleSelection(role['title'], role['route']),
                      );
                    },
                  ),

                  SizedBox(height: 4),

                  // Guest Browse Option
                  // GuestBrowseWidget(onTap: _handleGuestBrowse),
                  SizedBox(height: 4),

                  // Help and Language Support
                  const HelpSupportWidget(),

                  SizedBox(height: 2),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
