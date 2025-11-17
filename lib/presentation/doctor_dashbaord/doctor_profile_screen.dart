import 'package:animal_kart/presentation/doctor_dashbaord/app_colors.dart';
import 'package:animal_kart/routes/app_routes.dart';
import 'package:flutter/material.dart';


class DoctorProfileScreen extends StatelessWidget {
  const DoctorProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          /// TOP HEADER
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 40),
            decoration: const BoxDecoration(
              color: AppColors.teal,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(28),
                bottomRight: Radius.circular(28),
              ),
            ),
            child: Column(
              children: const [
                Icon(Icons.medical_services_rounded,
                    color: Colors.white, size: 70),
                SizedBox(height: 14),
                Text(
                  "Dr. Rajesh Kumar",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700),
                ),
                Text(
                  "Veterinary Medicine",
                  style: TextStyle(color: Colors.white70, fontSize: 15),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionTitle("Contact Information"),
                  _infoCard(Icons.phone, "Phone Number", "+91 98765 43210"),

                  const SizedBox(height: 26),

                  _sectionTitle("Farm Assignment"),
                  _infoCard(Icons.location_on_outlined, "Location",
                      "Farm A - Main Quarantine",
                      subtitle: "Farm ID: FA-001"),

                  const SizedBox(height: 26),

                  _sectionTitle("Current Workload"),
                  _workloadCard(),

                  const SizedBox(height: 35),

                  _logoutButton(context),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textDark,
      ),
    );
  }

  Widget _infoCard(IconData icon, String label, String value,
      {String? subtitle}) {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: AppShadow.card,
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.teal.withOpacity(0.1),
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: AppColors.teal),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        color: AppColors.textGrey,
                        fontSize: 15,
                        fontWeight: FontWeight.w500)),
                Text(
                  value,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w700),
                ),
                if (subtitle != null)
                  Text(subtitle,
                      style:
                          TextStyle(color: AppColors.textGrey, fontSize: 14)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _workloadCard() {
    return Container(
      margin: const EdgeInsets.only(top: 12),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: AppShadow.card,
      ),
      child: Column(
        children: [
          Icon(Icons.list_alt,
              size: 45, color: AppColors.teal.withOpacity(0.7)),
          const SizedBox(height: 12),
          const Text(
            "8",
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
          Text(
            "Assigned Buffaloes",
            style: TextStyle(
                color: AppColors.textGrey,
                fontSize: 15,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }

  Widget _logoutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushNamedAndRemoveUntil(context, '/login-screen', (route) => false);


      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red.shade500,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
        padding: const EdgeInsets.symmetric(vertical: 14),
        minimumSize: const Size(double.infinity, 55),
      ),
      child: const Text(
        "Logout",
        style: TextStyle(fontSize: 18, color: Colors.white),
      ),
    );
  }
}
