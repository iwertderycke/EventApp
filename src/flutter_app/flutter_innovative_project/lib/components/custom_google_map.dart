import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_innovative_project/models/event.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class GoogleMapsWidget extends StatefulWidget {
  final List<Event> events;

  const GoogleMapsWidget({Key? key, required this.events}) : super(key: key);

  @override
  State<GoogleMapsWidget> createState() => MapSampleState();
}

class MapSampleState extends State<GoogleMapsWidget> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  late Set<Marker> _markers;
  late CameraPosition _initialCameraPosition =
      const CameraPosition(target: LatLng(50.8503, 4.3517), zoom: 7.0);

  @override
  void initState() {
    super.initState();
    _markers = Set();
    _requestLocationPermission();
  }

  Future<void> _requestLocationPermission() async {
    final status = await Permission.location.request();

    if (status == PermissionStatus.granted) {
      _setupCameraPosition();
    }
  }

  void _setupCameraPosition() async {
    Position position = await Geolocator.getCurrentPosition();

    setState(() {
      _initialCameraPosition = CameraPosition(
        target: LatLng(position.latitude, position.longitude),
        zoom: 14.0,
      );

      // Call _setupMarkers after obtaining location permission
      _markers = _setupMarkers(widget.events);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      mapType: MapType.normal,
      initialCameraPosition: _initialCameraPosition,
      markers: _markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Set<Marker> _setupMarkers(List<Event> events) {
    Set<Marker> markers = Set();

    for (Event event in events) {
      if (event.venue != null) {
        markers.add(Marker(
          markerId: MarkerId(event.id.toString()),
          position: LatLng(
            event.venue!.latitude!,
            event.venue!.longitude!,
          ),
          infoWindow: InfoWindow(
            title: event.name,
            snippet: event.location,
          ),
        ));
      }
    }

    return markers;
  }
}
