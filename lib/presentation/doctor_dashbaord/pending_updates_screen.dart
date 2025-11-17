import 'package:animal_kart/presentation/doctor_dashbaord/app_colors.dart';
import 'package:animal_kart/presentation/doctor_dashbaord/buffalo_controller/buffalo_provider.dart';
import 'package:animal_kart/presentation/doctor_dashbaord/widgets/health_log_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class PendingUpdatesScreen extends ConsumerWidget {
  const PendingUpdatesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buffaloes = ref.watch(buffaloProvider);
    final pending = buffaloes.where((b) => b.updateRequired).toList();

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Pending Updates",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              "${pending.length} buffalo need health log",
              style: TextStyle(fontSize: 15, color: AppColors.textGrey),
            ),

            const SizedBox(height: 28),

            ...pending.map((buffalo) => _pendingCard(context, buffalo)),
          ],
        ),
      ),
    );
  }

  Widget _pendingCard(BuildContext context, buffalo) {
    return Container(
      margin: const EdgeInsets.only(bottom: 22),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: Colors.red.shade100, width: 1.4),
        boxShadow: AppShadow.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// red tag
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 16),
                SizedBox(width: 6),
                Text(
                  "Update Required",
                  style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          Text(
            buffalo.id,
            style: const TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              color: AppColors.textDark,
            ),
          ),

          const SizedBox(height: 4),
          Text(
            buffalo.location,
            style: TextStyle(color: AppColors.textGrey, fontSize: 15),
          ),

          const SizedBox(height: 16),

          Row(
            children: [
              const Icon(Icons.access_time, size: 18),
              const SizedBox(width: 8),
              Text("Day ${buffalo.day} of ${buffalo.totalDays}",
                  style: const TextStyle(fontSize: 14)),
            ],
          ),

          const SizedBox(height: 8),
          Text(
            "Last updated: ${buffalo.lastUpdated}",
            style: TextStyle(fontSize: 14, color: AppColors.textGrey),
          ),

          const SizedBox(height: 20),

          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => HealthLogForm(buffalo: buffalo),
                  ),
                );
              },
              child: const Text("Log Health Data"),
            ),
          ),
        ],
      ),
    );
  }
}
