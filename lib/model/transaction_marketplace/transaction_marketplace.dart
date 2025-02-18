import 'dart:convert';

import 'package:flutter_lapon/model/booking/booking.dart';
import 'package:flutter_lapon/model/product/product.dart';
import 'package:flutter_lapon/model/user/user.dart';
import 'package:flutter_lapon/model/venue/venue.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction_marketplace.g.dart';

@JsonSerializable()
class TransactionMarketplace {
  TransactionMarketplace({this.id, this.transactionId, this.userId,this.total, this.status, this.paymentUrl, this.createdAt, this.updatedAt, this.deletedAt, this.product, this.user, this.productId,this.shipping_status});

  factory TransactionMarketplace.fromJson(Map<String, dynamic> json) => _$TransactionMarketplaceFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionMarketplaceToJson(this);

  final dynamic id;
  @JsonKey(name: 'transaction_id')
  final dynamic transactionId;
  @JsonKey(name: 'user_id')
  final dynamic userId;
  @JsonKey(name: 'product_id')
  final dynamic productId;
  final dynamic total;
  final dynamic status;
  @JsonKey(name: 'payment_url')
  final dynamic paymentUrl;
  @JsonKey(name: 'created_at')
  final dynamic createdAt;
  @JsonKey(name: 'updated_at')
  final dynamic updatedAt;
  @JsonKey(name: 'deleted_at')
  final dynamic deletedAt;
  final Product? product;
  final Users? user;
  final dynamic shipping_status;

  @override
  String toString() => json.encode(this);
}
