
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'provider_user_data.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class ProviderUserDataModel {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'name')
  final String name;
  @JsonKey(name: 'serviceType')
  final String serviceType;
  @JsonKey(name: 'email', defaultValue: "")
  final String email;
  @JsonKey(name: 'imagePath', defaultValue: "")
  final String imagePath;
  @JsonKey(name: 'about', defaultValue: "")
  final String about;

  ProviderUserDataModel.id(this.name, this.serviceType, this.email, this.imagePath, this.about) : id = const Uuid().v1();

  const ProviderUserDataModel(this.id, this.name, this.serviceType, this.email, this.imagePath, this.about);

  factory ProviderUserDataModel.fromJson(Map<String, dynamic> json) => _$ProviderUserDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProviderUserDataModelToJson(this);

}
