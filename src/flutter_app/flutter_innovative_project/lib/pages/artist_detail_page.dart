// ignore: file_names
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../models/artist.dart';
import '../models/event.dart';
import '../repositories/artist_repository.dart';

class ArtistDetailPage extends StatelessWidget {
  final Artist artist;
  final ArtistRepository artistRepository = ArtistRepository();

  ArtistDetailPage({super.key, required this.artist});

  int calculateAge(DateTime? birthday) {
    if (birthday == null) return 0;

    final now = DateTime.now();
    final age = now.year -
        birthday.year -
        ((now.month > birthday.month ||
                (now.month == birthday.month && now.day >= birthday.day))
            ? 0
            : 1);
    return age;
  }

  void _launchURL(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Event> artistEvents = artistRepository.getEventsForArtist(artist);

    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 450,
            backgroundColor: Colors.black,
            flexibleSpace: FlexibleSpaceBar(
              collapseMode: CollapseMode.pin,
              background: Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(artist.imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.bottomRight,
                      colors: [Colors.black, Colors.black.withOpacity(.3)],
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          artist.name,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              "${artistEvents.length} Event(s)",
                              style: const TextStyle(
                                  color: Colors.grey, fontSize: 16),
                            ),
                            const SizedBox(
                              width: 50,
                            ),
                            const Text(
                              "240K Subscribers",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        if (artist.instagramURL.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              _launchURL(artist.instagramURL);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: 15),
                              child: const Icon(
                                FontAwesomeIcons.instagram,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        if (artist.facebookURL.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              _launchURL(artist.facebookURL);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: 15),
                              child: const Icon(
                                FontAwesomeIcons.facebook,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                        if (artist.soundcloudURL.isNotEmpty)
                          GestureDetector(
                            onTap: () {
                              _launchURL(artist.soundcloudURL);
                            },
                            child: Container(
                              margin: const EdgeInsets.only(
                                  right: 15),
                              child: const Icon(
                                FontAwesomeIcons.soundcloud,
                                color: Colors.white,
                                size: 30,
                              ),
                            ),
                          ),
                      ],
                    ),

                    const SizedBox(height: 20),
                    Text(
                      artist.description,
                      style: const TextStyle(color: Colors.grey, height: 1.4),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "Age",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      calculateAge(artist.birthday).toString(),
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Nationality",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      artist.nationality,
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text(
                      "Played at",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: artistEvents
                            .map((event) => makeEvent(context, event))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget makeEvent(BuildContext context, Event event) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/eventDetailPage', arguments: event);
      },
      child: AspectRatio(
        aspectRatio: 1.5 / 1,
        child: Container(
          margin: const EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
              image: AssetImage(event.imagePath),
              fit: BoxFit.cover,
            ),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomRight,
                colors: [
                  Colors.black.withOpacity(.2),
                  Colors.black.withOpacity(.2)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
