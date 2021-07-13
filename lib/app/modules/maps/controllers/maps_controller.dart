import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hive/hive.dart';
import 'package:places/app/core/consts.dart';
import 'package:places/app/data/model/map_location.dart';
import 'package:places/app/modules/maps/views/components/location_description.dart';
import 'package:places/app/modules/maps/views/components/location_description_controller.dart';
import 'package:places/app/modules/maps/views/components/new_location.dart';
import 'package:places/app/modules/maps/views/components/new_location_controller.dart';

class MapsController extends GetxController {
  final _userLocation = Get.find<Position>(tag: MY_LOCATION).obs;
  Position get userLocation => this._userLocation.value;
  set userLocation(Position newLocation) => this._userLocation.value = newLocation;

  MapsController();

  Rx<Set<Marker>> _markers = Rx<Set<Marker>>({});
  Set<Marker> get markers => this._markers.value;

  @override
  void onInit() async {
    super.onInit();
    getMarkers();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}

  Future<void> addNewPosition(LatLng position) async {
    await Get.delete<NewLocationController>();
    Get.put<NewLocationController>(NewLocationController());
    bool? created = await Get.dialog(
      Dialog(
        child: NewLocationPage(position),
      ),
    );

    if ((created ?? false) == true) {
    } else {}
  }

  Future<void> getMarkers() async {
    final boxMap = Get.find<Box<MapLocation>>(tag: MAP_LOCATION);
    _markers.value.clear();
    await Future.forEach(boxMap.values, (MapLocation val) async {
      Marker marker = await _generateMarker(val);
      _markers.value.add(marker);
    });
    _markers.refresh();
  }

  Future<Marker> _generateMarker(MapLocation mapLocation) async {
    late BitmapDescriptor _icon;
    _icon = await _markerCusomImage(mapLocation.locationImage);
    Marker marker = Marker(
        markerId: MarkerId(mapLocation.hashCode.toString()),
        position: LatLng((mapLocation.latitude), mapLocation.longitude),
        icon: (_icon),
        onTap: () {
          Get.create(() => LocationDesriptionController());
          Get.dialog(Dialog(
            child: LocationDescriptionPage(
              location: mapLocation,
            ),
          ));
        });
    return marker;
  }

  static Future<Uint8List> readFileBytes(String path) async {
    ByteData fileData = await rootBundle.load(path);
    Uint8List fileUnit8List = fileData.buffer.asUint8List(fileData.offsetInBytes, fileData.lengthInBytes);
    return fileUnit8List;
  }

  Future<Uint8List> _getImageFromAsset(String iconPath) async {
    return await readFileBytes("./assets/images/$iconPath.png");
  }

  Future<BitmapDescriptor> _markerCusomImage(String placePicture) async {
    late Uint8List _imageByte;
    if (placePicture == "") {
      _imageByte = await _getImageFromAsset('dash');
    } else {
      try {
        _imageByte = File(placePicture).readAsBytesSync();
      } catch (_) {
        _imageByte = await _getImageFromAsset('dash');
      }
    }
    final int targetWidth = 80;

    final Codec markerImageCodec = await instantiateImageCodec(
      _imageByte,
      targetWidth: targetWidth,
    );
    final FrameInfo frameInfo = await markerImageCodec.getNextFrame();
    final ByteData? byteData = await frameInfo.image.toByteData(
      format: ImageByteFormat.png,
    );
    final Uint8List resizedMarkerImageBytes = byteData!.buffer.asUint8List();
    return BitmapDescriptor.fromBytes(resizedMarkerImageBytes);
  }

  void clearAllMarkers() async {
    await Get.find<Box<MapLocation>>(tag: MAP_LOCATION).clear();
    getMarkers();
  }

  void removeLocation(MapLocation location) async {
    await location.delete();
    Get.close(0);
    getMarkers();
  }
}
