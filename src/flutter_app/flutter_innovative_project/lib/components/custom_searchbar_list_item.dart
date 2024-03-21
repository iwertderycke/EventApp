import 'package:flutter/material.dart';

class CustomSearchbarListItem extends StatelessWidget {
  const CustomSearchbarListItem({super.key, 
    required this.image,
    required this.title,
    required this.date,
  });

  final Widget image;
  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        InkWell(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 1,
                child: image,
              ),
              Expanded(
                flex: 2,
                child: _EventDescription(
                  title: title,
                  date: date,
                ),
              ),
            ],
          ),
        ),
        Container(
          height: 1.0, // Adjust the height as needed
          color: Colors.grey[400], // Customize the color as needed
        ),
      ],
    );
  }
}


class _EventDescription extends StatelessWidget {
  const _EventDescription({
    required this.title,
    required this.date,
  });

  final String title;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 0.0),
      child: Column(
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              maxLines: 2, // Limit to 2 lines
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              date,
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 12,
                ),
            ),
          ),
        ],
      ),
    );
  }
}

