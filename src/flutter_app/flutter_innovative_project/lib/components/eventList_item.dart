import 'package:flutter/material.dart';
import 'package:flutter_innovative_project/components/custom_eventlist_list_item.dart';
import 'package:intl/intl.dart';
import '../models/event.dart';

class EventListItem extends StatefulWidget {
  final Event event;
  const EventListItem({super.key, required this.event});

  @override
  State<EventListItem> createState() => _EventListItemState();
}

class _EventListItemState extends State<EventListItem> {
  void navigateToEventDetail() {
    Navigator.pushNamed(context, '/eventDetailPage', arguments: widget.event);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateToEventDetail, // Handle navigation on tap
      child: CustomEventlistListItem(
        image: Image.asset(
          widget.event.imagePath,
        ),
        title: widget.event.name,
        location: widget.event.location,
        mainColor: widget.event.mainColor,
        date: DateFormat('dd-MM-yyyy').format(widget.event.startDateTime),
      ),
    );
  }
}
