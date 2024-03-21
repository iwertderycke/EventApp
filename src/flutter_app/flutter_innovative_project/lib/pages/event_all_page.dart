import 'package:flutter/material.dart';
import 'package:flutter_innovative_project/components/custom_google_map.dart';
import 'package:flutter_innovative_project/components/eventlist_item.dart';
import 'package:flutter_innovative_project/models/event.dart';
import 'package:flutter_innovative_project/models/watchlist.dart';

class AllEventsPage extends StatefulWidget {
  final Watchlist watchlist;

  const AllEventsPage({Key? key, required this.watchlist}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _AllEventsPageState createState() => _AllEventsPageState();
}

enum EventFilter { all, today, upcoming, past, maps }

class _AllEventsPageState extends State<AllEventsPage> {
  late List<Event> allEvents;
  EventFilter currentFilter = EventFilter.all;

  @override
  void initState() {
    super.initState();
    allEvents = widget.watchlist.getEventsList();
  }

  List<Event> _getFilteredEvents() {
    DateTime now = DateTime.now();

    switch (currentFilter) {
      case EventFilter.all:
        return allEvents;
      case EventFilter.upcoming:
        return allEvents.where((event) => event.startDateTime.isAfter(now)).toList();
      case EventFilter.past:
        return allEvents.where((event) => event.endDateTime.isBefore(now)).toList();
      case EventFilter.today:
        return allEvents.where((event) => _isSameDay(event.startDateTime, now)).toList();
      case EventFilter.maps:
        return allEvents;
    }
  }

  bool _isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }

  String _getAppBarTitle() {
    switch (currentFilter) {
      case EventFilter.all:
        return 'All Events';
      case EventFilter.upcoming:
        return 'Upcoming Events';
      case EventFilter.past:
        return 'Past Events';
      case EventFilter.today:
        return "Today's Events";
      case EventFilter.maps:
        return 'Events on map';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    List<Event> filteredEvents = _getFilteredEvents();

    return Scaffold(
      appBar: AppBar(
        title: Text(_getAppBarTitle(), style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Stack(
        children: [
          if (currentFilter == EventFilter.maps)
            GoogleMapsWidget(events: allEvents),

          if (currentFilter != EventFilter.maps)
            SingleChildScrollView(
              child: Column(
                children: filteredEvents.map((event) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, '/eventDetailPage', arguments: event);
                    },
                    child: EventListItem(
                      event: event,
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All Events',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.today),
            label: "Today's Events",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_forward),
            label: 'Upcoming',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.arrow_back),
            label: 'Past',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Maps',
          ),
        ],
        currentIndex: currentFilter.index,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          setState(() {
            currentFilter = EventFilter.values[index];
          });
        },
      ),
    );
  }
}
