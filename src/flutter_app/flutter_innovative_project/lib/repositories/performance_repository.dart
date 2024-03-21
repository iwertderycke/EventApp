import 'package:flutter_innovative_project/models/performance.dart';

class PerformanceRepository {
  List<Performance> performancesList = [
    Performance(
      id: 1,
      artistIds: [3],
      eventId: 1,
      artistId: 3,
      description: "Beetz n noisez",
      starttime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 0, 0, 0),
      endtime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 5, 0, 0),
    ),
    Performance(
      id: 2,
      artistIds: [1],
      eventId: 1,
      artistId: 1,
      description: "Simon in Wonderland",
      starttime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 5, 0, 0),
      endtime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0, 0),
    ),
    Performance(
      id: 3,
      artistIds: [4],
      eventId: 1,
      artistId: 4,
      description: "Massaar",
      starttime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 10, 0, 0),
      endtime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 15, 0, 0),
    ),
    Performance(
      id: 4,
      artistIds: [5],
      eventId: 1,
      artistId: 5,
      description: "Man Outta Space",
      starttime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 15, 0, 0),
      endtime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 20, 0, 0),
    ),
    Performance(
      id: 5,
      artistIds: [2],
      eventId: 1,
      artistId: 2,
      description: "Beathoven",
      starttime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 20, 0, 0),
      endtime: DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day, 23, 0, 0),
    ),
  ];

  List<Performance> getPerformancesForEvent(int eventId) {
    return performancesList.where((performance) => performance.eventId == eventId).toList();
  }
}
