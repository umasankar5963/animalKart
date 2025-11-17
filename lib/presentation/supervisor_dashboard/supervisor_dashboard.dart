import 'package:animal_kart/presentation/supervisor_dashboard/models/Farmdata.dart';
import 'package:animal_kart/presentation/supervisor_dashboard/supervisor_colors.dart';
import 'package:animal_kart/presentation/supervisor_dashboard/supervisor_controller/supervisor_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SupervisorDashboard extends ConsumerWidget {
  const SupervisorDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farm = ref.watch(farmProvider);

    return Scaffold(
      backgroundColor: SupervisorColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(farm.name,
                  style: const TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: SupervisorColors.textDark)),
              Text("Main Quarantine Center",
                  style: TextStyle(
                      fontSize: 15, color: SupervisorColors.textGrey)),
              const SizedBox(height: 25),

              // FARM CAPACITY CARD
              _capacityCard(farm),
              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(child: _statCard(Icons.inventory_2_rounded,
                      SupervisorColors.lightYellow, farm.totalBuffaloes,
                      "Total Buffaloes")),
                  const SizedBox(width: 14),
                  Expanded(
                      child: _statCard(Icons.trending_up_rounded,
                          SupervisorColors.lightGreen, farm.readyToMove,
                          "Ready to Move")),
                ],
              ),

              const SizedBox(height: 25),
              _observationPeriod(farm.observationDays),
            ],
          ),
        ),
      ),
    );
  }

  Widget _capacityCard(FarmData farm) {
    final percent = (farm.capacity / farm.maxCapacity) * 100;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text("${farm.capacity} / ${farm.maxCapacity}",
            style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: SupervisorColors.textDark)),
        const Text("Buffaloes",
            style: TextStyle(color: SupervisorColors.textGrey)),
        const SizedBox(height: 12),
        LinearProgressIndicator(
          value: farm.capacity / farm.maxCapacity,
          color: SupervisorColors.green,
          backgroundColor: SupervisorColors.lightGreen.withOpacity(0.4),
          minHeight: 10,
        ),
      ]),
    );
  }

  Widget _statCard(IconData icon, Color bg, int count, String label) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
          child: Icon(icon, color: SupervisorColors.yellow, size: 32),
        ),
        const SizedBox(height: 10),
        Text("$count",
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(color: SupervisorColors.textGrey)),
      ]),
    );
  }

  Widget _observationPeriod(int days) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Text("Standard Observation",
            style: TextStyle(
                color: SupervisorColors.textGrey,
                fontWeight: FontWeight.w500)),
        const SizedBox(height: 6),
        Text("$days days",
            style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: SupervisorColors.yellow)),
        const Text("Required observation period for this facility",
            style: TextStyle(color: SupervisorColors.textGrey)),
      ]),
    );
  }
}
