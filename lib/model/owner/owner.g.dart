// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'owner.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Owner _$OwnerFromJson(Map<String, dynamic> json) => Owner(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone: json['phone'],
      photoProfile: json['photo_profile'],
      photoKTP: json['photo_ktp'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );

Map<String, dynamic> _$OwnerToJson(Owner instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'photo_profile': instance.photoProfile,
      'photo_ktp': instance.photoKTP,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
