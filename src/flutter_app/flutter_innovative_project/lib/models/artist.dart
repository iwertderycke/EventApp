import 'dart:ui';

import 'package:flutter_innovative_project/models/musicGenre.dart';
import 'package:flutter_innovative_project/models/performance.dart';

import 'event.dart';

class Artist {
  int id;
  String name;
  String description;
  String nationality;
  DateTime birthday;
  MusicGenre genre;
  List<String> albums;
  String imagePath;
  List<Event> events;
  List<int> eventIds;
  Color nameColor;
  String facebookURL;
  String instagramURL;
  String soundcloudURL;
  List<Performance> performances = [];


  Artist({
    required this.id,
    required this.name,
    required this.description,
    required this.nationality,
    required this.birthday,
    required this.genre,
    required this.albums,
    required this.imagePath,
    required this.eventIds,
    required this.facebookURL,
    required this.instagramURL,
    required this.soundcloudURL,
    List<Event>? events,
    required this.nameColor,
  }) : events = events ?? [];

  void initializeEvents(List<Event> allEvents) {
    events = allEvents.where((event) => event.artists.any((artist) => artist.id == id)).toList();
  }
}