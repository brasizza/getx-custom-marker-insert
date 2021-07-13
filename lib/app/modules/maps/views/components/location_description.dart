import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:places/app/data/model/map_location.dart';
import 'package:places/app/modules/maps/controllers/maps_controller.dart';
import 'package:places/app/modules/maps/views/components/location_description_controller.dart';

class LocationDescriptionPage extends GetView<LocationDesriptionController> {
  final MapLocation location;

  LocationDescriptionPage({Key? key, required this.location}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              location.locatioName,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ),
          (location.locationImage == "")
              ? Image.asset('assets/images/dash.png')
              : Image.memory(
                  File(location.locationImage).readAsBytesSync(),
                  width: 300,
                  height: 300,
                  fit: BoxFit.scaleDown,
                ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(location.locationDescription),
            ),
          ),
          ElevatedButton(
              onPressed: () {
                controller.deleteLocation(location);
              },
              child: Text("Delete this location!"))
        ],
      ),
    );
  }
}
