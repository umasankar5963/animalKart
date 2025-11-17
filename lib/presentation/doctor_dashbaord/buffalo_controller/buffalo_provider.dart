import 'package:animal_kart/models/buffalo.dart';
import 'package:animal_kart/models/health_log.dart';

import 'package:flutter_riverpod/legacy.dart';

class BuffaloNotifier extends StateNotifier<List<Buffalo>> {
  BuffaloNotifier()
      : super([
          Buffalo(
            id: "BUF-2024-001",
            location: "Farm A - Main Quarantine",
            day: 8,
            totalDays: 12,
            progressPercent: 67,
            updateRequired: false,
            lastUpdated: "11/01/2025",
            logs: [
              HealthLog(
                dayLabel: "Day 8",
                date: "11/01/2025",
                healthStatus: "Good",
                milkOutput: "12.5L",
                vaccination: "Up To Date",
                heatCycle: "Normal",
                pregnancy: "Not Pregnant",
                bodyCondition: "Good muscle tone",
                symptoms: "None",
                treatments: "Routine monitoring",
                remarks: "Stable condition",
              )
            ],
          ),
          Buffalo(
            id: "BUF-2024-002",
            location: "Farm A - Main Quarantine",
            day: 5,
            totalDays: 12,
            progressPercent: 42,
            updateRequired: true,
            lastUpdated: "10/01/2025",
            logs: [],
          ),
        ]);

  /// Add new log
  void addLog(String buffaloId, HealthLog log) {
    state = state.map((b) {
      if (b.id == buffaloId) {
        b.logs.insert(0, log);
        b.updateRequired = false;
      }
      return b;
    }).toList();
  }
}

final buffaloProvider =
    StateNotifierProvider<BuffaloNotifier, List<Buffalo>>(
        (ref) => BuffaloNotifier());
