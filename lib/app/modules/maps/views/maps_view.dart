import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:places/app/modules/maps/views/components/new_location_controller.dart';

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
            zoom: 14,
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
