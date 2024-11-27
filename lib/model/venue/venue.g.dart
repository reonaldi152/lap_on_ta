// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'venue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Venue _$VenueFromJson(Map<String, dynamic> json) => Venue(
      id: json['id'],
      ownerId: json['owner_id'],
      categoryId: json['category_id'],
      name: json['name'],
      description: json['description'],
      image: json['image'],
      address: json['address'],
      price: json['price'],
      owner: json['owner'] == null
          ? null
          : Owner.fromJson(json['owner'] as Map<String, dynamic>),
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      linkMaps: json['link_maps'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );

Map<String, dynamic> _$VenueToJson(Venue instance) => <String, dynamic>{
      'id': instance.id,
      'owner_id': instance.ownerId,
      'category_id': instance.categoryId,
      'name': instance.name,
      'description': instance.description,
      'image': instance.image,
      'address': instance.address,
      'price': instance.price,
      'owner': instance.owner,
      'category': instance.category,
      'link_maps': instance.linkMaps,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
    };
