import 'package:animal_kart/models/buffalo.dart';
import 'package:animal_kart/presentation/doctor_dashbaord/app_colors.dart';
import 'package:animal_kart/presentation/doctor_dashbaord/widgets/health_log_form.dart';
import 'package:animal_kart/presentation/doctor_dashbaord/widgets/health_log_title.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';




class BuffaloDetails extends ConsumerWidget {
  final Buffalo buffalo;

  const BuffaloDetails({super.key, required this.buffalo});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.teal,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Text(
          "Buffalo Details",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.teal,
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => HealthLogForm(buffalo: buffalo),
            ),
          );
        },
      ),

      /// MAIN BODY
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// --- HEADER CARD ---
            _headerCard(),

            const SizedBox(height: 22),

            /// --- PROGRESS CARD ---
            _progressCard(),

            const SizedBox(height: 22),

            /// --- LAST UPDATE CARD ---
            _lastUpdateCard(),

            const SizedBox(height: 30),

            /// --- HEALTH HISTORY SECTION TITLE ---
            const Text(
              "Health Log History",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w800,
                color: AppColors.textDark,
              ),
            ),
            const SizedBox(height: 6),

            Text(
              "${buffalo.logs.length} total records",
              style: TextStyle(color: AppColors.textGrey, fontSize: 14),
            ),

            const SizedBox(height: 16),

            ...buffalo.logs.map(
              (log) => Padding(
                padding: const EdgeInsets.only(bottom: 18),
                child: HealthLogTile(log: log),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // -------------------- HEADER CARD --------------------
  Widget _headerCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.card,
        boxShadow: AppShadow.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP ROW — ID + TAG
          Row(
            children: [
              Expanded(
                child: Text(
                  buffalo.id,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                    color: AppColors.textDark,
                  ),
                ),
              ),

              /// TAG (Quarantine)
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                    color: AppColors.softYellow,
                    borderRadius: BorderRadius.circular(20)),
                child: const Text(
                  "Quarantine",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          /// SUBTITLE – Location
          Text(
            buffalo.location,
            style: TextStyle(
              fontSize: 15,
              color: AppColors.textGrey,
            ),
          ),
        ],
      ),
    );
  }

  // ---------------- QUARANTINE PROGRESS CARD ----------------
  Widget _progressCard() {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.card,
        boxShadow: AppShadow.card,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Quarantine Progress",
            style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: AppColors.textDark),
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              const Icon(Icons.access_time, color: AppColors.teal, size: 22),
              const SizedBox(width: 10),
              Text(
                "Day ${buffalo.day} of ${buffalo.totalDays}",
                style: const TextStyle(fontSize: 16),
              ),
              const Spacer(),
              Text(
                "${buffalo.progressPercent}%",
                style: const TextStyle(
                  fontSize: 22,
                  color: AppColors.teal,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          /// CLEANER PROGRESS BAR
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: LinearProgressIndicator(
              minHeight: 12,
              value: buffalo.progressPercent / 100,
              color: AppColors.teal,
              backgroundColor: Colors.teal.shade100,
            ),
          ),

          const SizedBox(height: 18),

          /// PROGRESS TIMELINE DOTS (VISUAL UPGRADE)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(
              buffalo.totalDays,
              (i) => CircleAvatar(
                radius: 5,
                backgroundColor: i < buffalo.day
                    ? AppColors.teal
                    : Colors.grey.shade300,
              ),
            ),
          )
        ],
      ),
    );
  }

  // -------------------- LAST UPDATED CARD --------------------
  Widget _lastUpdateCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 22),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: AppRadius.card,
        boxShadow: AppShadow.card,
      ),
      child: Row(
        children: [
          const Icon(Icons.calendar_today_rounded,
              color: AppColors.teal, size: 22),
          const SizedBox(width: 15),
          Expanded(
            child: Text(
              "Last updated: ${buffalo.lastUpdated}",
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}
