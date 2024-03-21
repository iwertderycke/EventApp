// ignore_for_file: file_names

import '../models/venue.dart';

class VenueRepository {
  List<Venue> venuesList = [
    Venue(id: 1, name: 'De Boare', address: 'Koningsplein 1, 8660 De Panne', capacity: 800, latitude: 51.09472347628771, longitude: 2.587163810889165),
    Venue(id: 2, name: 'Minus One', address: 'Opgeëistenlaan 455, 9000 Gent', capacity: 500, latitude: 51.064743228063, longitude: 3.7168644399562143),
    Venue(id: 3, name: 'Kompass Club', address: 'Nieuwevaart 51, 9000 Gent', capacity: 5000, latitude: 51.07397185935848, longitude: 3.7416040397236654),
  ];

  List<Venue> getVenues() {
    return venuesList.toList();
  }

  String getVenueAddress(int id) {
    var venue = venuesList.firstWhere((venue) => venue.id == id);
    return '${venue.name} | ${venue.address}';
  }

  Venue? getVenueById(int id) {
    return venuesList.firstWhere((venue) => venue.id == id);
  }
}
