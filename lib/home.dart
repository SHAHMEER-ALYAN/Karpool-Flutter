import 'location_screen.dart';
import 'package:flutter/material.dart';
import "package:google_maps_flutter/google_maps_flutter.dart";
import "main.dart";
import "package:toggle_switch/toggle_switch.dart";

void main() {
  runApp(home());
}
var startLocationCo;
TextEditingController startlocation = TextEditingController();
TextEditingController endlocation = TextEditingController();
double startLat = 24.8674;
double startLong = 67.1962;
// double? startLat;
// double? startLong;
String? startName;
bool show=false;
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

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  bool showSecondBox = false;
  int _currentIndex = 0;


  @override
  Widget build(BuildContext context) {
    final location = ModalRoute.of(context)!.settings.arguments;
    return Scaffold(
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
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
}


  Container Map(context){
  return Container(
    height: MediaQuery.of(context).size.height/1.8,
    width: MediaQuery.of(context).size.width,
    child: GoogleMap(
      myLocationEnabled: true,
      initialCameraPosition: CameraPosition(
        target: LatLng(24.8674,67.1962),
        zoom: 15,
      ),

      markers: {
        Marker(
            markerId: const MarkerId("marker1"),
            position: LatLng(24.8674,67.1962!),
            draggable: true,
            onDragEnd: (value){
              locationTesting1 = value;
            },
        ),
        const Marker(
          markerId: MarkerId("marker2"),
          position: LatLng(24.8674,67.1962),
        )
      },
    ),
  );
  }

Container locationBox(context){
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
            child: Icon(Icons.location_pin,color: Colors.red,)
              ,),
            Expanded(
                child: TextField(
                  autofocus: false,
                controller: startlocation,
                decoration: InputDecoration(
                hintText: "Start Location",
                hintStyle: TextStyle(
                    color: Colors.grey
                 )
               ),
                  onTap: () async {
                  startLocationCo = await Navigator.push(context,
                      MaterialPageRoute(
                          builder: (context)=>LocationScreen()));
                          if(startLocationCo != null && startLocationCo.length == 3){
                            startLat = startLocationCo[0];
                            startLong = startLocationCo[1];
                            startName = startLocationCo[2];
                            startlocation.text= startName!;

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
                child: Icon(Icons.location_pin,color: Colors.green,)
                ,),
              Expanded(child: TextField(
                controller: endlocation,
                decoration: InputDecoration(
                    hintText: "End Location",
                    hintStyle: TextStyle(
                        color: Colors.grey
                    )
                ),
              )
              )
            ],
          ),
        ),
        SizedBox(height: 10),
        ElevatedButton(onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: hexToColor("#1E847F"),
              fixedSize: Size(130,40),
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
                print("switched to: $index");
              },
            ),
            CheckboxWidget()

          ],
        ),
      )
  );
}

// bool check(){
//
//   if(startlocation.text!=null && endlocation.text!=null){
//     show=true;
//   return show;
//   }else
//     return show;
// }

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
