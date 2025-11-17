import 'package:animal_kart/presentation/supervisor_dashboard/supervisor_colors.dart';
import 'package:animal_kart/presentation/supervisor_dashboard/supervisor_dashboard.dart';
import 'package:animal_kart/presentation/supervisor_dashboard/supervisor_profile.dart';
import 'package:animal_kart/presentation/supervisor_dashboard/truck_management.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupervisorHome extends ConsumerStatefulWidget {
  const SupervisorHome({super.key});

  @override
  ConsumerState<SupervisorHome> createState() => _SupervisorHomeState();
}

class _SupervisorHomeState extends ConsumerState<SupervisorHome> {
  int _index = 0;

  final screens = const [
    SupervisorDashboard(),
    TruckManagementScreen(),
    SupervisorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: SupervisorColors.background,
      body: IndexedStack(
        index: _index,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _index,
        onTap: (i) => setState(() => _index = i),
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: SupervisorColors.yellow,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_rounded),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_shipping_rounded),
            label: 'transport',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'profile',
          ),
        ],
      ),
    );
  }
}
