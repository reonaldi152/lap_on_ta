import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel {
  BannerModel({this.id, this.title, this.imageUrl, this.linkUrl, this.createdAt, this.updatedAt});

  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);

  Map<String, dynamic> toJson() => _$BannerModelToJson(this);

  final dynamic id;
  final dynamic title;
  @JsonKey(name: 'image_url')
  final dynamic imageUrl;
  @JsonKey(name: 'link_url')
  final dynamic linkUrl;
  @JsonKey(name: 'created_at')
  final dynamic createdAt;
  @JsonKey(name: 'updated_at')
  final dynamic updatedAt;

  @override
  String toString() => json.encode(this);

}