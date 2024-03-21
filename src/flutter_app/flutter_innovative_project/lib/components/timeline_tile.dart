import 'package:flutter/material.dart';
import 'package:flutter_innovative_project/components/event_card.dart';
import 'package:timeline_tile/timeline_tile.dart';

class CustomTimelineTile extends StatelessWidget {
  final bool isFirst;
  final bool isLast;
  final bool isPast;
  final bool isLive;
  // ignore: prefer_typing_uninitialized_variables
  final eventCard;

  const CustomTimelineTile({
    Key? key,
    required this.isFirst,
    required this.isLast,
    required this.isPast,
    required this.isLive,
    required this.eventCard,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: TimelineTile(
        isFirst: isFirst,
        isLast: isLast,
        // line styling
        beforeLineStyle: LineStyle(
          color: isLive ? Colors.pinkAccent : (isPast ? Colors.black : Colors.grey),
        ),
        // icon styling
        indicatorStyle: IndicatorStyle(
          width: 40,
          color: isLive ? Colors.pinkAccent : (isPast ? Colors.black : Colors.grey),
          iconStyle: IconStyle(
            iconData: isLive ? Icons.timer : Icons.done,
            color: isLive ? Colors.white : (isPast ? Colors.pinkAccent : Colors.grey),
          ),
        ),
        endChild: EventCard(
          isPast: isPast,
          isLive: isLive,
          isFirst: isFirst,
          isLast: isLast,
          child: eventCard,
        ),
      ),
    );
  }
}
