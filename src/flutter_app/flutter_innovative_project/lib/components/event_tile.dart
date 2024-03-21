import "package:flutter/material.dart";
import 'package:intl/intl.dart';

import "../models/event.dart";
import '../repositories/venue_repository.dart';

// ignore: must_be_immutable
class EventTile extends StatelessWidget {
  Event event;
  VenueRepository venueRepository = VenueRepository(); // Create an instance of VenueRepository

  EventTile({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    // Retrieve the venue address using the VenueRepository
    String venueAddress = venueRepository.getVenueAddress(event.venueId);

    return Container(
      margin: const EdgeInsets.only(left: 20),
      width: 280,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [event.mainColor.withOpacity(0.1), event.mainColor.withOpacity(0.2), event.mainColor.withOpacity(0.3)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // event image
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(12), topRight: Radius.circular(12)),
              child: Image.asset(event.imagePath)),

          // event info
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // name
                      Padding(
                        padding: const EdgeInsets.only(top: 5, right: 40),
                        child: Text(
                          event.name,
                          maxLines: 1,
                          overflow: TextOverflow
                              .ellipsis, // add "..." when text overflows
                          style: const TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 20),
                        ),
                      ),

                      Text(
                        event.genre.toString().split('.').last,
                      ),

                      const SizedBox(height: 5),

                      // event date
                      Text(
                        DateFormat('dd-MM-yyyy').format(event.startDateTime),
                        style: const TextStyle(color: Colors.grey),
                      ),

                      // event location
                      Padding(
                        padding: const EdgeInsets.only(right: 50),
                        child: Text(
                          venueAddress,
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
