import 'package:flutter/material.dart';
import 'package:flutter_innovative_project/components/custom_watchlist_list_item.dart';
import 'package:flutter_innovative_project/models/watchlist.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/event.dart';

class WatchlistItem extends StatefulWidget {
  final Event event;
  const WatchlistItem({super.key, required this.event});

  @override
  State<WatchlistItem> createState() => _WatchlistItemState();
}

class _WatchlistItemState extends State<WatchlistItem> {
  void toggleEventInWatchlist() {
    Provider.of<Watchlist>(context, listen: false).toggleEventInWatchlist(widget.event);
  }

  void navigateToEventDetail() {
    Navigator.pushNamed(context, '/eventDetailPage', arguments: widget.event);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: navigateToEventDetail, // Handle navigation on tap
      child: Container(
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.only(bottom: 10),
        child: CustomWatchlistListItem(
          image: Image.asset(
            widget.event.imagePath,
          ),
          title: widget.event.name,
          location: widget.event.location,
          mainColor: widget.event.mainColor,
          date: DateFormat('dd-MM-yyyy').format(widget.event.startDateTime),
        ),
      ),
    );
  }
}
