import 'package:animal_kart/models/health_log.dart';
import 'package:animal_kart/presentation/doctor_dashbaord/app_colors.dart';
import 'package:flutter/material.dart';

class HealthLogTile extends StatelessWidget {
  final HealthLog log;

  const HealthLogTile({super.key, required this.log});

  @override
  Widget build(BuildContext context) {
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
          /// Title Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                log.dayLabel,
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.w800),
              ),
              Text(
                log.date,
                style: TextStyle(
                    fontSize: 14, color: AppColors.textGrey),
              )
            ],
          ),

          const SizedBox(height: 20),

          _rowItem("Health Status", log.healthStatus),
          _rowItem("Milk Output", log.milkOutput),
          _rowItem("Vaccination", log.vaccination),
          _rowItem("Heat Cycle", log.heatCycle),
          _rowItem("Pregnancy", log.pregnancy),

          const SizedBox(height: 12),

          _section("Body Condition", log.bodyCondition),
          _section("Symptoms", log.symptoms),
          _section("Treatments", log.treatments),
          _section("Remarks", log.remarks),
        ],
      ),
    );
  }

  Widget _rowItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Row(
        children: [
          Expanded(
            child: Text(label,
                style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textGrey,
                    fontWeight: FontWeight.w500)),
          ),
          Text(value,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _section(String title, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: const TextStyle(
                    fontWeight: FontWeight.w700, fontSize: 15)),
            const SizedBox(height: 6),
            Text(value, style: const TextStyle(fontSize: 14)),
          ]),
    );
  }
}
