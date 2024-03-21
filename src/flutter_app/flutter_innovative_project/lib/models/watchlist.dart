import 'package:flutter/material.dart';
import 'package:flutter_innovative_project/models/performance.dart';
import 'package:flutter_innovative_project/repositories/performance_repository.dart';
import '../repositories/venue_repository.dart';
import 'event.dart';
import 'musicGenre.dart';

class Watchlist extends ChangeNotifier {
  List<Event> eventsListPopular;
  PerformanceRepository performanceRepository = PerformanceRepository();

  Watchlist() : eventsListPopular = _initializeEventsList();

  static List<Event> _initializeEventsList() {
    final venueRepository = VenueRepository();

    return [
      Event(
        id: 1,
        name: 'No Reason',
        genre: MusicGenre.Techno,
        location: 'De Panne',
        startDateTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 6, 0),
        endDateTime: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 23, 0),
        imagePath: 'lib/images/no_reason.jpg',
        icon: const Icon(Icons.bookmark_add),
        mainColor: Colors.pinkAccent,
        venue: venueRepository.getVenueById(1),
        venueId: 1,
      ),
      Event(
        id: 2,
        name: 'Trip 2 Wonderland',
        genre: MusicGenre.Tekno,
        location: 'Gent',
        startDateTime: DateTime(2023, 5, 20, 23, 0),
        endDateTime: DateTime(2023, 5, 21, 6, 0),
        imagePath: 'lib/images/trip2wonderland.jpg',
        icon: const Icon(Icons.bookmark_add),
        mainColor: Colors.purple,
        venue: venueRepository.getVenueById(2),
        venueId: 2,
      ),
      Event(
        id: 3,
        name: 'Trip to Wonderland',
        genre: MusicGenre.Tekno,
        location: 'Gent',
        startDateTime: DateTime.now()
            .add(const Duration(days: 1))
            .subtract(Duration(
                hours: DateTime.now().hour,
                minutes: DateTime.now().minute,
                seconds: DateTime.now().second))
            .add(const Duration(hours: 23)),
        endDateTime: DateTime.now()
            .add(const Duration(days: 2))
            .subtract(Duration(
                hours: DateTime.now().hour,
                minutes: DateTime.now().minute,
                seconds: DateTime.now().second))
            .add(const Duration(hours: 6)),
        imagePath: 'lib/images/triptowonderland.png',
        icon: const Icon(Icons.bookmark_add),
        mainColor: Colors.green,
        venue: venueRepository.getVenueById(2),
        venueId: 2,
      ),
      Event(
        id: 4,
        name: 'Mind Against at Kompass (4 HOUR SET)',
        genre: MusicGenre.Techno,
        location: 'Gent',
        startDateTime: DateTime(2023, 10, 20, 22, 0),
        endDateTime: DateTime(2023, 10, 21, 7, 0),
        imagePath: 'lib/images/kompass1.jpg',
        icon: const Icon(Icons.bookmark_add),
        mainColor: Colors.blueAccent,
        venue: venueRepository.getVenueById(3),
        venueId: 3,
      ),
      Event(
        id: 5,
        name: 'Trym at Kompass',
        genre: MusicGenre.Techno,
        location: 'Gent',
        startDateTime: DateTime(2023, 10, 27, 23, 0),
        endDateTime: DateTime(2023, 10, 28, 7, 0),
        imagePath: 'lib/images/kompass2.jpg',
        icon: const Icon(Icons.bookmark_add),
        mainColor: Colors.purpleAccent,
        venue: venueRepository.getVenueById(3),
        venueId: 3,
      )
    ];
  }

  List<Event> eventsWatchlist = [];

  List<Event> getEventsList() {
    DateTime currentDate = DateTime.now();

    List<Event> sortedEvents = List.of(eventsListPopular);

    sortedEvents.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));

    for (var event in sortedEvents) {
      if (event.startDateTime.isBefore(currentDate)) {
        event.icon = Icon(
          IconData(
            Icons.event_busy.codePoint,
            fontFamily: Icons.event_busy.fontFamily,
            fontPackage: Icons.event_busy.fontPackage,
          ),
          color: Colors.redAccent,
        );
      }
    }

    return sortedEvents;
  }

  List<Performance> getPerformancesForEvent(int eventId) {
    return performanceRepository.performancesList
        .where((performance) => performance.eventId == eventId)
        .toList();
  }

  List<Event> searchEvent(String query) {
    final suggestions = eventsListPopular.where((event) {
      final eventName = event.name.toLowerCase();
      final input = query.toLowerCase();

      return eventName.contains(input);
    }).toList();

    return suggestions;
  }

  List<Event> getEventsWatchList() {
    eventsWatchlist.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));
    return eventsWatchlist;
  }

  void toggleEventInWatchlist(Event event) {
    final DateTime currentDate = DateTime.now();

    if (event.startDateTime.isAfter(currentDate)) {
      if (eventsWatchlist.contains(event)) {
        eventsWatchlist.remove(event);
        event.icon = const Icon(
          Icons.bookmark_add,
        );
      } else {
        eventsWatchlist.add(event);
        event.icon = const Icon(
          Icons.bookmark_remove,
        );
      }
      notifyListeners();
    } else {}
  }

  String getEventNameById(int eventId) {
    Event? event = eventsListPopular.firstWhere((event) => event.id == eventId);
    return event.name;
  }
}
