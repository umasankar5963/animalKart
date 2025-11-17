import 'package:animal_kart/models/buffalo.dart';
import 'package:animal_kart/presentation/doctor_dashbaord/app_colors.dart';
import 'package:flutter/material.dart';


class AssignedBuffaloCard extends StatelessWidget {
  final Buffalo buffalo;
  final VoidCallback onTap;

  const AssignedBuffaloCard({
    super.key,
    required this.buffalo,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(22),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: AppRadius.card,
          boxShadow: AppShadow.card,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              buffalo.id,
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 3),
            Text(
              buffalo.location,
              style: TextStyle(color: AppColors.textGrey, fontSize: 15),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                const Icon(Icons.access_time, size: 20),
                const SizedBox(width: 8),
                Text("Day ${buffalo.day} of ${buffalo.totalDays}",
                    style: const TextStyle(fontSize: 14)),
                const Spacer(),
                Text(
                  "${buffalo.progressPercent}%",
                  style: const TextStyle(
                      fontSize: 20,
                      color: AppColors.teal,
                      fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 14),

            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: LinearProgressIndicator(
                value: buffalo.progressPercent / 100,
                minHeight: 12,
                backgroundColor: Colors.teal.shade100,
                color: AppColors.teal,
              ),
            ),

            const SizedBox(height: 18),

            Row(
              children: [
                const Icon(Icons.check_circle,
                    size: 18, color: Colors.green),
                const SizedBox(width: 8),
                Text("Last updated: ${buffalo.lastUpdated}",
                    style: const TextStyle(fontSize: 14)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
