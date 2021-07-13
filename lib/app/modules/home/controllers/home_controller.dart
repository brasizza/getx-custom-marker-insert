import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:places/app/core/loading_widget.dart';
import 'package:places/app/data/repository/home_repository.dart';
import 'package:places/app/modules/maps/controllers/maps_controller.dart';

class HomeController extends GetxController {
  MapsController mapsController = Get.find<MapsController>();
  final HomeRepoisotry repository;

  HomeController(this.repository);
  @override
  void onInit() async {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> addMarkerCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);

      mapsController.userLocation = position;
      mapsController.addNewPosition(LatLng(position.latitude, position.longitude));
    } on Exception catch (_) {}
  }

  void removeAllMarkers() async {
    bool? remove = await Get.defaultDialog(
      title: "Remove all markers",
      content: Text(
        "Are you sure you want to delete all markers?",
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
      mapsController.clearAllMarkers();
    }
  }

  Future<List<Prediction>> findAddress(String pattern, {String language = 'en'}) async {
    if (pattern.length > 3) {
      return await repository.findAddress(pattern, language: language);
    } else {
      return [];
    }
  }

  Future selectSuggestion(Prediction suggestion) async {
    Get.dialog(LoadingWidget());
    PlacesDetailsResponse detail = await repository.getGooglePlacesDetail(suggestion.placeId ?? '');
    Get.close(1);
    Get.find<MapsController>().addNewPosition(LatLng(detail.result.geometry!.location.lat, detail.result.geometry!.location.lng));
  }
}
