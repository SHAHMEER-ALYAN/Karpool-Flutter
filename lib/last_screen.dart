import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:geolocator/geolocator.dart';
import 'package:firebase_database/firebase_database.dart';
import 'home.dart';

Future<List<Map<String, dynamic>>> getRoutesWithZeroOrNegativeDistance() async {
  final DatabaseReference routesRef = FirebaseDatabase.instance.ref().child("Route");
  final List<Map<String, dynamic>> matchingRoutes = [];



  routesRef.onValue.listen((DatabaseEvent event)
  {final data = Map<String, dynamic>.from(event.snapshot.value! as Map<Object?, Object?>); // Access the data from the event snapshot

  matchingRoutes.add(data);
    }
    );


  final dynamic routesData = routesRef.startAt("startLat");
  if(routesData==Double){
    double num = routesData.value;
    print(num);
  }
  DataSnapshot dataSnapshot;
  try {
    dataSnapshot = (await routesRef.once()) as DataSnapshot;
  } catch (e) {
    print("Error reading data from Firebase: $e");
    return matchingRoutes;
  }

  if (dataSnapshot.value != null) {
    final dynamic routesData = dataSnapshot.value;
    if (routesData is Map<dynamic, dynamic>) {
      routesData.forEach((key, value) {
        if (value is Map<String, dynamic>) {
          final double startLatdb = value["startLat"];
          final double startLongdb = value["startLong"];
          final double endLatdb = value["endLat"];
          final double endLongdb = value["endLong"];

          final double startdistance = Geolocator.distanceBetween(
            startLatdb, startLongdb, startLat!, startLat!,
          );
          final double enddistance = Geolocator.distanceBetween(
            endLatdb, endLongdb, endLat!, endLong!,
          );

          //if (startdistance <= 10 && enddistance<= 10) {
            matchingRoutes.add(value);
          //}
        }
      });
    }
  }

  return matchingRoutes;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(lastScreen());
}

class lastScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Matching Routes'),
        ),
        body: FutureBuilder<List<Map<String, dynamic>>>(
          future: getRoutesWithZeroOrNegativeDistance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text('Error: ${snapshot.error}'),
              );
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No matching routes found.'),
              );
            } else {
              final matchingRoutes = snapshot.data;
              return ListView.builder(
                itemCount: matchingRoutes!.length,
                itemBuilder: (context, index) {
                  final route = matchingRoutes![index];
                  return ListTile(
                    title: Text('Route $index'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Start Latitude: ${route["startLatitude"]}'),
                        Text('Start Longitude: ${route["startLongitude"]}'),
                        Text('End Latitude: ${route["endLatitude"]}'),
                        Text('End Longitude: ${route["endLongitude"]}'),
                      ],
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
