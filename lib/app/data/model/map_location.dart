import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';

part 'map_location.g.dart';

@JsonSerializable()
@HiveType(typeId: 0)
class MapLocation extends HiveObject {
  @HiveField(0)
  late String id;

  @JsonKey(name: 'location_name')
  @HiveField(1)
  late String locatioName;

  @JsonKey(name: 'location_description')
  @HiveField(2)
  late String locationDescription;

  @JsonKey(name: 'location_image')
  @HiveField(3)
  late String locationImage;

  @JsonKey()
  @HiveField(4)
  late double latitude;

  @JsonKey()
  @HiveField(5)
  late double longitude;
  MapLocation({
    required this.id,
    required this.locatioName,
    required this.locationDescription,
    required this.locationImage,
    required this.latitude,
    required this.longitude,
  });

  factory MapLocation.fromJson(Map<String, dynamic> json) => _$MapLocationFromJson(json);
  Map<String, dynamic> toJson() => _$MapLocationToJson(this);

  // Hive fields go here
}
