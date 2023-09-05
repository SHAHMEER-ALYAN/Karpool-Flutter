import 'package:flutter/material.dart';
import 'package:google_places_flutter/google_places_flutter.dart';
import 'package:google_places_flutter/model/prediction.dart';
import 'main.dart';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  TextEditingController controller = TextEditingController();
  double? selectedLatitude;
  double? selectedLongitude;
  String? selectedLocation;


  @override
  Widget build(BuildContext context) {
    double hh = MediaQuery.of(context).size.height/5;


    return Scaffold(
      backgroundColor: hexToColor("#121212"),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            
            SizedBox(height: hh),
            placesAutoCompleteTextField(),
          ],
        ),
      ),
    );
  }

  placesAutoCompleteTextField() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: GooglePlaceAutoCompleteTextField(
        textEditingController: controller,
        googleAPIKey: "PASTE_API_HERE", // Replace with your API key
        textStyle: TextStyle(color: Colors.white),
        inputDecoration: InputDecoration(
          hintText: "Search your location",
          hintStyle: TextStyle(color: Colors.white),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
        ),
        debounceTime: 400,
        countries: ["pk"],
        isLatLngRequired: true, // Set this to true to get lat/lng
        getPlaceDetailWithLatLng: (Prediction prediction) {
          print("Latitude: ${prediction.lat}, Longitude: ${prediction.lng}");
        },
        itemClick: (Prediction prediction) {
          controller.text = prediction.description ?? "";
          controller.selection = TextSelection.fromPosition(
              TextPosition(offset: prediction.description?.length ?? 0));
          selectedLatitude = prediction.lat as double?;
          selectedLongitude = prediction.lng as double?;
          selectedLocation = prediction.description;
          if(selectedLocation!=null){
          Navigator.pop(context,[selectedLatitude,selectedLongitude,selectedLocation]);
          }
        },
        seperatedBuilder: Divider(
          height: 5,
          color: Colors.white,
        ),
        itemBuilder: (context, index, Prediction prediction) {
          return Container(
            decoration: BoxDecoration(
              color: hexToColor("#121212")
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              children: [
                Icon(Icons.location_pin, color: Colors.white,),
                SizedBox(
                  width: 10,
                ),
                Expanded(child: Text("${prediction.description ?? ""}",
                style: TextStyle(color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold),))
              ],
            ),
          );
        },
        isCrossBtnShown: true,
      ),
    );
  }
}
