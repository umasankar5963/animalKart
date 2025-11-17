import 'package:animal_kart/presentation/doctor_dashbaord/app_colors.dart';
import 'package:animal_kart/presentation/doctor_dashbaord/buffalo_controller/buffalo_provider.dart';
import 'package:animal_kart/presentation/doctor_dashbaord/widgets/assigned_buffalo_card.dart';
import 'package:animal_kart/presentation/doctor_dashbaord/widgets/buffalo_details.dart';
import 'package:animal_kart/presentation/doctor_dashbaord/widgets/pending_buffalo_card.dart';

import 'package:animal_kart/presentation/doctor_dashbaord/widgets/stat_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class DoctorDashboard extends ConsumerWidget {
  const DoctorDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final buffaloes = ref.watch(buffaloProvider);
    final pending = buffaloes.where((b) => b.updateRequired).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 8),

              /// Header
              Text(
                "Doctor Dashboard",
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textDark,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "${buffaloes.length} buffaloes under your care",
                style: TextStyle(
                  fontSize: 15,
                  color: AppColors.textGrey,
                ),
              ),

              const SizedBox(height: 30),

              /// Stat Cards
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      title: "Assigned",
                      count: buffaloes.length,
                      icon: Icons.monitor_heart_outlined,
                      color: AppColors.teal,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: StatCard(
                      title: "Pending",
                      count: pending.length,
                      icon: Icons.error_outline,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 35),

              /// Section Title
              Row(
                children: [
                  Icon(Icons.warning_amber_rounded,
                      color: Colors.amber.shade700, size: 22),
                  const SizedBox(width: 6),
                  Text(
                    "Pending Buffaloes",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                  const Spacer(),
                  if (pending.isNotEmpty)
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                          color: Colors.red.shade100,
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        pending.length.toString(),
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "These buffaloes need immediate health updates",
                style: TextStyle(color: AppColors.textGrey, fontSize: 14),
              ),

              const SizedBox(height: 16),

              ...pending.map((buff) => Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: PendingBuffaloCard(
                      buffalo: buff,
                      onTap: () => _openDetails(context, buff),
                    ),
                  )),

              const SizedBox(height: 20),

              /// All assigned
              Row(
                children: [
                  Icon(Icons.notes_outlined,
                      color: Colors.brown.shade600, size: 22),
                  const SizedBox(width: 6),
                  Text(
                    "All Assigned Buffaloes",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: AppColors.textDark,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 5),
              Text(
                "Complete list of buffaloes under your supervision",
                style: TextStyle(color: AppColors.textGrey, fontSize: 14),
              ),

              const SizedBox(height: 16),

              ...buffaloes.map((buff) => Padding(
                    padding: const EdgeInsets.only(bottom: 18),
                    child: AssignedBuffaloCard(
                      buffalo: buff,
                      onTap: () => _openDetails(context, buff),
                    ),
                  )),
            ],
          ),
        ),
      ),
      
    );
  }

  void _openDetails(BuildContext context, buffalo) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => BuffaloDetails(buffalo: buffalo)),
    );
  }

 
}
