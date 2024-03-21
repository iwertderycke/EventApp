import 'package:flutter/material.dart';

class EventCard extends StatelessWidget {
  final bool isPast;
  final bool isLive;
  final bool isFirst;
  final bool isLast;
  final Widget child;

  const EventCard({
    Key? key,
    required this.isPast,
    required this.isLive,
    required this.isFirst,
    required this.isLast,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      margin: EdgeInsets.only(
        left: 10,
        bottom: isLast? 0 : 8,
        ),
      padding: const EdgeInsets.all(0),
      decoration: BoxDecoration(
        color: isLive ? Colors.pinkAccent : (isPast ? Colors.black : Colors.grey),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(isFirst ? 0.0 : 8.0),
          bottomLeft: Radius.circular(isLast? 0.0 : 8),
        ),
      ),
      child: child,
    );
  }
}
