import 'package:flutter/material.dart';

class CustomEventlistListItem extends StatelessWidget {
  const CustomEventlistListItem({
    Key? key,
    required this.image,
    required this.title,
    required this.location,
    required this.date,
    required this.mainColor,
  }) : super(key: key);

  final Widget image;
  final String title;
  final String location;
  final String date;
  final Color mainColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: ClipRRect(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [mainColor.withOpacity(0.1), mainColor.withOpacity(0.3), mainColor.withOpacity(0.8)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          margin: const EdgeInsets.only(bottom: 0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: image,
              ),
              Expanded(
                flex: 3,
                child: _EventDescription(
                  title: title,
                  location: location,
                  date: date,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventDescription extends StatelessWidget {
  const _EventDescription({
    required this.title,
    required this.location,
    required this.date,
  });

  final String title;
  final String location;
  final String date;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5.0, 5.0, 10.0, 0.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Align(
            alignment: Alignment.topLeft,
            child: Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 14.0,
              ),
              maxLines: 2, // limit to 2 lines
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              location,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Text(
              date,
              style: const TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );
  }
}
