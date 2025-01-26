import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'category_marketplace.g.dart';

@JsonSerializable()
class CategoryMarketplace {
  CategoryMarketplace({this.id, this.name,this.createdAt, this.updatedAt});

  factory CategoryMarketplace.fromJson(Map<String, dynamic> json) => _$CategoryMarketplaceFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryMarketplaceToJson(this);

  final dynamic id;
  final dynamic name;
  @JsonKey(name: 'created_at')
  final dynamic createdAt;
  @JsonKey(name: 'updated_at')
  final dynamic updatedAt;

  @override
  String toString() => json.encode(this);

}