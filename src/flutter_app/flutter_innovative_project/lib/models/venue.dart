import 'event.dart';

class Venue {
  int id;
  String name;
  String address;
  int capacity;
  double? latitude;
  double? longitude;
  List<Event> events; // List of events associated with the venue

  Venue({
    required this.id,
    required this.name,
    required this.address,
    required this.capacity,
    required this.latitude,
    required this.longitude,
    List<Event> events = const [], // Initialize with an empty list of events
  }) : events = List.unmodifiable(events); // Ensure the list is unmodifiable

  void addEvent(Event event) {
    events.add(event);
  }
}