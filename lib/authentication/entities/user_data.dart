
import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:uuid/uuid.dart';

part 'user_data.g.dart';

@immutable
@JsonSerializable(explicitToJson: true, includeIfNull: false)
class UserDataModel {
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

  UserDataModel.id(this.name, this.serviceType, this.email, this.imagePath, this.about) : id = const Uuid().v1();

  const UserDataModel(this.id, this.name, this.serviceType, this.email, this.imagePath, this.about);

  factory UserDataModel.fromJson(Map<String, dynamic> json) => _$UserDataModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserDataModelToJson(this);

}
