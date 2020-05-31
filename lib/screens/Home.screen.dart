import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => HomeState();

}

class HomeState extends State<Home> {
  GoogleMapController mapController;
  Location _location = Location();
  LocationData _locationData;
  Map<MarkerId, Marker> markers = <MarkerId, Marker>{};

  getLocation() async{
    final MarkerId markerId = MarkerId('0');

    _location.onLocationChanged.listen((LocationData currentLocation) {
      final Marker marker = Marker(
        markerId: markerId,
        position: LatLng(
          currentLocation.latitude,
          currentLocation.longitude,
        ),
      );
      LatLng latLng = LatLng(currentLocation.latitude, currentLocation.longitude);
      CameraUpdate cameraUpdate = CameraUpdate.newLatLngZoom(latLng, 15);
      mapController.animateCamera(cameraUpdate);
      setState(() {
        this._locationData = currentLocation;
        markers[markerId] = marker;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: Stack(
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            mapToolbarEnabled: true,
            zoomControlsEnabled: false,
            myLocationButtonEnabled: false,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(this._locationData?.latitude ?? 6.7008168, this._locationData?.longitude ?? -1.6998494),
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              setState(() {
                mapController = controller;
              });
            },
            markers: Set<Marker>.of(markers.values),
          ),
          Positioned(
            child: Container(
              padding: EdgeInsets.all(30),
              color: Colors.white,
              child: Text("LAT: ${this._locationData?.latitude ?? 0}  LONG: ${this._locationData?.longitude ?? 0}"),
            ),
          )
        ],
      ),
    );
  }
}
