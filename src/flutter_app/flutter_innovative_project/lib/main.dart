import 'package:flutter/material.dart';
import 'package:flutter_innovative_project/models/watchlist.dart';
import 'package:flutter_innovative_project/pages/event_detail_page.dart';
import 'package:flutter_innovative_project/pages/intro_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Watchlist(),
      builder: (context, child) => MaterialApp(
          theme: ThemeData(
            scrollbarTheme: ScrollbarThemeData(
              thumbColor: MaterialStateProperty.all(
                  Colors.pinkAccent),
              trackColor: MaterialStateProperty.all(Colors.grey),
            ),
          ),
          debugShowCheckedModeBanner: false,
          home: const IntroPage(),
          routes: {
            '/eventDetailPage': (context) => const EventDetailPage(),
          }),
    );
  }
}