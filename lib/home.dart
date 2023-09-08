import 'dart:core';

import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'location_screen.dart';
import 'package:flutter/material.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";
import "main.dart";
import "package:toggle_switch/toggle_switch.dart";
import 'last_screen.dart';

void main() {
  runApp(home());
}
var startLocationCo;
var endLocationCo;
TextEditingController startlocation = TextEditingController();
TextEditingController endlocation = TextEditingController();

// double startLat = 24.8674;
// double startLong = 67.1962;
double? startLat; // Set your default latitude value here
double? startLong;
String? startName;
double? endLat;
double? endLong;
String? endName;
bool passenger=true;
bool marker1Visibility= false;



Marker m1 = Marker(
markerId: MarkerId("marker1"),
position: LatLng(24.8674, 67.32),
draggable: false,
visible: true,
icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
);

Marker m2 = Marker(
  markerId: MarkerId("marker2"),
  position: LatLng(24.8674, 67.2),
  draggable: false,
  visible: false,
  icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
);

Polyline p1 = Polyline(
polylineId: PolylineId("poly"),
points: [LatLng(24.8674,67.32),LatLng(24.8674, 67.22)],
visible: false,
// patterns: [PatternItem.dot],
geodesic: true,
width: 4,
color: hexToColor("#1E847F"),);



Future<String?> getUserIdFromStorage() async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getString('userId');
}

String IDID = getUserIdFromStorage() as String;

LatLng locationTesting1 = LatLng(24.8674, 67.1962);


class home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),

    );
  }
}

class MyHomePage extends StatefulWidget {
  static const String idScreen = "MainScreen";
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  Set<Polyline> polylines = {};
  bool showSecondBox = false;
  int _currentIndex = 0;

  locationStarter() async {
    if (startLat == null || startLong == null) {
      Position current = await Geolocator.getCurrentPosition();
      startLat = current.latitude;
      startLong = current.longitude;
      // return LatLng(startLat!, startLong!);
    }
  }

  // @override
  // void initState(){
  //   var marker1;
  //   markers = [
  //     Marker(markerId: marker1,
  //     position: )
  //   ];
  // }


  @override
  Widget build(BuildContext context) {
    final location = ModalRoute
        .of(context)!
        .settings
        .arguments;
    locationStarter();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Map(context),
            modeSelector(),
            locationBox(context),
            // MapScreen()
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: hexToColor("#1E847F"),
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile'
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'Book',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }


// _addPolyLine() {
//       PolylineId id = PolylineId("poly");
//       Polyline polyline = Polyline(
//       polylineId: id, color: hexToColor("#1E847F"), points: [locationTesting1]);
//       polylines[id] = polyline;
// }

  void updatePolyLine(double sLat,double sLong,double eLat,double eLong){

    if(sLat != null && sLong != null && eLat != null && eLong != null){
      print("checking before set state");
      setState(() {


      p1 = p1.copyWith(pointsParam: [LatLng(sLat, sLong),LatLng(eLat, eLong)],
      visibleParam: true);
      });
    }
    else{
      print("checking after ^^^^6 set state");
    }

  }

  void updateMarkerPositionM1(double lat, double long) {
    print('Updating marker position M1 to lat: $lat, long: $long');
    setState(() {
      m1 = m1.copyWith(positionParam: LatLng(lat, long),
      visibleParam: true);
    });
    print('Marker M1 position updated');
  }

  void updateMarkerPositionM2(double lat, double long) {
    print("%%%%%%%%%%%%%%%%%%%%%%%");
    setState(() {
      m2 = m2.copyWith(positionParam: LatLng(lat, long),
          visibleParam: true);
    });
  }
  Widget Map(context) {


    return Expanded(
      child: Container(
        height: MediaQuery
            .of(context)
            .size
            .height / 2,
        width: MediaQuery
            .of(context)
            .size
            .width,
        child: GoogleMap(
          myLocationEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(24.8674, 67.1962),
            zoom: 15,
          ),
          // *****

            polylines: {
            p1

          },
          // ********
          markers: {m1,m2}
            // Marker(
            //   markerId: MarkerId("marker1"),
            //   position: LatLng(24.8674, 67.2),
            //   draggable: false,
            //   visible: marker1Visibility,
            //   icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            //     ),
            // Marker(
            //   markerId: MarkerId("marker2"),
            //   position: LatLng(24.8674, 67.1962),
            //   icon: BitmapDescriptor.defaultMarkerWithHue(
            //       BitmapDescriptor.hueGreen),
            // )

        ),
      ),
    );
  }


  Container locationBox(context) {
    return Container(
      decoration: BoxDecoration(
        color: hexToColor("#1E1E1E"),
      ),
      child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            child: Row(
              children: [
                Padding(padding: EdgeInsets.all(10),
                  child: Icon(Icons.location_pin, color: Colors.red,)
                  ,),
                Expanded(
                    child: TextField(
                      showCursor: true,
                      readOnly: true,
                      // autofocus: false,
                      controller: startlocation,
                      style: TextStyle(
                          color: Colors.white
                      ),
                      decoration: InputDecoration(
                        // enabled: false,
                          hintText: "Start Location",
                          hintStyle: TextStyle(
                              color: Colors.grey
                          )
                      ),
                      onTap: () async {
                        startLocationCo = await Navigator.push(context,
                            MaterialPageRoute(
                                builder: (context) => LocationScreen()));
                        print("*** startlocation = ${startLocationCo} ***");
                        startLat = double.parse(startLocationCo[0]);
                        startLong = double.parse(startLocationCo[1]);
                        startName = startLocationCo[2];
                        if (startName != null) {
                          print(
                              "!!!!!!!!!! ${startName} ==== ${startLat} ${startLong}======}");
                          startlocation.text = startName!;
                          // print(IDID);
                          // m1 = m1.copyWith(positionParam: LatLng(startLat!, startLong!),visibleParam: true);
                          updateMarkerPositionM1(startLat!, startLong!);
                          updatePolyLine(startLat!, startLong!, endLat!, endLong!);
                        }
                      },
                    )
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          Container(
            child: Row(
              children: [
                Padding(padding: EdgeInsets.all(10),
                  child: Icon(Icons.location_pin, color: Colors.green,)
                  ,),
                Expanded(child: TextField(
                  showCursor: true,
                  readOnly: true,
                  controller: endlocation,
                  style: TextStyle(
                      color: Colors.white
                  ),
                  decoration: InputDecoration(
                      hintText: "End Location",
                      hintStyle: TextStyle(
                          color: Colors.grey
                      )
                  ),
                  onTap: () async {
                    endLocationCo = await Navigator.push(context,
                        MaterialPageRoute(
                            builder: (context) => LocationScreen()));
                    print("*** endlocation = ${endLocationCo} ***");
                    endLat = double.parse(endLocationCo[0]);
                    endLong = double.parse(endLocationCo[1]);
                    endName = endLocationCo[2];
                    if (endName != null) {
                      print("!!!!!!!!!! ${endName} ==== ${endLat} ==tartLong}");
                      endlocation.text = endName!;
                      updateMarkerPositionM2(endLat!, endLong!);
                      updatePolyLine(startLat!, startLong!, endLat!, endLong!);
                    }
                  },
                )
                )
              ],
            ),
          ),
          SizedBox(height: 10),
          ElevatedButton(onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => lastScreen()));
          },
              style: ElevatedButton.styleFrom(
                  backgroundColor: hexToColor("#1E847F"),
                  fixedSize: Size(130, 40),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)
                  )
              ),
              child:
              Text("Proceed")),
          SizedBox(height: 10),
        ],
      ),
    );
  }

}




Widget modeSelector(){


  var advanceSearch;
  return Visibility(
    visible: true,
      child: Container(
        height: 70,
        decoration: BoxDecoration(
          color: hexToColor("#777777"),
              borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(width: 20),
            ToggleSwitch(
              minWidth: 90.0,
              initialLabelIndex: 1,
              cornerRadius: 20.0,
              activeBgColor: [hexToColor("#1E847F")],
              // activebgColor: hexToColor("#1E847F"),
              inactiveBgColor: Colors.grey,
              inactiveFgColor: Colors.white,
              totalSwitches: 2,
              labels: ['Find Pool','Offer Pool'],
              onToggle: (index){
                if(index==0){
                  passenger=true;
                }else{
                  passenger=false;
                }
                print("switched to: $index and passenger value is $passenger");
              },
            ),
            CheckboxWidget()

          ],
        ),
      )
  );
}


class LocationTextField extends StatelessWidget {
  final IconData icon;
  final String hintText;

  LocationTextField({required this.icon, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(icon, color: Colors.blue),
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
class CheckboxWidget extends StatefulWidget {
@override
_CheckboxWidgetState createState() => _CheckboxWidgetState();
}

class _CheckboxWidgetState extends State<CheckboxWidget> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          value: isChecked,
          onChanged: (newValue) {
            setState(() {
              isChecked = newValue!;
            });
          },
            activeColor: hexToColor("#1e847f"),
        ),
        SizedBox(height: 10),
        Text('Advance Search',style: TextStyle(fontWeight: FontWeight.bold,
        fontSize: 16),),
      ],
    );
  }
}
