import 'package:flutter/material.dart';

class EventDetailTile extends StatelessWidget {
  final String tileName;
  final Color tileColor;
  final String tileImage;
  final double borderRadius;
  final VoidCallback onTap;

  const EventDetailTile({
    Key? key,
    required this.tileName,
    required this.tileColor,
    required this.tileImage,
    this.borderRadius = 12.0,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(borderRadius),
              image: DecorationImage(
                image: AssetImage(tileImage),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.2), // Adjust the opacity as needed
                  BlendMode
                      .srcOver, // You can choose a different blend mode if desired
                ),
              )),
          child: Stack(
            children: [
              Align(
                alignment:
                    Alignment.topRight, // Align text to the top right corner
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(1),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(borderRadius),
                      topRight: Radius.circular(borderRadius),
                    ),
                  ),
                  padding: EdgeInsets.all(borderRadius),
                  child: Text(
                    tileName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
