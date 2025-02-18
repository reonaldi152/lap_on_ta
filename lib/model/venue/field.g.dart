// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Field _$FieldFromJson(Map<String, dynamic> json) => Field(
      id: json['id'],
      venueID: json['venue_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      price: json['price'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );

Map<String, dynamic> _$FieldToJson(Field instance) => <String, dynamic>{
      'id': instance.id,
      'venue_id': instance.venueID,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'price': instance.price,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
