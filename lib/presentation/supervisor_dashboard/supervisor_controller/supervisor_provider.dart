import 'package:animal_kart/presentation/supervisor_dashboard/models/Farmdata.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final farmProvider = Provider((ref) {
  return FarmData(
    name: "Farm A",
    subtitle: "Main Quarantine Center",
    capacity: 32,
    maxCapacity: 50,
    totalBuffaloes: 4,
    readyToMove: 0,
    observationDays: 12,
  );
});

final trucksProvider = Provider((ref) {
  return [
    TruckData(
      id: "MH-12-AB-1234",
      from: "Farm A",
      to: "Farm B",
      driver: "Ramesh Yadav",
      contact: "+91 98765 43240",
      count: 6,
      status: "In Transit",
      gps: "19.0760, 72.8777",
    ),
    TruckData(
      id: "MH-12-CD-5678",
      from: "Farm B",
      to: "Farm C",
      driver: "Suresh Patil",
      contact: "+91 98765 43241",
      count: 8,
      status: "Loading",
      gps: "",
    ),
  ];
});

final supervisorProvider = Provider((ref) {
  return SupervisorData(
    name: "Arun Singh",
    role: "Farm Supervisor",
    phone: "+91 98765 43220",
    farmLocation: "Farm A - Main Quarantine",
    managerName: "Vikram Patel",
    managerPhone: "+91 98765 43230",
  );
});
