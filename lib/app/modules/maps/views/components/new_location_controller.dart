import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:places/app/core/consts.dart';
import 'package:places/app/data/model/map_location.dart';

class NewLocationController extends GetxController {
  Rxn<Uint8List> _imageByte = Rxn<Uint8List>();
  Uint8List? get imageByte => this._imageByte.value;
  set imageByte(Uint8List? newValue) => this._imageByte.value = newValue;

  Rxn<XFile> _previewFile = Rxn<XFile>();
  XFile? get previewFile => this._previewFile.value;
  set previewFile(XFile? newValue) {
    this._previewFile.value = newValue;
    if (newValue != null) {
      newValue.readAsBytes().then((value) async {
        imageByte = value;
      });
    }
  }

  Future<String?> _saveFile() async {
    String path = (await getApplicationDocumentsDirectory()).path;

    if (previewFile != null) {
      final String fileName = DateTime.now().microsecondsSinceEpoch.toString();
      final File _previewImage = File(previewFile!.path);
      final File localImage = await _previewImage.copy('$path/$fileName');
      print(localImage.path);

      return localImage.path;
    } else {
      return null;
    }

    // final File _previewImage = File.fromRawPath(await previewFile.readAsBytes());
    // final File localImage = await image.copy('$path/$fileName');
  }

  Future<bool> saveMarker(String locatioName, String locationDescription, double latitude, double longitude) async {
    late final boxMap;
    try {
      boxMap = Get.find<Box<MapLocation>>(tag: MAP_LOCATION);

      String? path = await _saveFile();

      boxMap.add(
        MapLocation(
          id: DateTime.now().microsecond.toString(),
          latitude: latitude,
          longitude: longitude,
          locatioName: locatioName,
          locationDescription: locationDescription,
          locationImage: path ?? '',
        ),
      );

      return true;
      // boxMap.add(value)
    } on Exception catch (_) {
      print("OPS!");
      return false;
    }
  }
}
