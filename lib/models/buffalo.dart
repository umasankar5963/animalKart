import 'package:animal_kart/models/health_log.dart';

class Buffalo {
  String id;
  String location;
  int day;
  int totalDays;
  int progressPercent;
  bool updateRequired;
  String lastUpdated;

  List<HealthLog> logs;

  Buffalo({
    required this.id,
    required this.location,
    required this.day,
    required this.totalDays,
    required this.progressPercent,
    required this.updateRequired,
    required this.lastUpdated,
    required this.logs,
  });
}



