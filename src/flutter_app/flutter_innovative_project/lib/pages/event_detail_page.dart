// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_innovative_project/models/watchlist.dart';
import 'package:flutter_innovative_project/pages/performance_page.dart';
import 'package:flutter_innovative_project/pages/ticket_page.dart';
import 'package:flutter_innovative_project/repositories/performance_repository.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../components/event_detail_tile.dart';
import '../models/event.dart';
import '../repositories/venue_repository.dart';
import 'artists_page.dart';

class EventDetailPage extends StatefulWidget {
  const EventDetailPage({Key? key}) : super(key: key);
  @override
  State<EventDetailPage> createState() => _EventDetailPageState();
}

class _EventDetailPageState extends State<EventDetailPage> {
  PerformanceRepository performanceRepository = PerformanceRepository();
  VenueRepository venueRepository = VenueRepository();
  late Event event; // Define the event variable
  List tiles = [
    [
      "Artists",
      Colors.red,
      "lib/images/tiles/artistTile.jpg",
    ],
    ["Tickets", Colors.green, "lib/images/tiles/ticketsTile.jpg"],
    ["Lineup", Colors.blue, "lib/images/tiles/lineupTile.jpg"],
    ["Venue", Colors.orange, "lib/images/tiles/venueTile.jpg"],
    ["Organisors", Colors.orange, "lib/images/tiles/organisorTile.jpg"],
  ];

  @override
  void initState() {
    super.initState();
  }

  void navigateToArtistsPage(int eventId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ArtistsPage(eventId: eventId),
      ),
    );
  }

  void navigateToTicketsPage(int eventId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return TicketPage(
          eventId: eventId,
        );
      }),
    );
  }

  void navigateToPerformancesPage(int eventId) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => PerformancesPage(
          eventId: eventId,
          performanceRepository: performanceRepository,
        ),
      ),
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Access inherited widgets or dependencies here
    event = ModalRoute.of(context)!.settings.arguments as Event;
  }

  bool isEventInWatchlist(Event event) {
    final watchlist = Provider.of<Watchlist>(context, listen: false);
    return watchlist.getEventsWatchList().contains(event);
  }

  void toggleEventInWatchlist(Event event) {
    final watchlist = Provider.of<Watchlist>(context, listen: false);

    if (isEventInWatchlist(event)) {
      watchlist.toggleEventInWatchlist(event);
    } else {
      watchlist.toggleEventInWatchlist(event);
    }
  }

  void launchGoogleMaps(double latitude, double longitude) async {
  final url = Uri.parse('https://www.google.com/maps/search/?api=1&query=$latitude,$longitude');
  if (await canLaunchUrl(url)) {
    await launchUrl(url);
  } else {
    throw 'Could not launch $url';
  }
}

  GestureDetector buildVenueAddressWithUnderline() {
    return GestureDetector(
      onTap: () {
        if (event.venue != null &&
            event.venue?.latitude != null &&
            event.venue?.longitude != null) {
          launchGoogleMaps(event.venue!.latitude!, event.venue!.longitude!);
        }
      },
      child: Text(
        venueRepository.getVenueAddress(event.venueId),
        style: const TextStyle(
          fontSize: 16,
          color: Colors.grey,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Column(
        children: [
          Container(
            height: 210,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(event.imagePath),
                fit: BoxFit.cover,
              ),
            ),
            alignment: Alignment.center,
            child: Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                  size: 30,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                padding: const EdgeInsets.only(top: 45, left: 16),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  DateFormat('dd-MM-yyyy').format(event.startDateTime),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                Text(
                  event.name,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  event.genre.toString().split('.').last,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                buildVenueAddressWithUnderline(),

                WatchlistButton(
                  event: event,
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              itemCount: tiles.length,
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
              ),
              itemBuilder: (context, index) {
                return EventDetailTile(
                  tileName: tiles[index][0],
                  tileColor: tiles[index][1],
                  tileImage: tiles[index][2],
                  onTap: () {
                    if (tiles[index][0] == "Artists") {
                      navigateToArtistsPage(event.id);
                    } else if (tiles[index][0] == "Tickets") {
                      navigateToTicketsPage(event.id);
                    } else if (tiles[index][0] == "Lineup") {
                      navigateToPerformancesPage(event.id);
                    }
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}


class WatchlistButton extends StatefulWidget {
  final Event event;
  final Color buttonColor;

  const WatchlistButton(
      {super.key, required this.event, this.buttonColor = Colors.blue});

  @override
  // ignore: library_private_types_in_public_api
  _WatchlistButtonState createState() => _WatchlistButtonState();
}

class _WatchlistButtonState extends State<WatchlistButton> {
  bool isAdded = false;
  bool isEventInFuture = true;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // check if event is in watchlist
    final watchlist = Provider.of<Watchlist>(context, listen: false);
    setState(() {
      isAdded = watchlist.getEventsWatchList().contains(widget.event);
      isEventInFuture = widget.event.startDateTime.isAfter(DateTime.now());
    });
  }

  void toggleEventInWatchlist() {
    final watchlist = Provider.of<Watchlist>(context, listen: false);
    if (isAdded) {
      // show confirmation dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Remove Event from Watchlist'),
            content: const Text(
                'Are you sure you want to remove this event from your watchlist?'),
            actions: <Widget>[
              TextButton(
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: const Text('Remove'),
                onPressed: () {
                  watchlist.toggleEventInWatchlist(widget.event);
                  setState(() {
                    isAdded = false;
                  });
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      watchlist.toggleEventInWatchlist(widget.event);
      setState(() {
        isAdded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isEventInFuture
        ? ElevatedButton(
            onPressed: toggleEventInWatchlist,
            style: ElevatedButton.styleFrom(
              backgroundColor: widget
                  .event.mainColor,
            ),
            child: Text(isAdded ? 'Remove from Watchlist' : 'Add to Watchlist'),
          )
        : const SizedBox();
  }
}
