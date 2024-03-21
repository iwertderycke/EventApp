import "package:flutter/material.dart";
import "package:flutter_innovative_project/components/bottom_navbar.dart";

import "event_page.dart";
import "profile_page.dart";
import "watchlist_page.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // selected index for navbar
  int _selectedIndex = 0;

  // update selected index when tapping on bottom navbar
  void navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  // pages to display
  final List<Widget> _pages = [
    // event page
    const EventPage(),

    // watchlist page
    const WatchlistPage(),

    // profile page
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      bottomNavigationBar: BottomNavBar(
        onTabChange: (index) => navigateBottomBar(index),
      ),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(
              Icons.menu,
              color: Colors.black,
            ),
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
          ),
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.grey[900],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
          Column(
            children: [
              // image
              DrawerHeader(
                child: Image.asset(
                  'lib/images/Logo-square.jpg',
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Divider(color: Colors.grey[800]),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.pinkAccent,
                  ),
                  title: Text(
                    'Home',
                    style: TextStyle(color: Colors.pinkAccent),
                  ),
                ),
              ),

              const Padding(
                padding: EdgeInsets.only(left: 25),
                child: ListTile(
                  leading: Icon(
                    Icons.info,
                    color: Colors.pinkAccent,
                  ),
                  title: Text(
                    'About',
                    style: TextStyle(color: Colors.pinkAccent),
                  ),
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(left: 25, bottom: 25),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Colors.pinkAccent,
              ),
              title: Text(
                'Logout',
                style: TextStyle(color: Colors.pinkAccent),
              ),
            ),
          ),
        ]),
      ),
      body: _pages[_selectedIndex],
    );
  }
}
