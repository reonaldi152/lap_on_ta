import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'product.g.dart';

@JsonSerializable()
class Product {
  Product({this.productId, this.nameProduct, this.image, this.categoryMarketplaceId, this.description, this.price, this.stock, this.createdAt, this.updatedAt, this.deletedAt});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  @JsonKey(name: 'product_id')
  final dynamic productId;
  @JsonKey(name: 'name_product')
  final dynamic nameProduct;
  final dynamic image;
  @JsonKey(name: 'category_marketplace_id')
  final dynamic categoryMarketplaceId;
  final dynamic description;
  final dynamic price;
  final dynamic stock;
  @JsonKey(name: 'created_at')
  final dynamic createdAt;
  @JsonKey(name: 'updated_at')
  final dynamic updatedAt;
  @JsonKey(name: 'deleted_at')
  final dynamic deletedAt;

  @override
  String toString() => json.encode(this);
}
