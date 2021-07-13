import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/maps_controller.dart';

class MapsView extends GetView<MapsController> {
  @override
  Widget build(BuildContext context) {
    return Obx(() => GoogleMap(
          initialCameraPosition: CameraPosition(
            target: LatLng(
              controller.userLocation.latitude,
              controller.userLocation.longitude,
            ),
            zoom: 2,
          ),
          myLocationButtonEnabled: true,
          markers: controller.markers,
          myLocationEnabled: true,
          onLongPress: (LatLng position) async {
            await controller.addNewPosition(position);
          },
        ));
  }
}
