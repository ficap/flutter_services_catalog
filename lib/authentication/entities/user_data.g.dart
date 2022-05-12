part of 'user_data.dart';

UserDataModel _$UserDataModelFromJson(Map<String, dynamic> json) =>
    UserDataModel(
      json['id'] as String,
      json['name'] as String,
      json['serviceType'] as String,
      json['email'] as String? ?? '',
      json['imagePath'] as String? ?? '',
      json['about'] as String? ?? '',
    );

Map<String, dynamic> _$UserDataModelToJson(UserDataModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'serviceType': instance.serviceType,
    'email': instance.email,
    'imagePath': instance.imagePath,
    'about': instance.about,
  };

  return val;
}
