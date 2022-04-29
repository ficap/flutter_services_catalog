part of 'provider_user_data.dart';

ProviderUserDataModel _$ProviderUserDataModelFromJson(Map<String, dynamic> json) =>
    ProviderUserDataModel(
      json['id'] as String,
      json['name'] as String,
      json['serviceType'] as String,
      json['email'] as String? ?? '',
      json['imagePath'] as String? ?? '',
      json['about'] as String? ?? '',
    );

Map<String, dynamic> _$ProviderUserDataModelToJson(ProviderUserDataModel instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'name': instance.name,
    'serviceType': instance.serviceType,
    'email': instance.email,
    'imagePath': instance.imagePath,
    'about': instance.about,
  };
  // void writeNotNull(String key, dynamic value) {
  //   if (value != null) {
  //     val[key] = value;
  //   }
  // }

  return val;
}
