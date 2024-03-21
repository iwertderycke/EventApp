// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_innovative_project/models/performance.dart';
import 'package:flutter_innovative_project/models/watchlist.dart';
import 'package:flutter_innovative_project/repositories/performance_repository.dart';

import '../models/artist.dart';
import '../models/event.dart';
import '../models/musicGenre.dart';

class ArtistRepository {
  final Watchlist watchlist = Watchlist();
  PerformanceRepository performanceRepository = PerformanceRepository();

  List<Artist> artistsList = [
    Artist(
      id: 1,
      name: 'Simon in Wonderland',
      birthday: DateTime(1995, 5, 26),
      genre: MusicGenre.Techno,
      albums: ['Album 1', 'Album 2'],
      imagePath: 'lib/images/artists/simoninwonderland.jpg',
      eventIds: [1],
      nameColor: Colors.white,
      description:
          "Born in 1995 and located in Belgium Simon In Wonderland's sound interpretations will take you on a journey through space. Coming from the rave party scene and making a turn to produce tracks floating between House and Techno. Far away from everyone, he locks himself up in his basement to produce spacey but still danceable electronic music - especially House and Techno.",
      nationality: "Belgium",
      facebookURL: "https://www.facebook.com/WonderlandInSimon/",
      instagramURL: "https://www.instagram.com/__simoninwonderland__/",
      soundcloudURL: "https://soundcloud.com/wonderlandinsimon",      
    ),
    Artist(
      id: 2,
      name: 'Beathoven',
      birthday: DateTime(2000, 5, 26),
      genre: MusicGenre.Tekno,
      albums: [],
      imagePath: 'lib/images/artists/beathoven.jpg',
      eventIds: [1, 2, 3],
      nameColor: Colors.white,
      facebookURL: "https://www.facebook.com/maxim.vanhove.9",
      instagramURL: "https://www.instagram.com/beathoven_vinyl/",
      soundcloudURL: "https://soundcloud.com/beathovenn23",  
      description: '''
Mixing vinyl
Retro / Techno / Tekno / Early Hardcore

Part of the Wonderland Soundsystem Crew

Resident @ ZWZ soundsystem
''',
      nationality: "Belgium",
    ),
    Artist(
      id: 3,
      name: 'Beetz n Noizez',
      birthday: DateTime(2000, 5, 26),
      genre: MusicGenre.Techno,
      albums: [],
      imagePath: 'lib/images/artists/beetznnoizez.jpg',
      eventIds: [1],
      nameColor: Colors.white,
      facebookURL: "https://www.facebook.com/Beetznnoizez",
      instagramURL: "",
      soundcloudURL: "https://soundcloud.com/beetznnoizez",
      description: '''
Collecting records from house to techno for about 25 years!!
Beetz n Noizez is the perfect example of a DJ for whom it's impossible to stick with just one genre. The focus is mostly on techno and minimal, but also deep and tech are genres that Beetz n Noizez plays on a regular basis!
He learned to play the old-fashioned way, 2 Technics and a Rodec... and he still uses this very same setup today, only now he's combining vinyl with Traktor Scratch and timecode vinyl.... he has nothing against sync.... it's just something he doesn't do.....
Beetz n Noizez is a resident DJ for The Next Level Techno concept, Boccaccio Ostend, and the Techno Connection UK Underground Techno concept 'Shapes Of Techno!' He also has a permanent place among 9 other DJs in the SoundOfSystems concept.
''',
      nationality: "Belgium",
    ),
    Artist(
      id: 4,
      name: 'Massaar',
      birthday: DateTime(2000, 5, 26),
      genre: MusicGenre.Techno,
      albums: [],
      imagePath: 'lib/images/artists/massaar.jpg',
      eventIds: [1],
      nameColor: Colors.black,
      facebookURL: "https://www.facebook.com/massaar.official",
      instagramURL: "https://www.instagram.com/massaar_/",
      soundcloudURL: "https://soundcloud.com/massaar",  
      description: '''
Driven by his idol Richie Hawtin & inspired by various artists and labels in the dark minimal scene, this young talent definitely earned his spot.

Massaar, born in Kortrijk, bought his first turntables at the age of 20.
Soon he started playing at the Londenbeat Café & events such as Borderline, Rotection & Click System, and the infamous Lab.105dB parties at Club Basic.

His gigs are always refreshing as he spends hours searching for new music & sounds to please ears & mind. He creates his own style by mixing with the Model 1 and adding extra sounds with the Roland TR-8S. With his controllers, he combines minimal techno with minimalistic clickery beats, loop-based waves & deep, dark baselines.

His breakthrough came in the summer of 2010, after sending a demo to one of the creators of ‘Feestgedruis’ who immediately saw his potential.
This has led to some very interesting & memorable bookings... starting with a warm-up for Barem at the former Make Up Club and gigs at Rhakti Deï, Forest Festival, Tribes Gathering, and City Parade, just to name a few of his summer highlights.

By now Massaar has played at some of Belgium’s finest clubs and festivals; Fuse, Decadance, Cafe d’Anvers, Kompass Klub, Extrema Outdoor, Tomorrowland, … and has also been invited a few times abroad by ‘Der Hut’ & ‘Moin Moin’ in Fundbureau Hamburg.

In 2018 Massaar decided to take over the Feestgedruis concept ‘Donnerwetter’, together with his good friend and partner in crime, Ode Maen. Both well-known for their extended B2B performances.
Recently he also started experimenting with Ableton, determined to create his own sound, so keep an eye out!
''',
      nationality: "Belgium",
    ),
    Artist(
      id: 5,
      name: 'Man Outta Space',
      birthday: DateTime(2000, 5, 26),
      genre: MusicGenre.Techno,
      albums: [],
      imagePath: 'lib/images/artists/manouttaspace.jpg',
      eventIds: [1],
      nameColor: Colors.white,
      facebookURL: "https://www.facebook.com/ManOuttaSpace",
      instagramURL: "https://www.instagram.com/manouttaspace",
      soundcloudURL: "https://soundcloud.com/man-outta-space",  
      description: '''
The Belgian artist Man Outta Space has been playing music since 2005. His sets can be described as energetic Techno with spacey elements which bring constant tension to the dance floor. As a former resident of one of Belgium's longest-running clubs, Decadance, he developed his mixing skills through long marathon sets. This heavy track digger is always on the hunt to find that hidden gem in the record bin. This is also noticed in the carefully selected lineups of his event “Wir Tanzen.” There he invited highly respected acts like Dax J, Stef Mendesidis, Paula Temple, Lucy, Fjaak, Pariah, Florian Meindl, Lucy, Exium, Keith Carnal, … Man Outta Space is constantly developing his sound, combining old with new, so you never know what's coming next.

Played at: Kompass Klub - Nature One - Suicide Circus - Voltage Festival - Fuse - Stereo Club - Humboldthain - Retro Acid - Ostend Beach - De Vooruit - Club Vaag - Decadance - Café d’Anvers …
''',
      nationality: "Belgium",
    ),
  ];

  List<Artist> getArtists() {
    return artistsList.toList();
  }

  Artist? getArtistByName(String name) {
    return artistsList.firstWhere((artist) => artist.name == name);
  }

  Artist? getArtistByGenre(MusicGenre genre) {
    return artistsList.firstWhere((artist) => artist.genre == genre);
  }

  List<Artist> getArtistsByIds(List<int> artistIds) {
    return artistsList
        .where((artist) => artistIds.contains(artist.id))
        .toList();
  }

  List<Artist> getArtistsByEventId(int eventId) {
  return artistsList.where((artist) => artist.eventIds.contains(eventId)).toList();
  }

  Artist? getArtistById(int artistId) {
    return artistsList.firstWhere((artist) => artist.id == artistId);
  }

  int getEventsPlayedCount(int artistId) {
    final artist = artistsList.firstWhere((artist) => artist.id == artistId);
    return artist.events.length;
  }

  List<Event> getEventsForArtist(Artist artist) {
    List<Event> associatedEvents = [];
    for (int eventId in artist.eventIds) {
      Event? associatedEvent = watchlist.eventsListPopular.firstWhere(
        (event) => event.id == eventId,
      );
      associatedEvents.add(associatedEvent);
        }
    return associatedEvents;
  }

  List<Performance> getPerformancesForArtist(int artistId) {
    return performanceRepository.performancesList
        .where((performance) => performance.artistIds.contains(artistId))
        .toList();
  }

  List<Artist> getArtistsByPerformanceId(int performanceId) {
    Performance? performance = performanceRepository.performancesList
        .firstWhere((performance) => performance.id == performanceId);

      List<Artist> artists = getArtistsByIds(performance.artistIds);
      return artists;
  }
}
