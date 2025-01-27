import 'dart:convert';

import 'package:flutter_lapon/model/venue/venue.dart';
import 'package:json_annotation/json_annotation.dart';

part 'transaction.g.dart';

@JsonSerializable()
class Transaction {
  Transaction({this.id, this.transactionId, this.userId, this.venueId, this.bookingId, this.total, this.status, this.paymentUrl, this.taxPercentage, this.createdAt, this.updatedAt, this.deletedAt, this.venue});

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);

  Map<String, dynamic> toJson() => _$TransactionToJson(this);

  final dynamic id;
  @JsonKey(name: 'transaction_id')
  final dynamic transactionId;
  @JsonKey(name: 'user_id')
  final dynamic userId;
  @JsonKey(name: 'venue_id')
  final dynamic venueId;
  @JsonKey(name: 'booking_id')
  final dynamic bookingId;
  final dynamic total;
  final dynamic status;
  @JsonKey(name: 'payment_url')
  final dynamic paymentUrl;
  @JsonKey(name: 'tax_percentage')
  final dynamic taxPercentage;
  @JsonKey(name: 'created_at')
  final dynamic createdAt;
  @JsonKey(name: 'updated_at')
  final dynamic updatedAt;
  @JsonKey(name: 'deleted_at')
  final dynamic deletedAt;
  final Venue? venue;

  @override
  String toString() => json.encode(this);
}
