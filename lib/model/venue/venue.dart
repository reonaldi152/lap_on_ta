import 'dart:convert';

import 'package:flutter_lapon/model/owner/owner.dart';
import 'package:json_annotation/json_annotation.dart';

import '../category/category.dart';

part 'venue.g.dart';

@JsonSerializable()
class Venue {
  Venue({this.id, this.ownerId, this.categoryId, this.name, this.description, this.image, this.address,this.price, this.owner, this.category, this.linkMaps, this.createdAt, this.updatedAt});

  factory Venue.fromJson(Map<String, dynamic> json) => _$VenueFromJson(json);

  Map<String, dynamic> toJson() => _$VenueToJson(this);

  final dynamic id;
  @JsonKey(name: 'owner_id')
  final dynamic ownerId;
  @JsonKey(name: 'category_id')
  final dynamic categoryId;
  final dynamic name;
  final dynamic description;
  final dynamic image;
  final dynamic address;
  final dynamic price;
  final Owner? owner;
  final Category? category;
  @JsonKey(name: 'link_maps')
  final dynamic linkMaps;
  @JsonKey(name: 'created_at')
  final dynamic createdAt;
  @JsonKey(name: 'updated_at')
  final dynamic updatedAt;


  @override
  String toString() => json.encode(this);

}