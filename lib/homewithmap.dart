import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(MapScreen());
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late double latitude;
  late double longitude;
  late LatLng currentLocation = LatLng(0, 0);

  @override
  void initState() {
    super.initState();
    _checkLocationPermission();
  }

  Future<void> _checkLocationPermission() async {
    final PermissionStatus status = await Permission.location.request();

    if (status.isGranted) {
      _getCurrentLocation();
    } else {
      // Handle the case where the user denies location permission
      print('Location permission denied');
    }
  }

  Future<void> _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    setState(() {
      latitude = position.latitude;
      longitude = position.longitude;
      currentLocation = LatLng(latitude, longitude);
    });
  }

  Widget map(){
    return Column(
      children: [
        Container(
          child: GoogleMap(
              initialCameraPosition: CameraPosition(
              target: LatLng(24.86, 67.19)
              )
          ),
        ),
      ],
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height/2,
        width: MediaQuery.of(context).size.width,
        child: GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(24.86,67.19),
            zoom: 15,
          ),
          markers: {
            Marker(
              markerId: const MarkerId("marker1"),
              position: const LatLng(24.8674,67.1962),
              draggable: true,
              onDragEnd: (value){
                // locationTesting1 = value;
              }
            ),
            const Marker(
              markerId: MarkerId("marker2"),
              position: LatLng(24.8674,67.1962),
            )
          },
        ),
      ),
    );
  }
}
