class FarmData {
  final String name, subtitle;
  final int capacity, maxCapacity, totalBuffaloes, readyToMove, observationDays;

  FarmData({
    required this.name,
    this.subtitle = "Main Quarantine Center",
    required this.capacity,
    required this.maxCapacity,
    required this.totalBuffaloes,
    required this.readyToMove,
    required this.observationDays,
  });
}

class TruckData {
  final String id, from, to, driver, contact, status, gps;
  final int count;

  TruckData({
    required this.id,
    required this.from,
    required this.to,
    required this.driver,
    required this.contact,
    required this.count,
    required this.status,
    required this.gps,
  });
}

class SupervisorData {
  final String name, role, phone, farmLocation, managerName, managerPhone;

  SupervisorData({
    required this.name,
    required this.role,
    required this.phone,
    required this.farmLocation,
    required this.managerName,
    required this.managerPhone,
  });
}
