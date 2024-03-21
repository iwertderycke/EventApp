import "package:flutter/material.dart";
import "package:flutter_innovative_project/models/watchlist.dart";
import "package:provider/provider.dart";
import "../components/watchlist_item.dart";
import "../models/event.dart";

class WatchlistPage extends StatefulWidget {
  const WatchlistPage({super.key});

  @override
  State<WatchlistPage> createState() => _WatchlistPageState();
}

class _WatchlistPageState extends State<WatchlistPage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Watchlist>(
      builder: (context, value, child) => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // title
            const Text(
              'Watchlist',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: value.getEventsWatchList().length,
                itemBuilder: (context, index) {
                  // get event
                  Event event = value.getEventsWatchList()[index];

                  //return the event
                  return WatchlistItem(
                    event: event,
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
