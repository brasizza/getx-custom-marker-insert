import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:places/app/data/model/map_location.dart';
import 'package:places/app/modules/maps/controllers/maps_controller.dart';

class LocationDesriptionController extends GetxController {
  final MapsController mapsController = Get.find<MapsController>();

  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;

  void deleteLocation(MapLocation location) async {
    bool? remove = await Get.defaultDialog(
      title: "Remove location",
      content: Text(
        "Are you sure you want to remove this location?",
      ),
      confirm: OutlinedButton(
          onPressed: () {
            Get.back(result: true);
          },
          child: Text("Yes!")),
      cancel: OutlinedButton(
          onPressed: () {
            Get.back(result: false);
          },
          child: Text("No!")),
    );

    if (remove != false && remove != null) {
      mapsController.removeLocation(location);
    }
  }
}
