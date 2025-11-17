import 'package:animal_kart/presentation/doctor_dashbaord/pending_updates_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'doctor_dashboard.dart';

import 'doctor_profile_screen.dart';
import 'app_colors.dart';
import 'buffalo_controller/buffalo_provider.dart';

class DoctorHome extends ConsumerStatefulWidget {
  const DoctorHome({super.key});

  @override
  ConsumerState<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends ConsumerState<DoctorHome> {
  int _tabIndex = 0;

  final List<Widget> _pages = const [
    DoctorDashboard(),
    PendingUpdatesScreen(),
    DoctorProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final buffaloes = ref.watch(buffaloProvider);
    final pendingCount =
        buffaloes.where((b) => b.updateRequired).length;

    return Scaffold(
      body: IndexedStack(
        index: _tabIndex,
        children: _pages,
      ),
      bottomNavigationBar: _bottomNav(pendingCount),
    );
  }

  Widget _bottomNav(int pendingCount) {
    return BottomNavigationBar(
      currentIndex: _tabIndex,
      onTap: (i) => setState(() => _tabIndex = i),
      backgroundColor: Colors.white,
      selectedItemColor: AppColors.teal,
      unselectedItemColor: Colors.grey,
      showSelectedLabels: false,
      showUnselectedLabels: false,
      items: [
        const BottomNavigationBarItem(
            icon: Icon(Icons.list_alt), label: ""),

        /// Pending Tab With Badge
        BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.error_outline),
              if (pendingCount > 0)
                Positioned(
                  right: -6,
                  top: -4,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      pendingCount.toString(),
                      style: const TextStyle(
                          fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
          label: "",
        ),

        const BottomNavigationBarItem(
            icon: Icon(Icons.person_outline), label: ""),
      ],
    );
  }
}
