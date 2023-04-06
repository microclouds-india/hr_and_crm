import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LiveLocationMap extends StatefulWidget {
  @override
  _LiveLocationMapState createState() => _LiveLocationMapState();
}

class _LiveLocationMapState extends State<LiveLocationMap> {
 late GoogleMapController _mapController;
  Location _location = Location();

  LatLng _initialCameraPosition = LatLng(0.0, 0.0);

  @override
  void initState() {
    super.initState();
    _getLocation();
  }

  void _getLocation() async {
    var currentLocation = await _location.getLocation();
    setState(() {
      _initialCameraPosition = LatLng(currentLocation.latitude!.toDouble(), currentLocation.longitude!.toDouble());
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Container(
              height: 200.0,
              width: MediaQuery.of(context).size.width,
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                  target: _initialCameraPosition,
                  zoom: 14.0,
                ),
                onMapCreated: (controller) {
                  _mapController = controller;
                },
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                markers: Set<Marker>.of([
                  Marker(
                    markerId: MarkerId("current_location"),
                    position: _initialCameraPosition,
                    infoWindow: InfoWindow(
                      title: "Current Location",
                    ),
                  ),
                ]),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}
