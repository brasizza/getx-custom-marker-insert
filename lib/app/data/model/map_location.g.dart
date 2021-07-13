// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'map_location.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MapLocationAdapter extends TypeAdapter<MapLocation> {
  @override
  final int typeId = 0;

  @override
  MapLocation read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return MapLocation(
      id: fields[0] as String,
      locatioName: fields[1] as String,
      locationDescription: fields[2] as String,
      locationImage: fields[3] as String,
      latitude: fields[4] as double,
      longitude: fields[5] as double,
    );
  }

  @override
  void write(BinaryWriter writer, MapLocation obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.locatioName)
      ..writeByte(2)
      ..write(obj.locationDescription)
      ..writeByte(3)
      ..write(obj.locationImage)
      ..writeByte(4)
      ..write(obj.latitude)
      ..writeByte(5)
      ..write(obj.longitude);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MapLocationAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MapLocation _$MapLocationFromJson(Map<String, dynamic> json) {
  return MapLocation(
    id: json['id'] as String,
    locatioName: json['location_name'] as String,
    locationDescription: json['location_description'] as String,
    locationImage: json['location_image'] as String,
    latitude: (json['latitude'] as num).toDouble(),
    longitude: (json['longitude'] as num).toDouble(),
  );
}

Map<String, dynamic> _$MapLocationToJson(MapLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'location_name': instance.locatioName,
      'location_description': instance.locationDescription,
      'location_image': instance.locationImage,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
