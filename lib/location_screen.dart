import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class LocationScreen extends StatefulWidget {
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  TextEditingController locationController = TextEditingController();
  List<String> locationResults = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Screen'),
      ),
      body: Column(
        children: <Widget>[
          TextField(
            controller: locationController,
            decoration: InputDecoration(
              hintText: 'Enter a location',
            ),
            onChanged: (text) {
              _searchLocation(text);
            },
          ),
          Expanded(
            child: ListView.builder(
              itemCount: locationResults.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(locationResults[index]),
                  onTap: () {
                    // Handle selection of a location result here
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _searchLocation(String query) async {
    const apiUrl = 'com.google.android.geo.API_KEY';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['status'] == 'OK') {
        setState(() {
          locationResults =
          List<String>.from(data['predictions'].map((result) => result['description']));
        });
      }
    }
  }
}
