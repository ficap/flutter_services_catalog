import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'provider_model.g.dart';

GeoPoint identity(GeoPoint value) {
  return value;
}


@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ProviderModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'address')
  final String address;
  @JsonKey(name: 'serviceType')
  final String serviceType;
  @JsonKey(name: 'phone', defaultValue: "")
  final String phone;
  @JsonKey(name: 'email', defaultValue: "")
  final String email;
  @JsonKey(name: 'geopoint', toJson: identity, fromJson: identity)
  final GeoPoint geopoint;
  @JsonKey(name: 'imagePath', defaultValue: "")
  final String imagePath;


  ProviderModel.id(this.name, this.address, this.serviceType, this.geopoint, this.phone, this.email, this.imagePath) : id = const Uuid().v1();

  const ProviderModel({required this.id, required this.name, required this.address, required this.serviceType, required this.geopoint, required this.phone, required this.email, required this.imagePath});

  factory ProviderModel.fromJson(Map<String, dynamic> json) => _$ProviderModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProviderModelToJson(this);

}
