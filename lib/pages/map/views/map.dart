import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_demo_getx/commons/constants.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:intl/intl.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Map extends StatefulWidget {
  @override
  _MapState createState() => _MapState();
}

class _MapState extends State<Map> {
  LocationData? _currentPosition;
  String? _address, _dateTime;
  Marker? marker;
  Location location = Location();
  StreamSubscription<LocationData>? locationSubscription;

  GoogleMapController? _controller;
  LatLng _initialcameraposition = LatLng(0.5937, 0.9629);
  LatLng _currentMapPosition = LatLng(0.5937, 0.9629);

  MapType _currentMapType = MapType.normal;

  @override
  void initState() {
    super.initState();
    getLoc();
  }

  @override
  void dispose() {
    _controller!.dispose();
    locationSubscription!.cancel();
    super.dispose();
  }

  void _onMapTypeButtonPressed() {
    setState(() {
      _currentMapType = _currentMapType == MapType.normal
          ? MapType.satellite
          : MapType.normal;
    });
  }

  void _onCameraMove(CameraPosition position) {
    _currentMapPosition = position.target;
  }

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    // location.onLocationChanged.listen((l) {
    //   _controller!.animateCamera(
    //     CameraUpdate.newCameraPosition(
    //       CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
    //     ),
    //   );
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Maps Demo'),
        backgroundColor: defaultBgColor,
        leading: GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Icon(Icons.arrow_back, color: Colors.white),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/bg.png'), fit: BoxFit.cover),
        ),
        child: SafeArea(
          child: Container(
            color: Colors.blueGrey.withOpacity(.8),
            child: Center(
              child: Stack(children: [
                Positioned.fill(
                  child: Column(
                    children: [
                      Expanded(
                        child: GoogleMap(
                            initialCameraPosition: CameraPosition(
                                target: _initialcameraposition, zoom: 15),
                            mapType: _currentMapType,
                            onMapCreated: _onMapCreated,
                            myLocationEnabled: true,
                            onCameraMove: _onCameraMove),
                      ),
                      SizedBox(
                        height: 3,
                      ),
                      if (_dateTime != null)
                        Text(
                          "Date/Time: $_dateTime",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.white,
                          ),
                        ),
                      SizedBox(
                        height: 3,
                      ),
                      if (_currentPosition != null)
                        Text(
                          "Latitude: ${_currentPosition?.latitude}, Longitude: ${_currentPosition?.longitude}",
                          style: TextStyle(
                              fontSize: defaultFontSize,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                        ),
                      SizedBox(
                        height: 3,
                      ),
                      if (_address != null)
                        Text(
                          "Address: $_address",
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      SizedBox(
                        height: 3,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: FloatingActionButton(
                      onPressed: _onMapTypeButtonPressed,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      backgroundColor: defaultBgColor,
                      child: const Icon(
                        Icons.map,
                        size: 30.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ),
        ),
      ),
    );
  }

  getLoc() async {
    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    _currentPosition = await location.getLocation();
    _initialcameraposition =
        LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);
    locationSubscription =
        location.onLocationChanged.listen((LocationData currentLocation) {
      print("${currentLocation.latitude} : ${currentLocation.longitude}");
      setState(() {
        _currentPosition = currentLocation;
        _initialcameraposition =
            LatLng(_currentPosition!.latitude!, _currentPosition!.longitude!);

        DateTime now = DateTime.now();
        _dateTime = DateFormat('EEE d MMM kk:mm:ss ').format(now);
      });
    });
  }
}
