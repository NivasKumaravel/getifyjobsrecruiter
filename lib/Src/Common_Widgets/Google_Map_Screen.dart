import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:getifyjobs/Src/utilits/Generic.dart';
import 'package:location/location.dart';
import 'dart:async';

import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';





class MapScreen extends StatefulWidget {

  LatLng currentLocation; // Initial location (Chennai, Tamil Nadu)
  LatLng markerLocation;

  MapScreen({super.key,required this.currentLocation,required this.markerLocation});
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  GoogleMapController? _controller;
  Set<Marker> _markers = {};

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      _controller = controller;
      _markers.add(
        Marker(
          markerId: MarkerId('currentLocation'),
          position: widget.currentLocation,
          draggable: true,
          onDragEnd: _onMarkerDragEnd,
        ),
      );
    });
  }

  void _onMarkerDragEnd(LatLng newLocation) {
    setState(() {
      widget.currentLocation = newLocation;
      SingleTon().locationLat = newLocation;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Move Marker on Map'),
      ),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: widget.currentLocation,
          zoom: 15.0,
        ),
        markers:  Set.of([
          Marker(
            markerId: MarkerId('markerId'),
            position: widget.markerLocation,
            draggable: true,
            onDragEnd: (newPosition) {
              setState(() {
                widget.markerLocation = newPosition;
              });
            },
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        ]),
      ),
    );
  }
}



