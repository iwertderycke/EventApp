import 'package:flutter/material.dart';
import '../components/custom_artist_list_item.dart';
import '../models/artist.dart';
import '../models/watchlist.dart';
import '../repositories/artist_repository.dart';

class ArtistsPage extends StatefulWidget {
  final int? eventId;
  final int? performanceId;

  const ArtistsPage({
    Key? key,
    this.eventId,
    this.performanceId,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ArtistsPageState createState() => _ArtistsPageState();
}

class _ArtistsPageState extends State<ArtistsPage> {
  List<Artist> artists = [];

  @override
  void initState() {
    super.initState();
    if (widget.eventId != null) {
      artists = ArtistRepository().getArtistsByEventId(widget.eventId!);
    } else if (widget.performanceId != null) {
      artists = ArtistRepository().getArtistsByPerformanceId(widget.performanceId!);
    }
  }

  @override
  Widget build(BuildContext context) {
    String pageTitle = 'Artists';

    if (widget.eventId != null) {
      pageTitle = Watchlist().getEventNameById(widget.eventId!);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(pageTitle, style: const TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: ListView.builder(
        itemCount: artists.length,
        itemBuilder: (context, index) {
          return CustomArtistTile(artist: artists[index]);
        },
      ),
    );
  }
}
