import 'package:flutter/material.dart';
import '../models/artist.dart';
import '../pages/artist_detail_page.dart';

class CustomArtistTile extends StatelessWidget {
  final Artist artist;

  const CustomArtistTile({super.key, required this.artist});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigate to the ArtistDetailPage when the tile is tapped, passing the artist's ID
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ArtistDetailPage(artist: artist),
          ),
        );
      },
      child: Container(
        height: 180,
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(artist.imagePath),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.1), // Adjust the opacity as needed
              BlendMode.srcOver, // You can choose a different blend mode if desired
            ),
          ),
        ),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 2,
              child: _ArtistDescription(artist: artist),
            ),
          ],
        ),
      ),
    );
  }
}



class _ArtistDescription extends StatelessWidget {
  final Artist artist;

  const _ArtistDescription({required this.artist});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          artist.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: artist.nameColor, // Set the color for the artist name
          ),
          maxLines: 2, // Limit to 2 lines
          overflow: TextOverflow.ellipsis,
        ),
        const Padding(padding: EdgeInsets.symmetric(vertical: 2.0)),
      ],
    );
  }
}
