// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_User _$_$_UserFromJson(Map<String, dynamic> json) {
  return _$_User(
    displayName: json['displayName'] as String,
    email: json['email'] as String,
    photoURL: json['photoURL'] as String,
    features: json['features'] as Map<String, dynamic> ?? {},
    createdAt: const DateTimeConverter().fromJson(json['createdAt']),
    updatedAt: const DateTimeConverter().fromJson(json['updatedAt']),
    lastCharacterId: json['lastCharacterId'] as String,
  );
}

Map<String, dynamic> _$_$_UserToJson(_$_User instance) => <String, dynamic>{
      'displayName': instance.displayName,
      'email': instance.email,
      'photoURL': instance.photoURL,
      'features': instance.features,
      'createdAt': const DateTimeConverter().toJson(instance.createdAt),
      'updatedAt': const DateTimeConverter().toJson(instance.updatedAt),
      'lastCharacterId': instance.lastCharacterId,
    };
