// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'provider_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProviderModel _$ProviderModelFromJson(Map<String, dynamic> json) =>
    ProviderModel(
      json['id'] as String,
      json['name'] as String,
      json['address'] as String,
      json['serviceType'] as String,
      identity(json['geopoint'] as GeoPoint),
      json['phone'] as String? ?? '',
      json['email'] as String? ?? '',
    );

Map<String, dynamic> _$ProviderModelToJson(ProviderModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'address': instance.address,
    'serviceType': instance.serviceType,
    'phone': instance.phone,
    'email': instance.email,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('geopoint', identity(instance.geopoint));
  return val;
}
