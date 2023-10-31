import 'dart:async';
import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(const GeolocatorApp());
}

class GeolocatorApp extends StatelessWidget {
  const GeolocatorApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationStreamPage(),
    );
  }
}

class LocationStreamPage extends StatefulWidget {
  const LocationStreamPage({Key? key}) : super(key: key);

  @override
  _LocationStreamPageState createState() => _LocationStreamPageState();
}

class _LocationStreamPageState extends State<LocationStreamPage> {
  StreamSubscription<Position>? _positionStreamSubscription;
  bool positionStreamStarted = false;
  Position? currentLocation;

  @override
  void initState() {
    super.initState();
    _toggleListening();
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel(); // Cancel the stream subscription in dispose
    super.dispose();
  }

  void _toggleListening() {
    if (_positionStreamSubscription == null) {
      final positionStream = Geolocator.getPositionStream( locationSettings: AndroidSettings(accuracy: LocationAccuracy.high,
        distanceFilter: 100,
        forceLocationManager: true,
        intervalDuration: const Duration(seconds: 10),),
      );
      _positionStreamSubscription = positionStream.listen((position) {
        setState(() {
          currentLocation = position;
        });
      });
    } else {
      if (_positionStreamSubscription!.isPaused) {
        _positionStreamSubscription!.resume();
      } else {
        _positionStreamSubscription!.pause();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Streaming'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            currentLocation != null
                ? Text(
                    "Latitude: ${currentLocation!.latitude}, Longitude: ${currentLocation!.longitude}",
                    style: TextStyle(fontSize: 20),
                  )
                : Text(
                    "Location data not available",
                    style: TextStyle(fontSize: 20),
                  ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                positionStreamStarted = !positionStreamStarted;
                _toggleListening();
              },
              child: Text(positionStreamStarted ? 'Pause' : 'Start Streaming'),
            ),
          ],
        ),
      ),
    );
  }
}
