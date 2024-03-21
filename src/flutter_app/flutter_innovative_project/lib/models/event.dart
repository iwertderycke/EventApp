import 'package:flutter/widgets.dart';
import 'package:flutter_innovative_project/models/musicGenre.dart';
import 'package:flutter_innovative_project/models/performance.dart';
import 'package:flutter_innovative_project/models/venue.dart';

import 'artist.dart';

class Event {
  int id;
  String name;
  MusicGenre genre;
  final String location;
  final DateTime startDateTime;
  final DateTime endDateTime;
  final String imagePath;
  Icon icon;
  Color mainColor;
  Venue? venue;
  int venueId;
  List<Artist> artists;
  List<Performance> performances = [];

  Event({
    required this.id,
    required this.name,
    required this.genre,
    required this.location,
    required this.startDateTime,
    required this.endDateTime,
    required this.imagePath,
    required this.icon,
    required this.mainColor,
    required this.venue,
    required this.venueId,
    List<Artist>? artists,
  }) : artists = artists ?? [];
}
