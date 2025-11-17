import 'package:animal_kart/presentation/doctor_dashbaord/doctor_home.dart';

import 'package:animal_kart/presentation/supervisor_dashboard/supervisor_home.dart';
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
  static const String sellerDashboard = '/superVisor-dashboard';
  static const String splash = '/splash-screen';
  static const String login = '/login-screen';
  static const String buffaloDetails = '/buffalo-details-screen';
  static const String roleSelection = '/role-selection-screen';
  static const String buyerDashboard = '/superVisor-dashboard';
  static const String doctorDashboard = '/doctor-dashboard';
  static const String supervisorDashboard = '/supervisor-dashboard';
  
  

  static Map<String, WidgetBuilder> routes = {
    initial: (context) => const SplashScreen(),
    sellerDashboard: (context) => const SellerDashboard(),
    splash: (context) => const SplashScreen(),
    login: (context) => const LoginScreen(),
    buffaloDetails: (context) => const BuffaloDetailsScreen(),
    roleSelection: (context) => const RoleSelectionScreen(),
    buyerDashboard: (context) => const BuyerDashboard(),
    doctorDashboard: (context) => const DoctorHome(),
    supervisorDashboard : (context) => const SupervisorHome()
    // TODO: Add your other routes here
  };
}
