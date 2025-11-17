import 'package:flutter/material.dart';
import '../presentation/seller_dashboard/seller_dashboard.dart';
import '../presentation/splash_screen/splash_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/buffalo_details_screen/buffalo_details_screen.dart';
import '../presentation/role_selection_screen/role_selection_screen.dart';
import '../presentation/buyer_dashboard/buyer_dashboard.dart';

class AppRoutes {
  // TODO: Add your routes here
  static const String initial = '/';
  static const String sellerDashboard = '/supervisor-dashboard';
  static const String splash = '/splash-screen';
  static const String login = '/login-screen';
  static const String buffaloDetails = '/buffalo-details-screen';
  static const String roleSelection = '/role-selection-screen';
  static const String buyerDashboard = '/buyer-dashboard';

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    sellerDashboard: (context) => const SellerDashboard(),
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    buffaloDetails: (context) => const BuffaloDetailsScreen(),
    roleSelection: (context) => const RoleSelectionScreen(),
    buyerDashboard: (context) => const BuyerDashboard(),
    // TODO: Add your other routes here
  };
}
