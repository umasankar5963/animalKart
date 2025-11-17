import 'package:animal_kart/presentation/supervisor_dashboard/supervisor_colors.dart';
import 'package:animal_kart/presentation/supervisor_dashboard/supervisor_controller/supervisor_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupervisorProfileScreen extends ConsumerWidget {
  const SupervisorProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sup = ref.watch(supervisorProvider);

    return Scaffold(
      backgroundColor: SupervisorColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // HEADER
              Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 40),
                decoration: const BoxDecoration(
                  color: SupervisorColors.orangeProfile,
                ),
                child: const CircleAvatar(
                  radius: 42,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 50),
                ),
              ),

              const SizedBox(height: 16),

              /// NAME + ROLE
              Text(
                sup.name,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: SupervisorColors.textDark,
                ),
              ),
              Text(
                sup.role,
                style: const TextStyle(
                  fontSize: 15,
                  color: SupervisorColors.textGrey,
                ),
              ),

              const SizedBox(height: 22),

              /// INFO CARDS
              _infoCard(Icons.call, "Phone Number", sup.phone),
              _infoCard(Icons.location_on, "Location", sup.farmLocation),
              _infoCard(Icons.business_center, "Manager",
                  "${sup.managerName}\n${sup.managerPhone}"),

              const SizedBox(height: 30),

              /// LOGOUT BUTTON
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamedAndRemoveUntil(
                        context,
                        '/login-screen',
                        (route) => false,
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red.shade500,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      minimumSize: const Size(double.infinity, 55),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String label, String value) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: SupervisorColors.lightYellow,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: SupervisorColors.yellow),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    color: SupervisorColors.textGrey,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
