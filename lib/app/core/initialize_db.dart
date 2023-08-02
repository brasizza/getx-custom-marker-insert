import 'package:get/instance_manager.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:places/app/core/consts.dart';
import 'package:places/app/data/model/map_location.dart';

class InitializeDatabase {
  static Future<void> initialize() async {
    await Hive.initFlutter();
    //Create an Adapter to MyMapLocations
    Hive.registerAdapter(MapLocationAdapter());
    // await Hive.deleteBoxFromDisk(MAP_LOCATION);
    final Box<MapLocation> mapLocation = await Hive.openBox<MapLocation>(MAP_LOCATION);
    Get.put<Box<MapLocation>>(mapLocation, tag: MAP_LOCATION, permanent: true);
    //Open the Hive box and put into Getx!
  }
}
