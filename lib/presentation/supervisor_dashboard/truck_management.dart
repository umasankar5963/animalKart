import 'package:animal_kart/presentation/supervisor_dashboard/models/Farmdata.dart';
import 'package:animal_kart/presentation/supervisor_dashboard/supervisor_colors.dart';
import 'package:animal_kart/presentation/supervisor_dashboard/supervisor_controller/supervisor_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TruckManagementScreen extends ConsumerWidget {
  const TruckManagementScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trucks = ref.watch(trucksProvider);

    return Scaffold(
      backgroundColor: SupervisorColors.background,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text("Truck Management",
                style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: SupervisorColors.textDark)),
            Text("${trucks.length} active trucks",
                style:
                    TextStyle(fontSize: 15, color: SupervisorColors.textGrey)),
            const SizedBox(height: 20),

            ...trucks.map((t) => _truckCard(t)),
          ]),
        ),
      ),
    );
  }

  Widget _truckCard(TruckData t) {
    Color statusColor = t.status == "In Transit"
        ? SupervisorColors.lightBlue
        : SupervisorColors.lightYellow;

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(18)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Expanded(
            child: Text(t.id,
                style: const TextStyle(
                    fontSize: 20, fontWeight: FontWeight.w700)),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
                color: statusColor, borderRadius: BorderRadius.circular(12)),
            child: Text(t.status),
          )
        ]),
        const SizedBox(height: 12),

        Row(children: [
          const Icon(Icons.location_on, color: Colors.green),
          const SizedBox(width: 6),
          Text("From: ${t.from}")
        ]),
        const SizedBox(height: 4),

        Row(children: [
          const Icon(Icons.location_on, color: Colors.red),
          const SizedBox(width: 6),
          Text("To: ${t.to}")
        ]),
        const Divider(height: 24),

        Row(children: [
          const Icon(Icons.person),
          const SizedBox(width: 6),
          Text("Driver"),
          const Spacer(),
          Text(t.driver, style: const TextStyle(fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 6),

        Row(children: [
          const Icon(Icons.call),
          const SizedBox(width: 6),
          Text("Contact"),
          const Spacer(),
          Text(t.contact, style: const TextStyle(fontWeight: FontWeight.bold)),
        ]),
        const SizedBox(height: 6),

        Row(children: [
          const Icon(Icons.inventory_2),
          const SizedBox(width: 6),
          Text("Buffalo Count"),
          const Spacer(),
          Text("${t.count}",
              style: const TextStyle(fontWeight: FontWeight.bold)),
        ]),

        if (t.gps.isNotEmpty) ...[
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: SupervisorColors.lightBlue,
                borderRadius: BorderRadius.circular(12)),
            child: Row(children: [
              const Icon(Icons.location_pin, color: SupervisorColors.blue),
              const SizedBox(width: 6),
              Text("GPS: ${t.gps}")
            ]),
          )
        ]
      ]),
    );
  }
}
