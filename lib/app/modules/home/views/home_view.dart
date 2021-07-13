import 'package:flutter/material.dart';
import 'package:fluttericon/font_awesome5_icons.dart';

import 'package:get/get.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:places/app/modules/maps/views/maps_view.dart';

import '../controllers/home_controller.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class HomeView extends GetView<HomeController> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Material(
            elevation: 10,
            borderRadius: BorderRadius.circular(20),
            child: TypeAheadField(
              textFieldConfiguration: TextFieldConfiguration(
                controller: _searchController,
                decoration: InputDecoration(
                    hintText: "Search some address",
                    prefixIcon: Icon(Icons.location_on, color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(style: BorderStyle.none),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(style: BorderStyle.none),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(style: BorderStyle.none),
                    )),
              ),
              itemBuilder: (BuildContext context, Prediction itemData) {
                return ListTile(
                  leading: Icon(Icons.location_on),
                  title: Text(itemData.description!),
                );
              },
              onSuggestionSelected: (Prediction suggestion) async {
                _searchController.clear();
                controller.selectSuggestion(suggestion);
              },
              suggestionsCallback: (String pattern) async {
                return await controller.findAddress(pattern);
              },
            ),
          ),
        ),
        elevation: 0.0,
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: MapsView(),
      floatingActionButton: FloatingActionButton(
        child: Icon(FontAwesome5.map_pin),
        onPressed: () async {
          await controller.addMarkerCurrentLocation();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: Row(
        children: [
          IconButton(
              onPressed: () {
                controller.removeAllMarkers();
              },
              icon: Icon(
                FontAwesome5.times_circle,
                size: 40,
                color: Colors.red,
              )),
        ],
      ),
    );
  }
}
