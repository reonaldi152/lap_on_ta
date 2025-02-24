// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      productId: json['product_id'],
      nameProduct: json['name_product'],
      image: json['image'],
      categoryMarketplaceId: json['category_marketplace_id'],
      description: json['description'],
      price: json['price'],
      stock: json['stock'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      deletedAt: json['deleted_at'],
      variations: json['variations'] as List<dynamic>?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'product_id': instance.productId,
      'name_product': instance.nameProduct,
      'image': instance.image,
      'category_marketplace_id': instance.categoryMarketplaceId,
      'description': instance.description,
      'price': instance.price,
      'stock': instance.stock,
      'variations': instance.variations,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'deleted_at': instance.deletedAt,
    };
