import "package:flutter/material.dart";
import "package:flutter_innovative_project/components/custom_searchbar_list_item.dart";
import "package:flutter_innovative_project/models/watchlist.dart";
import 'package:flutter_innovative_project/pages/event_all_page.dart';
import "package:intl/intl.dart";
import "package:provider/provider.dart";

import "../components/event_tile.dart";
import "../models/event.dart";

class EventPage extends StatefulWidget {
  const EventPage({super.key});

  @override
  State<EventPage> createState() => _EventPageState();
}

class _EventPageState extends State<EventPage> {
  List<Event> filteredEventsList = [];
  String query = '';

  final TextEditingController _textEditingController = TextEditingController();

  void toggleEventInWatchlist(Event event) {
    Provider.of<Watchlist>(context, listen: false)
        .toggleEventInWatchlist(event);

    final isAdded = Provider.of<Watchlist>(context, listen: false)
        .getEventsWatchList()
        .contains(event);

    final DateTime currentDate = DateTime.now();

    if (event.startDateTime.isAfter(currentDate)) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            isAdded
                ? 'Successfully added event to watchlist!'
                : 'Successfully removed event from watchlist!',
          ),
          content: const Text('Check your watchlist'),
        ),
      );
    } else {
      // The event has already passed, so you can display a message to the user.
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Event has already passed!'),
          content: Text(
              'You cannot add an event that has already passed to your watchlist.'),
        ),
      );
    }
  }

  void searchEvent(String query) {
    final watchlist = Provider.of<Watchlist>(context, listen: false);

    final trimmedQuery = query.trim();

    if (trimmedQuery.isEmpty) {
      setState(() {
        filteredEventsList = [];
      });
    } else {
      final filteredEvents = watchlist.searchEvent(trimmedQuery);

      filteredEvents.sort((a, b) => a.startDateTime.compareTo(b.startDateTime));

      setState(() {
        filteredEventsList = filteredEvents;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    bool hasFilteredEvents = filteredEventsList.isNotEmpty;

    return SingleChildScrollView(
      child: Consumer<Watchlist>(
        builder: (context, value, child) => Column(
          children: [
            //search bar
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.search,
                    color: Colors.pinkAccent.withOpacity(0.8),
                  ),
                  suffixIcon: Visibility(
                    visible: query.isNotEmpty,
                    child: IconButton(
                      icon: const Icon(
                        Icons.clear,
                        color: Colors.pinkAccent,
                      ),
                      onPressed: () {
                        setState(() {
                          query = '';
                          _textEditingController.text = '';
                        });
                        searchEvent('');
                      },
                    ),
                  ),
                  hintText: 'Search event',
                  focusedBorder: hasFilteredEvents
                      ? OutlineInputBorder(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                          borderSide: BorderSide(
                            color: Colors.pinkAccent.withOpacity(0.5),
                          ),
                        )
                      : OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide(
                            color: Colors.pinkAccent.withOpacity(0.5),
                          ),
                        ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
                cursorColor: Colors.pinkAccent,
                onChanged: (newQuery) {
                  setState(() {
                    query = newQuery;
                  });
                  searchEvent(newQuery);
                },
              ),
            ),
            // searchbar items
            Visibility(
              visible: filteredEventsList.isNotEmpty,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(
                          width: 1.0,
                          color: Colors.pinkAccent.withOpacity(0.5)),
                      bottom: BorderSide(
                          width: 1.0,
                          color: Colors.pinkAccent.withOpacity(0.5)),
                      right: BorderSide(
                          width: 1.0,
                          color: Colors.pinkAccent.withOpacity(0.5)),
                    ),
                  ),
                  child: Container(
                    height: 4 *
                        35, // Set ITEM_HEIGHT to the desired height of each item
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.blue.withOpacity(0.25),
                          Colors.pinkAccent.withOpacity(0.25),
                        ],
                        // Define your gradient colors here
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                    ),
                    child: Scrollbar(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: filteredEventsList.length,
                        itemBuilder: (context, index) {
                          final event = filteredEventsList[index];
                          return GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, '/eventDetailPage',
                                  arguments: event);
                            },
                            child: CustomSearchbarListItem(
                              image: Image.asset(
                                event.imagePath,
                                fit: BoxFit.cover,
                                width: 80,
                              ),
                              title: event.name,
                              date: DateFormat('dd-MM-yyyy').format(event.startDateTime),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // popular events
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Popular events',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllEventsPage(watchlist: value)),
                      );
                    },
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // list of events
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: value.getEventsList().map((event) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/eventDetailPage',
                            arguments: event);
                      },
                      child: EventTile(
                        event: event,
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Divider(
                color: Colors.white,
              ),
            ),

            const SizedBox(height: 10),

            // upcoming events
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Popular events',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AllEventsPage(watchlist: value)),
                      );
                    },
                    child: const Align(
                      alignment: Alignment.center,
                      child: Text(
                        'See All',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 10),

            // list of events
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: value.getEventsList().map((event) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: EventTile(
                      event: event,
                    ),
                  );
                }).toList(),
              ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 15, left: 20, right: 20),
              child: Divider(
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
